//
//  ZSAddressBookAPI.m
//
//  Created by ZS on 2018/8/31.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookAPI.h"

@implementation ZSAddressBookAPI

+ (void)requestAddressBookWithParams:(NSDictionary *)params
                       completion:(void (^)(NSError *error, id result))completion
{
    NSString *path = @"https://uinames.com/api/?ext&amount=20&region=China";
    
    if ([[params allKeys] count] > 0) {
        
        NSMutableArray *parts = [NSMutableArray array];
        for (id key in params) {
            id value = [params  objectForKey:key];
            NSString *part = [NSString stringWithFormat:@"%@=%@", key, value];
            [parts addObject: part];
        }
        
        NSString *parameterString = [parts componentsJoinedByString: @"&"];

        path = [path stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", parameterString];
    }

    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    requst.HTTPMethod = @"POST";
    requst.timeoutInterval = 15;

    [NSURLConnection sendAsynchronousRequest:requst
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response,
                                               NSData * _Nullable data,
                                               NSError * _Nullable connectionError) {
                               NSError *error = connectionError;
                               id result = nil;
                               if (!error) {
                                   result = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:kNilOptions
                                                                              error:&error];
                               }
                               
                               if (completion) {
                                   completion(error, result);
                               }
    }];
}

@end
