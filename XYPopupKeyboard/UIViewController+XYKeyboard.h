//
//  UIViewController+XYKeyboard.h
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XYKeyboard)

//-- 键盘弹出前View的Y坐标
@property (nonatomic,assign,readonly) CGFloat kKeyboardOpenViewOriginally_YValue;

//-- 添加键盘通知
- (void)addKeyboardNotification;
//-- 删除键盘通知
- (void)removeKeyboardNotification;
//-- 添加关闭键盘手势
- (UITapGestureRecognizer * _Nonnull)addCancelKeyboardGesttureRecognizer;
//-- 删除关闭键盘手势
- (void)removeCancelKeyboardGesttureRecognizer;

@end

@interface UIViewController ()

//-- 如果是带TableView的Controller，需要实现
- (nonnull UIScrollView *)fetchScrollView;
//-- 键盘与获取光标的控件之间的间距
- (CGFloat)offsetVerticalKeybord;
//-- 键盘弹出后，你可能需要做处理
- (void)doSomethingAfterShowKeyboard:(NSNotification *_Nonnull)notification;
//-- 键盘关闭后，你可能需要做处理
- (void)doSomethingAfterHidsKeyboard:(NSNotification *_Nonnull)notification;

@end
