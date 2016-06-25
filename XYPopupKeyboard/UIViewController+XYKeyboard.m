//
//  UIViewController+XYKeyboard.m
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import "UIViewController+XYKeyboard.h"
#import <objc/runtime.h>
#import "UIView+XYConvenience.h"

@implementation UIViewController (XYKeyboard)

- (CGFloat)kKeyboardOpenViewOriginally_YValue {
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, @selector(kKeyboardOpenViewOriginally_YValue));
    return [number intValue];
}
- (void)setKKeyboardOpenViewOriginally_YValue:(CGFloat)kKeyboardOpenViewOriginally_YValue {
    objc_setAssociatedObject(self, @selector(kKeyboardOpenViewOriginally_YValue), [NSNumber numberWithInt:kKeyboardOpenViewOriginally_YValue], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 添加/删除(手势)
- (UITapGestureRecognizer *)addCancelKeyboardGesttureRecognizer {
    UITapGestureRecognizer *cancelKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xyCancelKeyboardDown:)];
    cancelKeyboard.numberOfTapsRequired = 1;
    cancelKeyboard.numberOfTouchesRequired = 1;
    cancelKeyboard.cancelsTouchesInView =NO;
    [self.view addGestureRecognizer:cancelKeyboard];
    return cancelKeyboard;
}
- (void)removeCancelKeyboardGesttureRecognizer {
    UIGestureRecognizer *removeGestrue = nil;
    for(UIGestureRecognizer *gestures in self.view.gestureRecognizers) {
        if([gestures isMemberOfClass:[UITapGestureRecognizer class]] && [gestures respondsToSelector:@selector(xyCancelKeyboardDown:)]) {
            removeGestrue = gestures;
            break;
        }
    }
    if(removeGestrue != nil) {
        [self.view removeGestureRecognizer:removeGestrue];
    }
}
- (void)xyCancelKeyboardDown:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - 添加/删除(键盘通知)
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openTheKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shutTheKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationWillChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
- (void)statusBarOrientationWillChange:(NSNotification *)notification {
    [self.view endEditing:YES];
}

#pragma mark - 键盘处理
//-- 重置Frame
- (void)resetCurrentViewFrame {
    if(self.kKeyboardOpenViewOriginally_YValue != 0) {
        CGRect frame = self.view.superview.frame;
        frame.origin.y += self.kKeyboardOpenViewOriginally_YValue;
        self.view.superview.frame = frame;
        self.kKeyboardOpenViewOriginally_YValue = 0;
    }
}
//-- 键盘弹出
- (void)openTheKeyboard:(NSNotification *)notification {
    CGFloat offset_y = 0;
    if([self respondsToSelector:@selector(offsetVerticalKeybord)]) {
        offset_y = [self offsetVerticalKeybord];
    }
    [self resetCurrentViewFrame];
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    __unused CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIView *firstResponder = [self.view.superview findFirstResponderOfTheView];
    CGRect nowFrame = [firstResponder.superview convertRect:firstResponder.frame toView:self.view.superview];
    CGFloat keyboardMinY = CGRectGetHeight(self.view.superview.frame)-rect.size.height;
    if([self respondsToSelector:@selector(fetchScrollView)]) {
        UIScrollView *scrollView = [self fetchScrollView];
        CGPoint offset = scrollView.contentOffset;
        CGFloat spacing = CGRectGetMaxY(nowFrame)-keyboardMinY;
        CGFloat offset_y = offset.y+spacing;
        if(offset_y <= 0) {
            return [scrollView setContentOffset:CGPointMake(offset.x, 0) animated:NO];
        } else {
            [scrollView setContentOffset:CGPointMake(offset.x, offset_y) animated:NO];
        }
    }
    nowFrame = [firstResponder.superview convertRect:firstResponder.frame toView:self.view.superview];
    if(CGRectGetMaxY(nowFrame) > CGRectGetHeight(self.view.superview.frame)) {
        nowFrame.origin.y -= CGRectGetMaxY(nowFrame)-CGRectGetHeight(self.view.superview.frame);
    }
    CGFloat frMaxY = CGRectGetMaxY(nowFrame)+offset_y;
    if(frMaxY > keyboardMinY) {
        CGFloat nowY = frMaxY-keyboardMinY;
        self.kKeyboardOpenViewOriginally_YValue = nowY;
        CGRect frame = self.view.superview.frame;
        frame.origin.y -= nowY;
        self.view.superview.frame = frame;
        [UIView animateWithDuration:keyboardDuration animations:^{
            [self.view.superview layoutIfNeeded];
        }];
    }
    if([self respondsToSelector:@selector(doSomethingAfterShowKeyboard:)]) {
        [self doSomethingAfterShowKeyboard:notification];
    }
}
//-- 键盘关闭
- (void)shutTheKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    __unused CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self resetCurrentViewFrame];
    if([self respondsToSelector:@selector(doSomethingAfterHidsKeyboard:)]) {
        [self doSomethingAfterHidsKeyboard:notification];
    }
}

@end
