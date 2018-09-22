//
//  ZSAddressBookDefaultStyleModule.m
//  ZSTemplatedListSceneExample
//
//  Created by ZS on 2018/9/22.
//  Copyright © 2018年 ZS. All rights reserved.
//

#import "ZSAddressBookDefaultStyleModule.h"
#import "ZSAddressBookItem.h"
#import "ZSAddressBookCell.h"
#import "ZSAddressBookAPI.h"
#import "ZSCEvent.h"

@interface ZSAddressBookDefaultStyleModule()

@property (nonatomic, strong) NSArray<ZSAddressBookItem *> *items;

@end

@implementation ZSAddressBookDefaultStyleModule

- (NSInteger)numberOfRows
{
    return self.items.count;
}

- (float)heightForRow:(NSInteger)row
{
    return [ZSAddressBookCell cellHegiht];
}

- (UITableViewCell *)cellForRow:(NSInteger)row
                      tableView:(UITableView *)tableView
{
    static NSString *identifier = @"ZSAddressBookCell";
    
    ZSAddressBookCell *cell =
    [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil){
        cell = [[ZSAddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:identifier];
    }
    
    [cell setCellData:[self.items objectAtIndex:row]];
    
    return cell;
}

- (id)itemAtIndex:(NSInteger)index
{
    return self.items[index];
}

- (void)parseJsonData:(id)json
{
    if (![json isKindOfClass:NSDictionary.class]) {
        return;
    }
    
    NSMutableArray<ZSAddressBookItem *> *items = [NSMutableArray arrayWithCapacity:1];
    ZSAddressBookItem *item = [[ZSAddressBookItem alloc] initWithDict:json];
    [items addObject:item];
    
    self.items = items.copy;
}

- (void)handleEvent:(NSObject<ZSCEvent> *)event
{
    ZSAddressBookItem *item = self.items[event.indexPath.row];
    BOOL isClickedButton = [event.userInfo[@"clickedButton"] boolValue];
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:isClickedButton ? @"点击了按钮" : @"点击了cell"
                                        message:[NSString stringWithFormat:@"%@%@", item.name, item.surName]
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];

    [(UIViewController *)(event.sender) presentViewController:alertController animated:YES completion:nil];
}

@end
