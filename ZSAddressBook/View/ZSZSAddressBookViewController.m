//
//  ZSZSAddressBookViewController.m
//
//  Created by ZS on 2018/8/8.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSZSAddressBookViewController.h"
#import "ZSZSAddressBookManager.h"
#import "ZSCEvent.h"
#import "ZSModule.h"

@interface ZSZSAddressBookViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<ZSZSAddressBookManager> manager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *errorEmptyView;

@end

@implementation ZSZSAddressBookViewController

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [[ZSZSAddressBookManager alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _setupTopBar];
    [self _setupTableView];
    
    [self _loadCacheData];
}

#pragma mark - Private Methods For TableView

- (void)_setupTopBar
{
}

- (void)_setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

- (void)_showErrorView
{
    [_errorEmptyView removeFromSuperview];
    
    _errorEmptyView = [[UIView alloc] initWithFrame:self.view.bounds];
    _errorEmptyView.backgroundColor = [UIColor redColor];
    _errorEmptyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_errorEmptyView];
}

- (void)_hiddenErrorView
{
    [_errorEmptyView removeFromSuperview];
    _errorEmptyView = nil;
}

- (void)_handleRefresh
{
    __typeof(self) __weak controller = self;
    [self.manager requestNetData:^(NSError *error, id result) {
        [controller _handleRefreshRespone:result error:error];
    }];
}

- (void)_handleRefreshRespone:(id)result error:(NSError *)error
{
    BOOL hasData = [self.manager moduleCount] > 0;
    
    if (error) {
        if (hasData) {
            [self _hiddenErrorView];
        }
        else {
            [self _showErrorView];
        }
    }
    else {
        if (hasData) {
            [self.tableView reloadData];
            [self _hiddenErrorView];
        }
        else {
            [self _showErrorView];
        }
    }
}

- (void)_handleLoadMore
{
    __typeof(self) __weak controller = self;
    [self.manager requestNetMoreData:^(NSError *error, id result) {
        [controller _handleLoadMoreRespone:result error:error];
    }];
}

- (void)_handleLoadMoreRespone:(id)result error:(NSError *)error
{
    if (error) {
    }
    else {
        [self.tableView reloadData];
    }
}

- (void)_loadCacheData
{
    __typeof(self) __weak controller = self;
    [self.manager loadCacheData:^(NSError *error, id result) {
        [controller _handleLoadCacheRespone:result error:error];
    }];
}

- (void)_handleLoadCacheRespone:(id)result error:(NSError *)error
{
    if (!error) {
        [self.tableView reloadData];
    }
    
    [self _handleRefresh];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<ZSModule> module = [self.manager moduleAtIndex:indexPath.section];
    return [module heightForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZSCEvent *event = [[ZSCEvent alloc] init];
    event.sender = [tableView cellForRowAtIndexPath:indexPath];
    
    [self respondEvent:event];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<ZSModule> module = [self.manager moduleAtIndex:section];
    return [module numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<ZSModule> module = [self.manager moduleAtIndex:indexPath.section];
    return (UITableViewCell * _Nonnull)[module cellForRow:indexPath.row tableView:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.manager moduleCount];
}

#pragma mark - ZSCEvent Respond

- (void)respondEvent:(NSObject<ZSCEvent> *)event
{
    NSAssert([event.sender isKindOfClass:UITableViewCell.class], @"event sender must be UITableViewCell");
    if (![event.sender isKindOfClass:UITableViewCell.class]) {
        return;
    }
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:event.sender];
    id<ZSModule> module = [self.manager moduleAtIndex:indexPath.section];
    
    event.sender = self;
    event.indexPath = indexPath;
    [event.userInfo setObject:_tableView
                       forKey:ZSCEventUserInfoKeys.tableView];

    [module handleEvent:event];
}

@end
