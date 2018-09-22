//
//  ZSAddressBookManager.m
//
//  Created by ZS on 2018/8/8.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookManager.h"
#import "ZSAddressBookAPI.h"
#import "ZSModule.h"
#import "ZSAddressBookDefaultStyleModule.h"

static NSString *ZSAddressBookCacheFileName = @"cache";

@interface ZSAddressBookManager ()

@property (nonatomic, strong) NSArray<id<ZSModule>> *modules;
@property (nonatomic, strong) NSString *cacheDir;

@end

@implementation ZSAddressBookManager

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
    _cacheDir = [supportPath stringByAppendingPathComponent:@"AddressBook"];
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
        NSData *cacheData = [NSData dataWithContentsOfFile:[self->_cacheDir stringByAppendingPathComponent:ZSAddressBookCacheFileName]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _loadCacheDataSuccess:cacheData callback:callback];
        });
    });
}

- (void)_loadCacheDataSuccess:(NSData *)result
                     callback:(void (^)(NSError *error, id result))callback
{
    NSArray *cacheData = [NSKeyedUnarchiver unarchiveObjectWithData:result];
    if (![cacheData isKindOfClass:NSArray.class]) {
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
        NSString *path = [self->_cacheDir stringByAppendingPathComponent:ZSAddressBookCacheFileName];
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
    __typeof(self) __weak manager = self;
    [ZSAddressBookAPI requestAddressBookWithParams:nil
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

- (BOOL)_handleResponeData:(NSArray *)responeData
                    isMore:(BOOL)isMore
                     error:(NSError **)error
{
    NSMutableArray<id<ZSModule>> *modules = [NSMutableArray arrayWithCapacity:responeData.count];
    [responeData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZSAddressBookDefaultStyleModule *module = [[ZSAddressBookDefaultStyleModule alloc] init];
        [module parseJsonData:obj];
        
        [modules addObject:module];
    }];
    
    self.modules = modules.copy;
    
    return YES;
}

@end
