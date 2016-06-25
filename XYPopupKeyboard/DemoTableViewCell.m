//
//  DemoTableViewCell.m
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import "DemoTableViewCell.h"
#import "UIView+XYConvenience.h"

@implementation DemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textField = [[UITextField alloc] initWithFrame:CGRectInset(self.contentView.bounds, 5, 3)];
        self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.textField setViewBorder0_5:[UIColor blackColor]];
        [self.contentView addSubview:self.textField];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
