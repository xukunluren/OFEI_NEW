//
//  NormalViewController.h
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NormalViewController : UIViewController


@property(nonatomic,strong) UIBarButtonItem *right;

@property(nonatomic,strong)AppDelegate *mydelegate;

@property(nonatomic,strong)UIView *showData;

@property(nonatomic,strong)UIButton *btn;

-(void)setNavTitle:(NSString*)text;

@end
