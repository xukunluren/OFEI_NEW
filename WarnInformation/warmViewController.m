//
//  warmViewController.m
//  OFei
//
//  Created by admin on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "warmViewController.h"
#import "Diycell.h"
#import "waemDetail.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "WarnInformationViewController.h"
#import "CNPGridMenu.h"

@interface warmViewController ()<CNPGridMenuDelegate>

@end

@implementation warmViewController
{
    BOOL logoHidden;
}

#pragma mark - 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏底部线
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bargound.png"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    self.tableView.alpha = 0.5;
    
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
   
    
    [self setButton];

}

-(void)setButton
{
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton1 addTarget:self action:@selector(handleLongPress2) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"down-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
    self.navigationItem.rightBarButtonItem = right;
    
//    UILongPressGestureRecognizer *longPressGR =
//    [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                  action:@selector(handleLongPress2)];
//    longPressGR.allowableMovement=NO;
//    longPressGR.minimumPressDuration = 0.2;
//    [exampleButton1 addGestureRecognizer:longPressGR];
    
    
}


//响应的事件
-(void)handleLongPress2{
    
    
    CNPGridMenuItem *laterToday = [[CNPGridMenuItem alloc] init];
    //    laterToday.icon = [UIImage imageNamed:@"LaterToday"];
    laterToday.title = @"分区预报";
    
    CNPGridMenuItem *thisEvening = [[CNPGridMenuItem alloc] init];
    //    thisEvening.icon = [UIImage imageNamed:@"ThisEvening"];
    thisEvening.title = @"点预报";
    
    CNPGridMenuItem *tomorrow = [[CNPGridMenuItem alloc] init];
    //    tomorrow.icon = [UIImage imageNamed:@"Tomorrow"];
    tomorrow.title = @"航线预报";
    
    CNPGridMenuItem *thisWeekend = [[CNPGridMenuItem alloc] init];
    //    thisWeekend.icon = [UIImage imageNamed:@"ThisWeekend"];
    thisWeekend.title = @"预警信息";
    
    CNPGridMenuItem *nextWeek = [[CNPGridMenuItem alloc] init];
    //    nextWeek.icon = [UIImage imageNamed:@"NextWeek"];
    nextWeek.title = @"台风路径";
    
    
    
    CNPGridMenu *gridMenu = [[CNPGridMenu alloc] initWithMenuItems:@[laterToday, thisEvening, tomorrow, thisWeekend, nextWeek]];
    gridMenu.delegate = self;
    [self presentGridMenu:gridMenu animated:YES completion:^{
        NSLog(@"Grid Menu Presented");
    }];
    
    
    NSLog(@"长按事件");
    
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
    [label sizeToFit];
    
    
}

-(void)back{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    Diycell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Diycell" owner:self options:nil] lastObject];
    }
    //cell后端的返回键
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

 
    cell.image.backgroundColor = [UIColor redColor];
//    图像logo自身变成圆形，最重要的是这个地方要设置成imageview的一半
    cell.logo.layer.masksToBounds = YES;
    cell.logo.layer.cornerRadius = 7.5;
    
  //  cell.title.text = [arraytext objectAtIndex:indexPath.row]objectAtIndex:2];
    //设置单元格显示内容
    
    cell.title.text = @"海浪预报";
    cell.year.text = @"1991年";
    cell.date.text = @"12月1日";
    
    return cell;
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你选择了%ld",(long)indexPath.row);
    // 1. 声明静态标识
//    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
  //  Diycell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //用indexPath可以获得所选的行号，根据行号获取到cell里面内容
    Diycell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Diycell" owner:self options:nil] lastObject];
       }
    
    cell.logo.hidden = YES;
    //cell.title.text = @"hahaha";
    
    //点击cell后创建新页面，使用通知中心的模式进行传值
    waemDetail *warm = [[waemDetail alloc] init];
    self.delegate = warm;
    // 返回cell中的标题
  //  NSLog(@"%@",);
    
    NSString *title = cell.title.text;
    [self.delegate sendTitle:title];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:warm animated:YES];

}


#pragma 长按按钮的代理事件
- (void)gridMenuDidTapOnBackground:(CNPGridMenu *)menu {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Dismissed With Background Tap");
    }];
}

- (void)gridMenu:(CNPGridMenu *)menu didTapOnItem:(CNPGridMenuItem *)item {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Did Tap On Item: %@", item.title);
    }];
}


@end
