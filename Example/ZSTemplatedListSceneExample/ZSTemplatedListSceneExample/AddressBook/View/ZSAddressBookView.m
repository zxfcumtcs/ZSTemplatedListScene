//
//  ZSAddressBookView.m
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookView.h"
#import "ZSAddressBookViewModel.h"
#import "UIResponder+ZSCEvent.h"

static NSInteger ZSAddressBookHorizontalSpace = 10;
static NSInteger ZSAddressBookVerticalSpace = 10;
static NSInteger ZSAddressBookLabelHeight = 15;

@interface ZSAddressBookView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *button;

@end

@implementation ZSAddressBookView

- (void)setViewModel:(id<ZSAddressBookViewModel>)viewModel
{
    [self _setupNameLabel:viewModel.name];
    [self _setupGenderLabel:viewModel.gender];
    [self _setupAgeLabel:viewModel.age];
    [self _setupPhoneLabel:viewModel.phone];
    [self _setupEmailLabel:viewModel.email];
    
    [self _setupButton];
    [self _setupLine];
}

+ (NSInteger)viewHeight
{
    return 6 * ZSAddressBookHorizontalSpace + ZSAddressBookLabelHeight * 5;
}

- (void)_setupNameLabel:(NSString *)name
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZSAddressBookHorizontalSpace,
                                                               ZSAddressBookVerticalSpace,
                                                               CGRectGetWidth(self.frame) - 2 * ZSAddressBookHorizontalSpace,
                                                               ZSAddressBookLabelHeight)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:_nameLabel];
    }
    
    _nameLabel.text = name;
}

- (void)_setupButton
{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 80, ZSAddressBookVerticalSpace, 50, 30)];
        [_button setTitle:@"试试" forState:UIControlStateNormal];
        _button.titleLabel.textColor = [UIColor blackColor];
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_button setBackgroundColor:[UIColor grayColor]];
        
        [_button addTarget:self action:@selector(_clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button];
    }
}

- (void)_clickedButton:(id)sender
{
    ZSCEvent *event = [[ZSCEvent alloc] init];
    event.sender = self;
    [event.userInfo setObject:@(YES) forKey:@"clickedButton"];
    
    [self respondEvent:event];
}

- (void)_setupGenderLabel:(NSString *)gender
{
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZSAddressBookHorizontalSpace,
                                                                 CGRectGetMaxY(_nameLabel.frame) + ZSAddressBookVerticalSpace,
                                                                 CGRectGetWidth(self.frame) - 2 * ZSAddressBookHorizontalSpace,
                                                                 ZSAddressBookLabelHeight)];
        _genderLabel.textColor = [UIColor blackColor];
        _genderLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:_genderLabel];
    }
    
    _genderLabel.text = gender;
}

- (void)_setupAgeLabel:(NSString *)age
{
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZSAddressBookHorizontalSpace,
                                                                 CGRectGetMaxY(_genderLabel.frame) + ZSAddressBookVerticalSpace,
                                                                 CGRectGetWidth(self.frame) - 2 * ZSAddressBookHorizontalSpace,
                                                                 ZSAddressBookLabelHeight)];
        _ageLabel.textColor = [UIColor blackColor];
        _ageLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:_ageLabel];
    }
    
    _ageLabel.text = age;
}

- (void)_setupPhoneLabel:(NSString *)phone
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZSAddressBookHorizontalSpace,
                                                                 CGRectGetMaxY(_ageLabel.frame) + ZSAddressBookVerticalSpace,
                                                                 CGRectGetWidth(self.frame) - 2 * ZSAddressBookHorizontalSpace,
                                                                 ZSAddressBookLabelHeight)];
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:_phoneLabel];
    }
    
    _phoneLabel.text = phone;
}

- (void)_setupEmailLabel:(NSString *)email
{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZSAddressBookHorizontalSpace,
                                                                 CGRectGetMaxY(_phoneLabel.frame) + ZSAddressBookVerticalSpace,
                                                                 CGRectGetWidth(self.frame) - 2 * ZSAddressBookHorizontalSpace,
                                                                 ZSAddressBookLabelHeight)];
        _emailLabel.textColor = [UIColor blackColor];
        _emailLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:_emailLabel];
    }
    
    _emailLabel.text = email;
}

- (void)_setupLine
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 0.5, CGRectGetWidth(self.frame) , 1)];
        _line.backgroundColor = [UIColor blackColor];
        
        [self addSubview:_line];
    }
}

@end
