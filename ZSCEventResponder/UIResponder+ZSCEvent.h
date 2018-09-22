//
//  UIResponder+ZSCEvent.h
//
//  Created by ZS on 2018/8/30.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZSCEvent.h"

@interface UIResponder (ZSCEvent)

- (void)respondEvent:(NSObject<ZSCEvent> *)event;

@end

