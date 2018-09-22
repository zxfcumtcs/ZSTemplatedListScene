//
//  ZSAddressBookItem.m
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookItem.h"

@interface ZSAddressBookItem ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *surName;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *photo;

@end

@implementation ZSAddressBookItem

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name = dict[@"name"];
        _surName = dict[@"surname"];
        _gender = dict[@"gender"];
        _age = [dict[@"age"] integerValue];
        _phone = dict[@"phone"];
        _email = dict[@"email"];
        _photo = dict[@"photo"];
    }
    
    return self;
}

@end
