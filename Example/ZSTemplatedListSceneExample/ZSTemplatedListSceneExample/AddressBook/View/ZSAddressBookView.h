//
//  ZSAddressBookView.h
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZSAddressBookViewModel;

@interface ZSAddressBookView : UIView

- (void)setViewModel:(id<ZSAddressBookViewModel>)viewModel;
+ (NSInteger)viewHeight;

@end
