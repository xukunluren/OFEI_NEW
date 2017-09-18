//
//  mainOfeiViewController.m
//  OFei
//
//  Created by admin on 15/11/29.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "mainOfeiViewController.h"
#import "PartitionViewController.h"
#import "PointViewController.h"
#import "AreaPredictViewController.h"
#import "RoutesPredictViewController.h"
#import "warmOfeiViewController.h"
#import "UIBarButtonItem+Badge.h"
#import "TyphoonPredictViewController.h"
#import "DKCircleButton.h"
#import "windViewController.h"
#import "waveViewController.h"
#import "flowViewController.h"
#import "longTideViewController.h"
#import "shortTideViewController.h"
#import "OFeiCommon.h"
#import "fllViewController.h"
#import "tidePositionViewController.h"
#import "TyphoneViewController.h"

@interface mainOfeiViewController ()
{
    //拖动时用到的属性，记录最后的选中button的tag
    int tmptag ;
    DKCircleButton *button1;
    NSArray *_nameArray;
    
    BOOL buttonState;

}

@property(nonatomic,strong)NSMutableArray * myRects;//存放所有的view
@property(nonatomic,strong)NSMutableArray * frames;//存放view的标准位置

@end

@implementation mainOfeiViewController


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
    // Do any additional setup after loading the view.
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
    
    [self setNavTitle:@"瓯飞工程海洋预报信息移动服务平台"];
    [self setMainView];
    
}
-(void)setNavTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:12.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
   
   
    
}

