//
//  UIView+XYConvenience.m
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import "UIView+XYConvenience.h"

@implementation UIView (XYConvenience)

- (UIView *)findFirstResponderOfTheView {
    UIView *firstResponder = nil;
    NSArray *subviews = self.subviews;
    for(UIView *view in subviews) {
        if([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
            if([view isFirstResponder]) {
                firstResponder = view;
                break;
            }
        }
        firstResponder = [view findFirstResponderOfTheView];
        if(firstResponder) {
            break;
        }
    }
    return firstResponder;
}

- (void)setViewBorder0_5:(UIColor *)borderColor {
    self.layer.borderWidth=0.5;
    self.layer.borderColor=borderColor.CGColor;
}

@end
