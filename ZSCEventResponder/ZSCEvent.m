//
//  ZSCEvent.m
//
//  Created by ZS on 2018/8/30.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSCEvent.h"

@interface ZSCEvent ()
{
    NSMutableDictionary *_userInfo;
}

@end

@implementation ZSCEvent

@synthesize sender;
@synthesize indexPath;
@synthesize userInfo = _userInfo;

- (instancetype)init
{
    if (self = [super init]) {
        _userInfo = [NSMutableDictionary dictionary];
    }
    
    return self;
}

@end

const ZSCEventUserInfoKeysGroup ZSCEventUserInfoKeys = (ZSCEventUserInfoKeysGroup) {
    .index = @"index",
    .name = @"name",
    .tableView = @"tableView",
};
