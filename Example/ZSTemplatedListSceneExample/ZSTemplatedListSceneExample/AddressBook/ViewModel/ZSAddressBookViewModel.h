//
//  ZSAddressBookViewModel.h
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZSAddressBookViewModel<NSObject>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *photo;

@end

@class ZSAddressBookItem;

@interface ZSAddressBookViewModel : NSObject<ZSAddressBookViewModel>

- (instancetype)initWithItem:(ZSAddressBookItem *)item;

@end
