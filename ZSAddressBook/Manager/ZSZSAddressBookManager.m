//
//  ZSZSAddressBookManager.m
//
//  Created by ZS on 2018/8/8.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSZSAddressBookManager.h"
#import "ZSZSAddressBookAPI.h"
#import "ZSModule.h"

static NSString *ZSZSAddressBookCacheFileName = @"cache";

@interface ZSZSAddressBookManager ()

@property (nonatomic, strong) NSArray<id<ZSModule>> *modules;
@property (nonatomic, strong) NSString *cacheDir;

@end

@implementation ZSZSAddressBookManager

- (instancetype)init
{
    if (self = [super init]) {
        [self _setupCacheDir];
    }
    
    return self;
}

- (void)_setupCacheDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    if (paths.count == 0) {
        _cacheDir = nil;
        return;
    }
    
    NSString *supportPath = [paths objectAtIndex:0];
    _cacheDir = [supportPath stringByAppendingPathComponent:@"ZSAddressBook"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:_cacheDir]) {
        [fileManager createDirectoryAtPath:_cacheDir
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
}

- (id<ZSModule>)moduleAtIndex:(NSInteger)index
{
    if (self.modules.count > index) {
        return self.modules[index];
    }
    
    return nil;
}

- (NSInteger)moduleCount
{
    return self.modules.count;
}

#pragma mark - Load Cache Data

- (void)loadCacheData:(void (^)(NSError *error, id result))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *cacheData = [NSData dataWithContentsOfFile:[self->_cacheDir stringByAppendingPathComponent:ZSZSAddressBookCacheFileName]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _loadCacheDataSuccess:cacheData callback:callback];
        });
    });
}

- (void)_loadCacheDataSuccess:(NSData *)result
                     callback:(void (^)(NSError *error, id result))callback
{
    NSDictionary *cacheData = [NSKeyedUnarchiver unarchiveObjectWithData:result];
    if (![cacheData isKindOfClass:NSDictionary.class]) {
        if (callback) {
            callback([NSError errorWithDomain:NSStringFromClass(self.class)
                                             code:-1
                                         userInfo:nil],
                         nil);
        }
        return;
    }
    
    NSError *analyzeError = nil;
    [self _handleResponeData:cacheData
                      isMore:NO
                       error:&analyzeError];
    
    if (callback) {
        callback(analyzeError, nil);
    }
}

- (void)_loadCacheDataFailure:(NSError *)error callback:(void (^)(NSError *error, id result))callback
{
    if (callback) {
        callback(error, nil);
    }
}

- (void)_storageData:(id)data
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:data];
        NSString *path = [self->_cacheDir stringByAppendingPathComponent:ZSZSAddressBookCacheFileName];
        [archivedData writeToFile:path options:NSDataWritingAtomic error:nil];
    });
}

#pragma mark - Request Net Data

- (void)requestNetData:(void (^)(NSError *error, id result))callback
{
    [self _requestNetDataWithCallback:callback
                               isMore:NO];
}

- (void)requestNetMoreData:(void (^)(NSError *error, id result))callback
{
    [self _requestNetDataWithCallback:callback
                               isMore:YES];
}

- (void)_requestNetDataWithCallback:(void (^)(NSError *error, id result))callback isMore:(BOOL)isMore
{
#warning set params if need
    __typeof(self) __weak manager = self;
    [ZSZSAddressBookAPI requestZSAddressBookWithParams:nil
                                  completion:^(NSError *error, id result) {
                                      [manager _handleRequestNetDataCompletion:result
                                                                         error:error
                                                                        isMore:isMore
                                                                      callback:callback];
                                  }];
}

- (void)_handleRequestNetDataCompletion:(id)result
                                  error:(NSError *)error
                                 isMore:(BOOL)isMore
                               callback:(void (^)(NSError *error, id result))callback
{
    if (error) {
        if (callback) {
            callback(error, nil);
        }
    }
    else {
        [self _storageData:result];
        NSError *analyzeError = nil;
        [self _handleResponeData:result
                          isMore:isMore
                           error:&analyzeError];
        
        if (callback) {
            callback(analyzeError, nil);
        }
    }
}

- (BOOL)_handleResponeData:(NSDictionary *)responeData
                    isMore:(BOOL)isMore
                     error:(NSError **)error
{
#warning Parse responeData into module and set or append to self.modules
    return YES;
}

@end
