//
//  DiyCellBase.m
//  dreamOnPhone
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import "DiyCellBase.h"

@implementation DiyCellBase

- (void)awakeFromNib {
    // Initialization code
    
    self.image.layer.cornerRadius = 5;
    self.image.layer.masksToBounds = YES;
    self.image.layer.borderWidth = 1.0;
    self.image.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