-(void)setMainView
{
    //初始化两个数组
    self.myRects = [NSMutableArray arrayWithCapacity:10];
    self.frames = [NSMutableArray arrayWithCapacity:10];
    _nameArray = [[NSArray alloc] initWithObjects:@"分区预报", @"点预报", @"航线预报", @"预警信息", @"台风路径",nil];
    
    NSLog(@"数组大小是多少：%lu",(unsigned long)_nameArray.count);
    CGFloat withOfButton = self.view.frame.size.width;
    CGFloat heighOfButton = self.view.frame.size.height;
    //初始化页面，加9宫格
    for (int i = 0; i < _nameArray.count; i++)
    {
        button1 = [[DKCircleButton alloc] init];
        
        //    button1.center = CGPointMake(160, 200);
        button1.frame = CGRectMake(35 + i%2 * withOfButton*0.42, 80 + i/2 * heighOfButton*0.28,withOfButton*0.36,withOfButton*0.36);
        button1.titleLabel.font = [UIFont systemFontOfSize:18];
        button1.titleLabel.tintColor = [UIColor blackColor];
        button1.tag = i;
        
        button1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"san.jpeg"]];
        [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
        [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
        
        [button1 setTitle:NSLocalizedString(_nameArray[i], nil) forState:UIControlStateNormal];
        button1.tintColor = [UIColor blackColor];
        
        [button1 addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
    }
}


- (void)tapOnButton:(UIButton *)button {
    
    
    if (button.tag==0) {
        
        button.tintColor = [UIColor whiteColor];
        PartitionViewController *partition = [[PartitionViewController alloc]init];
//        [self.navigationController pushViewController:partition animated:YES];
        
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//                  UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:partition animated:NO];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    if (button.tag==1) {
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        //用于设置字体的问题（颜色和大小等）
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor:KTextColor} forState:UIControlStateSelected];
        
        
        windViewController *wind = [[windViewController alloc]init];
        wind.point = @"A点";
        //可用于解决图片灰色问题
        wind.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"风" image:[[UIImage imageNamed:@"wind-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wind_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        waveViewController *wave = [[waveViewController alloc]init];
        wave.point = @"A点";
       
        //可用于解决图片灰色问题
        wave.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"浪" image:[[UIImage imageNamed:@"wave-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wave_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        flowViewController *flow = [[flowViewController alloc]init];
        flow.point = @"A点";
        //可用于解决图片灰色问题
        flow.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"流" image:[[UIImage imageNamed:@"flow-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"flow_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        shortTideViewController *four = [[shortTideViewController alloc]init];
        four.point = @"A点";
        //可用于解决图片灰色问题
        four.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"短潮" image:[[UIImage imageNamed:@"STide-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"STide_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        longTideViewController *longTide = [[longTideViewController alloc]init];
        longTide.point = @"A点";
        //可用于解决图片灰色问题
        longTide.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"长潮" image:[[UIImage imageNamed:@"LTide-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"LTide_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        //navigation
        
        UINavigationController *navFrist = [[UINavigationController alloc]initWithRootViewController:wind];
        
        [tabBarController addChildViewController:navFrist];
        
        UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:wave];
        //    navSecond.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navSecond];
        
        UINavigationController *navThrid = [[UINavigationController alloc]initWithRootViewController:flow];
        //    navThrid.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navThrid];
        
        UINavigationController *navForth = [[UINavigationController alloc]initWithRootViewController:four];
        //    navForth.navigationBar.backgroundColor = BarColor;
        
        [tabBarController addChildViewController:navForth];
        
        UINavigationController *navFifth = [[UINavigationController alloc]initWithRootViewController:longTide];
        //    navFifth.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navFifth];
        [self presentViewController:tabBarController animated:YES completion:nil];
        
        
    }
    if (button.tag==2) {
        
        
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        
        //用于设置字体的问题（颜色和大小等）
        UIColor *color = [UIColor colorWithRed:26 green:188 blue:156 alpha:1];
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor:KTextColor} forState:UIControlStateSelected];
        
        
        fllViewController *fill = [[fllViewController alloc]init];
//        fill.point = @"A点";
        //可用于解决图片灰色问题
        fill.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"风浪流" image:[[UIImage imageNamed:@"wind-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wind_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        tidePositionViewController *tide = [[tidePositionViewController alloc]init];
//        wave.point = @"A点";
        
        //可用于解决图片灰色问题
        tide.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"潮" image:[[UIImage imageNamed:@"wave-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wave_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
       
        
        //navigation
        
        UINavigationController *navFrist = [[UINavigationController alloc]initWithRootViewController:fill];
        
        [tabBarController addChildViewController:navFrist];
        
        UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:tide];
        //    navSecond.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navSecond];
        
       
        //    navFifth.navigationBar.backgroundColor = BarColor;
        [self presentViewController:tabBarController animated:YES completion:nil];
        
    }
    if (button.tag==3) {
        warmOfeiViewController *warm = [[warmOfeiViewController alloc] init];
//        [self.navigationController pushViewController:warm animated:YES];
        [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            //                  UIViewAnimationOptionTransitionCurlUp
            //        UIViewAnimationOptionTransitionCrossDissolve
            [self.navigationController pushViewController:warm animated:YES];
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    if (button.tag==4) {
        
        TyphoneViewController *typhone =[[TyphoneViewController alloc] init];
        
        [self.navigationController pushViewController:typhone animated:YES];
        
    }

        buttonState = !buttonState;
}


//长按手势的回调
-(void)longPressTap:(UILongPressGestureRecognizer  *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"begin");
        int i = 0;//获取数组中得view位置
        for (UIView * view in self.view.subviews)
        {
            i = i + 1;
            //角度偏移矩阵
            CGAffineTransform t1 = CGAffineTransformMakeRotation(0.03);
            CGAffineTransform t2 = CGAffineTransformMakeRotation(-0.03);
            
            if (i%2 == 1)
            {
                view.transform = t1;
            }
            else
            {
                view.transform = t2;
            }
            
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
                //[UIView setAnimationRepeatCount:12.0];
                if (i%2 == 1)
                {
                    view.transform = t2;
                }
                else
                {
                    view.transform = t1;
                }
                
            } completion:^(BOOL finished){
                
                [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
                 {
                     CGAffineTransform t = CGAffineTransformMakeScale(1,1);
                     for (UIView * view in self.view.subviews)
                     {
                         view.tag = 0;
                         view.transform = t;
                     }
                 } completion:^(BOOL finished)
                 {
                     NSLog(@"完成");
                 }];
                
                
            }];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"changed");
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"end");
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
