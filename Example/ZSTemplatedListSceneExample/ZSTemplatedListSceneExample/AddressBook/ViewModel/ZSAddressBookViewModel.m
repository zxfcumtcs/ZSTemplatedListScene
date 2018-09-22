//
//  ZSAddressBookViewModel.m
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookViewModel.h"
#import "ZSAddressBookItem.h"

@implementation ZSAddressBookViewModel

@synthesize name = _name;
@synthesize gender = _gender;
@synthesize age = _age;
@synthesize phone = _phone;
@synthesize email = _email;
@synthesize photo = _photo;

- (instancetype)initWithItem:(ZSAddressBookItem *)item
{
    if (self = [super init]) {
        _name = [NSString stringWithFormat:@"姓名：%@%@", item.name, item.surName];
        _gender = [item.gender isEqualToString:@"性别：male"] ? @"男" : @"女";
        _age = [NSString stringWithFormat:@"年龄：%ld岁", (long)item.age];
        _phone = [NSString stringWithFormat:@"电话：item.phone"];
        _email = [NSString stringWithFormat:@"邮件：item.email"];
        _photo = item.photo;
    }
    
    return self;
}

@end
