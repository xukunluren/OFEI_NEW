//
//  PartitionViewController.m
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "PartitionViewController.h"
#import "zonePredictViewController.h"
#import "PellTableViewSelect.h"
#import "NormalViewController.h"
#import "OFeiCommon.h"
#import "zoneA.h"
#import "zoneB.h"
#import "zoneC.h"
#import "zoneD.h"


@interface PartitionViewController ()<sendTitleDelegate,UIScrollViewDelegate,NSURLConnectionDataDelegate,AGSWebMapDelegate,AGSMapServiceInfoDelegate,AGSMapViewLayerDelegate,AGSMapViewTouchDelegate>
{
    NSString *title;
    
    AGSGraphicsLayer *_webGraphicsLayer;
    AGSMapView *_mapView;
    
    UILabel *_titleLabel;
    UIImageView *_zoneA;
}
@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation PartitionViewController
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
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage.jpeg"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];

    
    UILabel *zoneAnav = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    zoneAnav.text = @"A区";
    zoneAnav.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = zoneAnav;
    
//    title = @"A区";
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
    //设置分页、弹簧效果、水平滚动条、滚动区域大小
    [_scrollView setPagingEnabled:YES];
    [_scrollView setBounces:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width * 4, _scrollView.bounds.size.height)];
    [_scrollView setDelegate:self];
    
    //分页控件
    NSInteger pages = 4;
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(300, self.view.frame.size.height - self.view.frame.size.height/10, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    NSLog(@"%f",self.view.frame.size.height-self.view.frame.size.height/10);
    pageControl.numberOfPages = pages;
    [pageControl setCenter:CGPointMake(_scrollView.bounds.size.width/2, self.view.frame.size.height*0.99)];
    pageControl.currentPage = 0;
    [pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    [self createPages:pages];
    [self.view addSubview:_scrollView];

    [self setNoFresh];
    [self setButton];
//    [self setNavTitle:title];
//    [self changeView];
   }
-(void)setNoFresh
{
    UILabel *unitName = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.15, 0.17*KHight, KWight*0.5, 0.2*KHight)];
    unitName.numberOfLines = 0;
    unitName.text = @"国家海洋局\n东海预报中心";
    unitName.textAlignment = UITextAlignmentCenter;
    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16];
    [self.view addSubview:unitName];
    
    UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(15,KHight*0.2,60,60)];
    logo.image=[UIImage imageNamed:@"LOGO.png"];
    [self.view addSubview:logo];
    
    UILabel *releaseTime = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.05, KHight*0.25 , 200, 100)];
    releaseTime.text = @"发布时间:2015-11-25 09:30";
    releaseTime.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:14];
    [self.view addSubview:releaseTime];
    
    //别写死
    _zoneA = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.58, KHight*0.15, 130, 130)];
    _zoneA.layer.cornerRadius = 10.0;
    _zoneA.layer.masksToBounds = YES;
    _zoneA.image = [UIImage imageNamed:@"areaA@2x.png"];
    
    [self.view addSubview:_zoneA];
}

