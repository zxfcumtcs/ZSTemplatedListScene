//
//  ZSModule.h
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#ifndef ZSModule_h
#define ZSModule_h

@class UITableViewCell;
@class UITableView;

@protocol ZSCEvent;

@protocol ZSModule

- (NSInteger)numberOfRows;
- (float)heightForRow:(NSInteger)row;
- (UITableViewCell *)cellForRow:(NSInteger)row
                      tableView:(UITableView *)tableView;

- (id)itemAtIndex:(NSInteger)index;
- (void)parseJsonData:(id)json;

- (void)handleEvent:(NSObject<ZSCEvent> *)event;

@end

#endif /* ZSModule_h */
