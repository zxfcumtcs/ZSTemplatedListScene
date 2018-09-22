//
//  ZSCEvent.h
//
//  Created by ZS on 2018/8/30.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIResponder;

@protocol ZSCEvent <NSObject>

@property (nonatomic, strong) __kindof UIResponder *sender;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSMutableDictionary *userInfo;

@end

@interface ZSCEvent : NSObject<ZSCEvent>

@end

typedef struct {
    __unsafe_unretained NSString *index;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *tableView;
} ZSCEventUserInfoKeysGroup;


extern const ZSCEventUserInfoKeysGroup ZSCEventUserInfoKeys;
