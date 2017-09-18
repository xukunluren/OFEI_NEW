



//
//  fllViewController.m
//  OFei
//
//  Created by admin on 15/11/12.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "fllViewController.h"
#import "CNPGridMenu.h"
#import "PellTableViewSelect.h"
#import "NormalViewController.h"
#import "OFeiCommon.h"
#import "waveGraph.h"
#import "flowGraph.h"
#import "windGraph.h"
#import "DiyTheme.h"


@interface fllViewController ()<CNPGridMenuDelegate>


@property (nonatomic, strong) CNPGridMenu *gridMenu;

@end

@implementation fllViewController{

    NSString *_title;
    UILabel *_titleLabel;
    
    NSMutableArray *_windTimeArr;
    NSMutableArray *_windValueArr;
    NSMutableArray *_keduArray;
    
    waveGraph *_waveGraph;
    flowGraph *_flowGraph;
    windGraph *_windGraph;
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
    _windTimeArr = [[NSMutableArray alloc]init];
    _windValueArr = [[NSMutableArray alloc]init];
    _keduArray = [[NSMutableArray alloc]init];
    
   _title = @"霓屿山北堤航线";
    CGRect mainView = [UIScreen mainScreen].bounds;
    
    self.tabBarController.tabBar.hidden = NO;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
    [self setNavTitle:@"霓屿山北堤航线"];
    [self setButton];
    [self graphLayer];
//    [self judgeRoutes:_title];
    [_windGraph backwithTitle:_title];
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = YES;
//}

-(void)graphLayer
{
    _windGraph = [[windGraph alloc] init];
    [_windGraph backwithTitle:_title];
//    _windGraph.title = @"霓屿山北堤航线";
    _windGraph.backgroundColor = [UIColor clearColor];
    _windGraph.alpha = 0.6;
    _windGraph.layer.cornerRadius = 10;
    _windGraph.frame = CGRectMake(0, 65, KWight, KHight/3.8);
    [self.view addSubview:_windGraph];
    
    
    
    _waveGraph = [[waveGraph alloc]init];
    [_waveGraph backwithTitle:_title];
    _waveGraph.backgroundColor = [UIColor clearColor];
    _waveGraph.alpha = 0.6;
    _waveGraph.frame = CGRectMake(0, 60+KHight/3.8, KWight, KHight/3.8);
    _waveGraph.layer.cornerRadius = 10;
    [self.view addSubview:_waveGraph];
    
    _flowGraph = [[flowGraph alloc]init];
    [_flowGraph backwithTitle:_title];
    _flowGraph.backgroundColor = [UIColor clearColor];
    _flowGraph.alpha = 0.6;
    _flowGraph.frame = CGRectMake(0, 70+2*(KHight/3.8), KWight, KHight/3.8);
    _flowGraph.layer.cornerRadius = 10;
    [self.view addSubview:_flowGraph];
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
//    [exampleButton1 addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
//    self.navigationItem.rightBarButtonItem = right;
    
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress2)];
    longPressGR.allowableMovement=NO;
    longPressGR.minimumPressDuration = 0.2;
    [exampleButton1 addGestureRecognizer:longPressGR];
    
    
}

- (void)backHome
{
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
}

-(void)setNavTitle:(NSString *)title
{

//    UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
//    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
//    select.frame = CGRectMake(40, 10, 40, 40);
//    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
//    [select addTarget:self action:@selector(selectRoutes) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.frame = CGRectMake(0, 10, 60, 40);
//    label.font = [UIFont boldSystemFontOfSize:16.0];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor]; // change this color
//    _titleLabel = label;
//    _titleLabel.text = _title;
//    [_titleLabel sizeToFit];
//    [middle addSubview:select];
//    [middle addSubview:label];
//    
//    [label sizeToFit];
//    self.navigationItem.titleView = middle;
    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(0, 0, 200, 40);
    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
    select.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -20, -150);
    [select addTarget:self action:@selector(selectRoutes) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel.text = _title;
    [select setTitle:_title forState:UIControlStateNormal];
    select.titleLabel.font = [UIFont fontWithName:@"" size:14];
    select.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_titleLabel sizeToFit];
    
    self.navigationItem.titleView = select;

    
}
-(void)back{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    
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

-(NSURL *)judgeRoutes:(NSString *)title
{
    NSURL *url;
    if ([title isEqualToString:@"霓屿山北堤航线"]) {
        url= [NSURL URLWithString:KRouteWindP1];
    }
    if ([title isEqualToString:@"霓屿山东堤北段航线"]) {
        url= [NSURL URLWithString:KRouteWindP2];
    }
    if ([title isEqualToString:@"凤凰山东堤南段航线"]) {
        url= [NSURL URLWithString:KRouteWindP3];
    }
    if ([title isEqualToString:@"凤凰山南堤航线"]) {
        url= [NSURL URLWithString:KRouteWindP4];
    }
    NSLog(@"您选择的区域是%@",url);
    return url;
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


-(void)selectRoutes
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.2, 64, 200, 190) selectData:@[@"霓屿山北堤航线",@"霓屿山东堤北段航线",@"凤凰山东堤南段航线",@"凤凰山南堤航线"] action:^(NSInteger index) {
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"霓屿山北堤航线";
        }
        if (index == 1) {
            _title = @"霓屿山东堤北段航线";
        }
        if (index == 2) {
            _title = @"凤凰山东堤南段航线";
        }
        if (index == 3) {
            _title = @"凤凰山南堤航线";
        }
        NSLog(@"%@",_title);
        [self setNavTitle:_title];
        [_windGraph judgeRoutes:_title];
        [_windGraph getDataFromNet:_title];
        
        [_flowGraph judgeRoutes:_title];
        [_flowGraph getDataFromNet:_title];
        
        [_waveGraph judgeRoutes:_title];
        [_waveGraph getDataFromNet:_title];

        
        [graph reloadData];
    } animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
