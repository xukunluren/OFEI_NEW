
//
//  headview.m
//  OFei
//
//  Created by admin on 15/11/15.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "headview.h"

@implementation headview


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titlelable =[[UILabel alloc]initWithFrame:CGRectMake(0,0,100,20)];
        _titlelable.text = @"XXX海雾预警";
        _titlelable.backgroundColor = [UIColor whiteColor];
        _titlelable.textColor = [UIColor redColor];
        //字体显示举中
        //lable.textAlignment = UITextAlignmentCenter;
        //自动折行设置
        //lable.lineBreakMode = UILineBreakModeCharacterWrap;
        _titlelable.numberOfLines = 3;
        //设置字体
        //lable.font=[UIFont fontWithName:@"Helvetica" size:20];
        //设置阴影的颜色
        // lable.shadowColor = [UIColor blackColor];
        [self addSubview:_titlelable];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
