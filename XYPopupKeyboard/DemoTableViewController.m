//
//  DemoTableViewController.m
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import "DemoTableViewController.h"
#import "DemoTableViewCell.h"
#import "UIViewController+XYKeyboard.h"

#define CellReuseIdentifier @"DemoTableViewCell"

@interface DemoTableViewController ()<UITextFieldDelegate> {
    NSInteger count;
}

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"键盘";
    count = 14;
    self.tableView.rowHeight = 48;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[DemoTableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addKeyboardNotification];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeKeyboardNotification];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    cell.textField.delegate = self;
    cell.textField.returnKeyType = (indexPath.row == count-1) ? UIReturnKeyDone : UIReturnKeyNext;
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    } else {
        DemoTableViewCell *cell = [self latticeContainingView:textField];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        indexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        DemoTableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:indexPath];
        [nextCell.textField becomeFirstResponder];
    }
    return YES;
}
- (DemoTableViewCell *)latticeContainingView:(UIView *)view {
    UIView *cell = view.superview;
    while (cell != nil && ![cell isMemberOfClass:[DemoTableViewCell class]]) {
        cell = cell.superview;
    }
    return (DemoTableViewCell *)cell;
}

#pragma mark - XYKeyboard Methods
//-- 
- (UITableView *)fetchScrollView {
    return self.tableView;
}
//-- 键盘与获取光标的控件之间的间距
- (CGFloat)offsetVerticalKeybord {
    return -1;
}
//-- 键盘弹出后，你可能需要做处理
- (void)doSomethingAfterShowKeyboard:(NSNotification *_Nonnull)notification {
    NSLog(@"键盘弹出了");
}
//-- 键盘关闭后，你可能需要做处理
- (void)doSomethingAfterHidsKeyboard:(NSNotification *_Nonnull)notification {
    NSLog(@"键盘关闭了");
}
@end
