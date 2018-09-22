//
//  UIResponder+ZSCEvent.m
//
//  Created by ZS on 2018/8/30.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "UIResponder+ZSCEvent.h"

@implementation UIResponder (ZSCEvent)

- (void)respondEvent:(NSObject<ZSCEvent> *)event
{
    [self.nextResponder respondEvent:event];
}

@end
