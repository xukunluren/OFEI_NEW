//
//  RoutesPredictViewController.m
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "RoutesPredictViewController.h"
#import "OFeiCommon.h"
#import <MapKit/MapKit.h>
#import "RoutesViewController.h"
#import "PellTableViewSelect.h"


@interface RoutesPredictViewController ()

@end

@implementation RoutesPredictViewController
{
 MKMapView *_mapView;
    NSString *_title;
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
    NSString *title = @"航线预报";
    [self setNavTitle:title];
    //    self.title = @"分区预报";
//    [self.navigationController.navigationBar setBarTintColor:BarColor];//设置navigationbar的颜色
    [self setButton];
   
}


//设置顶部右侧按钮
-(void)setButton
{
//    self.navigationController.navigationBar.barTintColor = BarColor;
    //词方法可以用来放置标题的下拉按钮
    //    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton1 addTarget:self action:@selector(selectRoutes) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"down-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    
    self.navigationItem.leftBarButtonItem = left;
    
}


-(void)setNavTitle:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = text;
    [label sizeToFit];
    
}



-(void)selectRoutes
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width-200, 64, 200, 190) selectData:@[@"霓屿山北堤航线",@"霓屿山东堤北段航线",@"凤凰山东堤南段航线",@"凤凰山南堤航线"] action:^(NSInteger index) {
        RoutesViewController *routes = [[RoutesViewController alloc] init];
        
        
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
        //在此处传递选择的区域值到partition页面：使用通知中心的模式进行传值
        self.delegate = routes;
        [self.delegate sendTitle:_title];
        [self.navigationController pushViewController:routes animated:YES];
        
    } animated:YES];
}

-(void)back{
    //    normal = [[NormalViewController alloc] init];
    //    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:normal];
    //    [self presentViewController:navi animated:YES completion:^{
    //    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
