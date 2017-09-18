//
//  RoutesViewController.m
//  OFei
//
//  Created by admin on 15/10/31.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "RoutesViewController.h"
#import "RoutesPredictViewController.h"
#import "Dock.h"
#import "fllViewController.h"
#import "tidePositionViewController.h"
#import "OFeiCommon.h"


@interface RoutesViewController ()<sendRoutesTitleDelegate>

@end

@implementation RoutesViewController
{

    NSString *_title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self addAllChildControllers];
    [self addDock];
    
    
}





#pragma mark - 1. 添加子控制器
- (void)addAllChildControllers
{
    fllViewController *wind = [[fllViewController alloc]init];
    wind.route = _title;
    [self addChildViewController:wind];
    
    tidePositionViewController *wave = [[tidePositionViewController alloc]init];
    wave.routes = _title;
    [self addChildViewController:wave];
    
    
}

#pragma mark - 2. 添加Dock
- (void)addDock
{
    Dock *dock = [[Dock alloc]init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.backgroundColor = DockColor;
    dock.delegate = self;
    [self.view addSubview:dock];
    //2.dock中添加内容  更改图标
    [dock addItemWithIcon:@"Wind@2x.png" selectedIcon:@"WindFilled@2x.png" title:@"风浪流"];
    [dock addItemWithIcon:@"Wave@2x.png" selectedIcon:@"WaveFilled@2x.png" title:@"潮位"];
    
}


#pragma mark Dock 代理方法

- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to
{
    if (to < 0 || to >= self.childViewControllers.count) return;
    //先移除旧控制器
    UIViewController *oldVC = self.childViewControllers[from];
    [oldVC.view removeFromSuperview];
    
    //1.新建
    UIViewController *newVC = self.childViewControllers[to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVC.view.frame = CGRectMake(0, 0, width, height);
    
    //2.添加新的到子控制器上
    [self.view addSubview:newVC.view];
    
}



#pragma 委托代理传值实现方法
- (void)sendTitle:(NSString *)title
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = title;
    _title = title;
    [label sizeToFit];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
