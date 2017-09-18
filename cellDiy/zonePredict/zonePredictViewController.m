//
//  zonePredictViewController.m
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "zonePredictViewController.h"
#import "OFeiCommon.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "NormalViewController.h"
#import "PellTableViewSelect.h"
#import "PartitionViewController.h"

#import "PointPredictViewController.h"
#import "AreaPredictViewController.h"
#import "RoutesPredictViewController.h"
#import "WarnInformationViewController.h"

#import "zone24H.h"
#import <ArcGIS/ArcGIS.h>

#define kDockHeight 44
#define DockColor   [UIColor colorWithRed:0.f green:166.f/255.f blue:240.f/255.f alpha:1.f]

@interface zonePredictViewController ()<MKMapViewDelegate,UITabBarControllerDelegate,UITabBarDelegate,DockDelegate,AGSWebMapDelegate,AGSMapViewLayerDelegate,AGSLayerDelegate>

{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    NormalViewController *normal;
    NSString *_title;
//    returnTitleBlock _returnblock;
    zone24H *zone24;

}

@property(nonatomic,strong) NSArray *menuItems;
@end

@implementation zonePredictViewController


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
    NSString *title = @"分区预报";
    [self setNavTitle:title];
    self.title = @"分区预报";
    [self setButton];
    [self initGUI];
}


//设置顶部右侧按钮
-(void)setButton
{
//    self.navigationController.navigationBar.barTintColor = BarColor;
    //词方法可以用来放置标题的下拉按钮
    //    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton1 addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
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


-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];

}

-(void)selectArea
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width-100, 64, 100, 190) selectData:@[@"A区",@"B区",@"C区",@"D区"] action:^(NSInteger index) {
        PartitionViewController *partition = [[PartitionViewController alloc] init];
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A区";

        }
        else if (index == 1) {
            _title = @"B区";

        }
        else if (index == 2) {
            _title = @"C区";

        }
        else if (index == 3) {
            _title = @"D区";

        }
        //在此处传递选择的区域值到partition页面：使用通知中心的模式进行传值
        self.delegate = partition;
        [self.delegate sendTitle:_title];
        [self.navigationController pushViewController:partition animated:YES];
        
    } animated:YES];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"你好");
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
    NSLog(@"%@",text);
    [label sizeToFit];
    
}
#define 设置显示的地图
-(void)initGUI{
//    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [AGSRuntimeEnvironment setClientID:@"kEpOhTfdwMTLW4St" error:nil];
    AGSMapView *mapview = [[AGSMapView alloc] initWithFrame:self.view.bounds];
    [mapview setGridLineWidth:0];
    [mapview setGridLineColor:[UIColor clearColor]];
    mapview.backgroundColor = [UIColor grayColor];
    mapview.layerDelegate = self;
    [self.view addSubview:mapview];
    
    
    NSURL *url_Tiled = [NSURL URLWithString:KMainMap];
    AGSDynamicMapServiceLayer *tiledLyr = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:url_Tiled];
    [mapview addMapLayer:tiledLyr withName:@"TiledLayer"];
    tiledLyr.delegate = self;
    
    AGSGraphicsLayer* myGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [mapview addMapLayer:myGraphicsLayer withName:@"Graphics Layer"];
    
    
    NSURL *url_zone = [NSURL URLWithString:KmapZone];
    AGSDynamicMapServiceLayer *tiledLyr1 = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:url_zone];
    [mapview addMapLayer:tiledLyr1 withName:@"TiledLayer1"];
    
    
    //设定地图初始化显示范围为中国
    AGSEnvelope *chinaEnv =[AGSEnvelope envelopeWithXmin:120.54707419812024
                                                    ymin:27.94215160670183
                                                    xmax:121.26245137296617
                                                    ymax:27.594495785487935
                                        spatialReference:mapview.spatialReference];
    [mapview zoomToEnvelope:chinaEnv animated:YES];
}

@end
