//
//  PointViewController.m
//  OFei
//
//  Created by admin on 15/10/31.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "PointViewController.h"
//#import "PointPredictViewController.h"
#import "Dock.h"
#import "windViewController.h"
#import "waveViewController.h"
#import "flowViewController.h"
#import "shortTideViewController.h"
#import "longTideViewController.h"
#import "CustomTableView.h"
#import "OFeiCommon.h"
#import "PointWind+CoreDataProperties.h"
#import "PellTableViewSelect.h"




@interface PointViewController ()<DockDelegate>

@end

@implementation PointViewController
{
    NSString *_title;
    NSMutableArray *_windSpeedArray;
    NSMutableArray *_windPowerArray;
    NSMutableArray *_windDirection;
    NSMutableArray *_dateArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
// Do any additional setup after loading the view.
//    self.tabBarController.tabBar.hidden = YES;
//    self.view.backgroundColor = [UIColor purpleColor];
//     _myAppDelegate = [[UIApplication sharedApplication] delegate];
//    //添加所有子控制器
//    [self addAllChildControllers];
//    //添加Dock
//    [self addDock];
//    //添加表格
////    [self setTable];
//    [self setButton];
}

//设置顶部右侧按钮
-(void)setButton
{
    //    self.navigationController.navigationBar.barTintColor = BarColor;
    //词方法可以用来放置标题的下拉按钮
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton1 addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];
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


-(void)selectPoint
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width-100, 64, 100, 190) selectData:@[@"A点",@"B点",@"C点",@"D点"] action:^(NSInteger index) {
        PointViewController *point = [[PointViewController alloc] init];
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A点";
        }
        if (index == 1) {
            _title = @"B点";
        }
        if (index == 2) {
            _title = @"C点";
        }
        if (index == 3) {
            _title = @"D点";
        }
        NSLog(@"%@",_title);
        //在此处传递选择的区域值到partition页面：使用通知中心的模式进行传值
//        self.delegate = point;
//        [self.delegate sendTitle:_title];
        
        
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        //        backItem.title = @"返回";
        //        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        //        self.navigationItem.backBarButtonItem = backItem;
        //        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        //
        
        //自定义返回按钮
        UIImage *backButtonImage = [[UIImage imageNamed:@"left-25.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //将返回按钮的文字position设置不在屏幕上显示
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left-25.png"] style:UIBarButtonItemStylePlain target:self action:nil];
        //
        //        [self.navigationItem setBackBarButtonItem:backItem];
        [self.navigationController pushViewController:point animated:YES];
        
    } animated:YES];
}


-(NSURL *)judgePoint:(NSString *)point
{
    NSURL *url;
    if ([point isEqualToString:@"A点"]) {
        url= [NSURL URLWithString:@KPointwindA];
    }
    if ([point isEqualToString:@"B点"]) {
        url= [NSURL URLWithString:@KPointwindB];
    }
    if ([point isEqualToString:@"C点"]) {
        url= [NSURL URLWithString:@KPointwindC];
    }
    if ([point isEqualToString:@"D点"]) {
        url= [NSURL URLWithString:@KPointwindD];
    }
    return url;
}

-(void)getDataFromUrl:(NSURL *)url andModel:(NSString *)model
{
    NSLog(@"网址路径是==%@",url);
    //创建请求
    
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *mutableFetchResult = [self getDataFromcoreData:model];
        if (mutableFetchResult.count > 10) {
            for(NSDictionary *dic in result){
                [self updateDataToModel:dic andModel:model];
            }
        }else{
            for(NSDictionary *dic in result){
                [self insertdataToModel:dic andModel:model];
            }
        }
    }];
    NSArray *aray = [self getDataFromcoreData:model];
    NSLog(@"数组分别是多少2222%@=",aray);
    
}
    




#pragma mark - 1. 添加子控制器
- (void)addAllChildControllers
{
    NSLog(@"主标题是==%@",_dateArray);
    windViewController *wind = [[windViewController alloc]init];
    wind.point = _title;
    [self addChildViewController:wind];
    
    waveViewController *wave = [[waveViewController alloc]init];
    wave.point = _title;
    [self addChildViewController:wave];
    
    flowViewController *flow = [[flowViewController alloc]init];
    flow.point = _title;
    [self addChildViewController:flow];
    
    shortTideViewController *shortTide = [[shortTideViewController alloc]init];
    shortTide.point = _title;
    [self addChildViewController:shortTide];
    
    longTideViewController *longTide = [[longTideViewController alloc]init];
    longTide.point = _title;
    [self addChildViewController:longTide];
}


