//
//  ZSTemplateManager.h
//
//  Created by ZS on 2018/8/8.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZSModule;

@protocol ZSTemplateManager <NSObject>

- (id<ZSModule>)moduleAtIndex:(NSInteger)index;
- (NSInteger)moduleCount;

- (void)loadCacheData:(void (^)(NSError *error, id result))callback;
- (void)requestNetData:(void (^)(NSError *error, id result))callback;
- (void)requestNetMoreData:(void (^)(NSError *error, id result))callback;

@end


@interface ZSTemplateManager : NSObject <ZSTemplateManager>
@end
