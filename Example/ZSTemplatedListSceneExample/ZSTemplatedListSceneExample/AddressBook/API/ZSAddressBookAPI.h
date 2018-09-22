//
//  ZSAddressBookAPI.h
//
//  Created by ZS on 2018/8/31.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSAddressBookAPI : NSObject

+ (void)requestAddressBookWithParams:(NSDictionary *)params
                       completion:(void (^)(NSError *error, id result))completion;

@end
