//
//  UITableViewCell+ZSCEvent.m
//
//  Created by ZS on 2018/8/30.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "UITableViewCell+ZSCEvent.h"
#import "ZSCEvent.h"
#import "UIResponder+ZSCEvent.h"

@implementation UITableViewCell (ZSCEvent)

- (void)respondEvent:(NSObject<ZSCEvent> *)event
{
    event.sender = self;

    [self.nextResponder respondEvent:event];
}

@end
