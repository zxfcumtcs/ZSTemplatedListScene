//
//  ZSAddressBookItem.h
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSAddressBookItem : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *surName;
@property (nonatomic, copy, readonly) NSString *gender;
@property (nonatomic, assign, readonly) NSInteger age;
@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *photo;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
