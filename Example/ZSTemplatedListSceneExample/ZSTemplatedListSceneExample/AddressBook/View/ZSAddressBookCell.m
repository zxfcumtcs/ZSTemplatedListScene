//
//  ZSAddressBookCell.m
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookCell.h"
#import "ZSAddressBookView.h"
#import "ZSAddressBookItem.h"
#import "ZSAddressBookViewModel.h"

@interface ZSAddressBookCell ()

@property (nonatomic, strong) ZSAddressBookView *view;

@end

@implementation ZSAddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setCellData:(id)data
{
    if (![data isKindOfClass:ZSAddressBookItem.class]) {
        return;
    }
    
    ZSAddressBookItem *bookItem = (ZSAddressBookItem *)data;
    [self _setupAddressBookView:bookItem];
}

+ (NSInteger)cellHegiht
{
    return [ZSAddressBookView viewHeight];
}

- (void)_setupAddressBookView:(ZSAddressBookItem *)item
{
    if (!_view) {
        _view = [[ZSAddressBookView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self.class cellHegiht])];
        
        [self.contentView addSubview:_view];
    }
    
    ZSAddressBookViewModel *viewModel = [[ZSAddressBookViewModel alloc] initWithItem:item];
    [_view setViewModel:viewModel];
}

@end
