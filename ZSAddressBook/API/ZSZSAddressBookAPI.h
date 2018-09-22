//
//  ZSZSAddressBookAPI.h
//
//  Created by ZS on 2018/8/31.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSZSAddressBookAPI : NSObject

+ (void)requestZSAddressBookWithParams:(NSDictionary *)params
                       completion:(void (^)(NSError *error, id result))completion;

@end