#pragma mark - 2. 添加Dock
- (void)addDock
{
    Dock *dock = [[Dock alloc]init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.backgroundColor = DockColor;
    dock.delegate = self;
//    [self.view insertSubview:dock atIndex:2];
    [self.view addSubview:dock];
    //2.dock中添加内容  更改图标
    [dock addItemWithIcon:@"Wind@2x.png" selectedIcon:@"WindFilled@2x.png" title:@"风"];
    [dock addItemWithIcon:@"Wave@2x.png" selectedIcon:@"WaveFilled@2x.png" title:@"浪"];
    [dock addItemWithIcon:@"Flow@2x.png" selectedIcon:@"FlowFilled@2x.png" title:@"流"];
    [dock addItemWithIcon:@"LowTide@2x.png" selectedIcon:@"LowTideFilled@2x.png" title:@"短潮"];
    [dock addItemWithIcon:@"LongTide@2x.png" selectedIcon:@"LongTideFilled@2x.png" title:@"长潮"];

    
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


//#pragma 委托代理传值实现方法
//- (void)sendTitle:(NSString *)title
//{
//    _title = title;
////    NSString *model = @"PointWind";
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:15.0];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor]; // change this color
//    self.navigationItem.titleView = label;
//    label.text = title;
//    [label sizeToFit];
//    //获取网络数据
//
//}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}


     
     
-(void)insertdataToModel:(NSDictionary *)dic andModel:(NSString *)model
    {
      
            //数据解析部分，与更新数据库的代码有重复，可进一步精简------xk
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            NSNumber *windid1 = [dic objectForKey:@"pntid"];
            NSString *windid = [numberFormatter stringFromNumber:windid1];
            NSNumber *winddirection1 = [dic objectForKey:@"dir"];
            NSString *winddirection = [numberFormatter stringFromNumber:winddirection1];
            NSNumber *windpower1 = [dic objectForKey:@"power"];
            NSString *windspeed = [numberFormatter stringFromNumber:windpower1];
            NSString *date = [dic objectForKey:@"datatime"];
           NSString *windPower = [self getwindpower:windpower1];
            
        
            
            
            //若数据库中存在数据则更新数据，如数据库为空则插入数据
            PointWind *pointwind = [NSEntityDescription insertNewObjectForEntityForName:@"PointWind" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
            
            [pointwind setValue:windid forKey:@"windpoint"];
            [pointwind setValue:winddirection forKey:@"winddirection"];
            [pointwind setValue:windspeed forKey:@"windspeed"];
            [pointwind setValue:date forKey:@"date"];
            [pointwind setValue:windPower forKey:@"windpower"];

        //        NSArray *array = [self getDataFromcoreData:model];
    }
     
     
     
-(void)updateDataToModel:(NSDictionary *)dic andModel:(NSString *)model
    {
        
      
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            
            NSNumber *windid1 = [dic objectForKey:@"pntid"];
            NSString *windid = [numberFormatter stringFromNumber:windid1];
            NSNumber *winddirection1 = [dic objectForKey:@"dir"];
            NSString *winddirection = [numberFormatter stringFromNumber:winddirection1];
            NSNumber *windpower1 = [dic objectForKey:@"power"];
            NSString *windspeed = [numberFormatter stringFromNumber:windpower1];
            NSString *date = [dic objectForKey:@"dataTime"];
            NSString *windpower = [self getwindpower:windpower1];
            
            
            NSFetchRequest* request=[[NSFetchRequest alloc] init];
            NSEntityDescription* user=[NSEntityDescription entityForName:@"PointWind" inManagedObjectContext:_myAppDelegate.managedObjectContext];
            [request setEntity:user];
            
            NSError* error=nil;
            NSMutableArray *mutableFetchResult=[[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
            //若数据库中存在数据则更新数据，如数据库为空则插入数据
            
            for (PointWind *pointwind in mutableFetchResult) {
                pointwind.windpoint = windid;
                pointwind.winddirection = winddirection;
                pointwind.windpower = windpower;
                pointwind.date = date;
                pointwind.windspeed = windspeed;
                
            }
        
        
    }



-(NSArray *)getDataFromcoreData:(NSString *)model
{
    
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:model inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:user];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult = [[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    return mutableFetchResult;
}

-(NSString *)getwindpower:(NSNumber *)number
{
    NSString *power;
    NSInteger i = [number integerValue];
    
    if (i<0.4) {
        power = @"0";
    }
    else if (i<1.6) {
        power = @"1";
    }
    else if (i<3.4) {
        power = @"2";
    }
    else   if (i<5.5) {
        power = @"3";
    }
    else if (i<8.0) {
        power = @"4";
    }
    else  if (i<10.8) {
        power = @"5";
    }
    else if (i<13.9) {
        power = @"6";
    }
    else if (i<17.2) {
        power = @"7";
    }
    else if (i<20.8) {
        power = @"8";
    }
    else  if (i<24.5) {
        power = @"9";
    }
    else if (i<28.5) {
        power = @"10";
    }
    else  if (i<32.7) {
        power = @"11";
    }
    else  if (i<37) {
        power = @"12";
    }
    else  if (i<41.5) {
        power = @"13";
    }
    else  if (i<46.2) {
        power = @"14";
    }
    else  if (i<51.1) {
        power = @"15";
    }
    else  if (i<56.1) {
        power = @"16";
    }
    
    return power;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
     }

@end