- (void)createPages:(NSInteger)pages {
    for (int i = 0; i < pages; i++) {
        
        if (i == 0) {
            zoneA *view = [[zoneA alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
            view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.0];
            [_scrollView addSubview:view];
//            self.navigationController.title = @"A";
//            [self setNavTitle:@"A"];
        }else if (i == 1){
            zoneB *view = [[zoneB alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
            view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.0];
            [_scrollView addSubview:view];
//            self.navigationController.title = @"B";
//            [self setNavTitle:@"B"];
        }else if (i == 2){
            zoneC *view = [[zoneC alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
            view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.0];
            [_scrollView addSubview:view];
            
        }else if (i == 3){
            zoneD *view = [[zoneD alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
            view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.0];
            [_scrollView addSubview:view];
        }
        
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"123123");
    NSUInteger pageNo = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    [self.pageControl setCurrentPage:pageNo];
    NSLog(@"%lu",(unsigned long)pageNo);
    if (pageNo == 0) {
        [self setNavTitle:@"A区"];
        _zoneA.image = [UIImage imageNamed:@"areaA@2x.png"];
    }else if (pageNo == 1){
        [self setNavTitle:@"B区"];
        _zoneA.image = [UIImage imageNamed:@"areaB@2x.png"];
    }else if (pageNo == 2){
        [self setNavTitle:@"C区"];
        _zoneA.image = [UIImage imageNamed:@"areaC@2x.png"];
    }else if (pageNo == 3){
        [self setNavTitle:@"D区"];
        _zoneA.image = [UIImage imageNamed:@"areaD@2x.png"];
    }
    
}




#pragma mark - 判断url
- (NSURL *)judgeZone24:(NSString *)_title
{
    NSURL *url;
    if ([_title isEqualToString:@"A区"]) {
        url = [NSURL URLWithString:urlZoneA24];
    }else if ([_title isEqualToString:@"B区"]){
        url = [NSURL URLWithString:urlZoneB24];
    }else if ([_title isEqualToString:@"C区"]){
        url = [NSURL URLWithString:urlZoneC24];
    }else if ([_title isEqualToString:@"D区"]){
        url = [NSURL URLWithString:urlZoneD24];
    }
    return url;
}



- (NSURL *)judgeZone48:(NSString *)_title
{
    NSURL *url;
    if ([_title isEqualToString:@"A区"]) {
        url = [NSURL URLWithString:urlZoneA48];
    }else if ([_title isEqualToString:@"B区"]){
        url = [NSURL URLWithString:urlZoneB48];
    }else if ([_title isEqualToString:@"C区"]){
        url = [NSURL URLWithString:urlZoneC48];
    }else if ([_title isEqualToString:@"D区"]){
        url = [NSURL URLWithString:urlZoneD48];
    }
    return url;
}



- (NSURL *)judgeZone72:(NSString *)_title
{
    NSURL *url;
    if ([_title isEqualToString:@"A区"]) {
        url = [NSURL URLWithString:urlZoneA72];
    }else if ([_title isEqualToString:@"B区"]){
        url = [NSURL URLWithString:urlZoneB72];
    }else if ([_title isEqualToString:@"C区"]){
        url = [NSURL URLWithString:urlZoneC72];
    }else if ([_title isEqualToString:@"D区"]){
        url = [NSURL URLWithString:urlZoneD72];
    }
    return url;
}



#pragma mark - 设置nav标题
-(void)setNavTitle:(NSString *)_title
{
    UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
//    select.frame = CGRectMake(15, 0, 40, 40);
//    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
//    [select addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
        
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(0, 10, 40, 40);
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    _titleLabel = label;
    _titleLabel.text = _title;
    [_titleLabel sizeToFit];
//    [middle addSubview:select];
    [middle addSubview:label];

    [label sizeToFit];
    self.navigationItem.titleView = middle;
}

-(void)setButton
{
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *backNormal = [UIButton buttonWithType:UIButtonTypeCustom];
    backNormal.frame = CGRectMake(0, 2, 40, 40);
//    [backNormal addTarget:self action:@selector(backNormal) forControlEvents:UIControlEventTouchUpInside];
    [backNormal setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:backNormal];
//    self.navigationItem.rightBarButtonItem = right;
}

- (void)backNormal
{
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
}

//返回按钮
- (void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;

}


//- (void)selectArea
//{
//    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.4, 64, 100, 190) selectData:@[@"A区",@"B区",@"C区",@"D区"]
//       action:^(NSInteger index){
//           
//           NSLog(@"您选择了%ld",(long)index);
//           if (index == 0) {
//               title = @"A区";
//
//           }else if (index == 1){
//               title = @"B区";
//               
//           }else if (index == 2){
//               title = @"C区";
//               
//           }else if (index == 3){
//               title = @"D区";
//
//           }
//           [self setNavTitle:title];
//
//    } animated:YES];
//}

//风级转换
- (NSString *)word:(NSString *)dirdir
{
    NSString *word ;
    
    if ([dirdir isEqualToString:@"W"]) {
        word = @"西";
    }else if ([dirdir isEqualToString:@"S"]){
        word = @"南";
    }else if ([dirdir isEqualToString:@"N"]){
        word = @"北";
    }else if ([dirdir isEqualToString:@"E"]){
        word = @"东";
    }
    return word;
}



//风速等级转换
- (NSString *)level:(NSNumber *)windsu
{
    NSString *level;
    CGFloat number = [windsu doubleValue];
    NSLog(@"%f",number);
    //    NSNumber *windsu;
    
    if (0< number < 0.2) {
        level = @" 0 ";
    }else if (number < 1.5){
        level = @" 1 ";
    }else if (number < 3.3){
        level = @" 2 ";
    }else if (number < 5.4){
        level = @" 3 ";
    }else if (number < 7.9){
        level = @" 4 ";
    }else if (number < 10.7){
        level = @" 5 ";
    }else if (number < 13.8){
        level = @" 6 ";
    }else if (number < 17.1){
        level = @" 7 ";
    }else if (number < 20.7){
        level = @" 8 ";
    }else if (number < 24.4){
        level = @" 9 ";
    }else if (number < 28.4){
        level = @" 10 ";
    }else if (number< 32.6){
        level = @" 11 ";
    }else if (number > 32.6){
        level = @" 12 ";
    }
    return level;
}



@end
