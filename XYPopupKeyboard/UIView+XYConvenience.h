//
//  UIView+XYConvenience.h
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYConvenience)

//-- 在当前视图上寻找获的光标的UITextField或UITextView
- (nullable UIView *)findFirstResponderOfTheView;

//-- 添加宽度为0.5的边框
- (void)setViewBorder0_5:(UIColor * _Nonnull)borderColor;


@end
