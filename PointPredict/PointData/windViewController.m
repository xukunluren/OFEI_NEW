//
//  windViewController.m
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "windViewController.h"
#import "CustomTableView.h"
#import "OFeiCommon.h"
#import "PointViewController.h"
#import "fourTableViewCell.h"
#import "AFNetworking.h"
#import "MyRequest.h"
#import "PellTableViewSelect.h"
#import "CNPGridMenu.h"
#import "NormalViewController.h"
#import "dataAnaly.h"
#import "DiyTheme.h"

#define kHight [UIScreen mainScreen].bounds.size.height
#define NUM 10
//绘图空间与底部距离
#define GRAPAHBOTTOMPAD 80.0f


//x轴起点
#define XRANGEBEGIN 10.0
//x轴在屏幕可视范围内的范围
#define XRANGELENGTH 4.0
//y轴起点
#define YRANGEBEGIN 0.0
//y轴在屏幕可视范围内的范围
#define YRANGELENGTH 100.0


//x轴屏幕范围内大坐标间距
#define XINTERVALLENGTH 1.0
//x轴坐标的原点（y轴将在此与x轴相交）
#define XORTHOGONALCOORDINATE 10.0
//x轴每两个大坐标间小坐标个数
#define XTICKSPERINTERVAL 2

#define YINTERVALLENGTH 1.0
#define YORTHOGONALCOORDINATE 1.0
#define YTICKSPERINTERVAL 0


#define num 100


@interface windViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CNPGridMenuDelegate,CPTPlotSpaceDelegate,CPTScatterPlotDelegate>

{
    
    double xl[num];//散点的x坐标
    double y1[num];//第1个散点图的y坐标
    
 
}
@property (nonatomic, strong) CNPGridMenu *gridMenu;

@end

@implementation windViewController
{
    PointViewController *pointview;
    UIButton *_upButton;
   
    
    NSString *_title;
    UILabel *_titleLabel;
    UILabel *_publishTime;
    
    NSArray *DateTime;
    NSArray *temp1;
    NSMutableArray *_datetimeArray;
    NSMutableArray *_valueArray;
    NSMutableArray *_interArray;
    
    dataAnaly *_datAnaly;
    
    NSMutableArray *_keduArray;
    
    NSMutableArray *_windDirForTu;
    
    NSMutableArray *datasForPlot;
    NSMutableArray *_dataJQ;

    UIImageView *_picture;
    CGPoint _pointOfTouch;
    
    NSUInteger _indexOfSymbol;
    NSString *_dataTime;
    
    
    NSMutableArray *_array;
    NSMutableArray *_similarLength;
    
    UILabel *detail;
    
    UILabel *releaseTime;
}



#pragma mark - 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏底部线
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bargound.png"];
}

-(void)viewDidLoad {
    [super viewDidLoad];
   
    _title = @"A点";
    self.tabBarController.tabBar.hidden = NO;
      _datAnaly = [[dataAnaly alloc] init];
//可变数组的初始化
    _array = [[NSMutableArray alloc]init];
    _keduArray = [[NSMutableArray alloc] init];
    _datetimeArray = [[NSMutableArray alloc] init];
    _valueArray = [[NSMutableArray alloc] init];
    _windDirection = [[NSMutableArray alloc] init];
    _windPowerArray = [[NSMutableArray alloc] init];
    _windSpeedArray = [[NSMutableArray alloc] init];
    _dateArray = [[NSMutableArray alloc] init];
    _interArray = [[NSMutableArray alloc] init];
    _windDirForTu = [[NSMutableArray alloc] init];
    datasForPlot = [[NSMutableArray alloc] init];
    _dataJQ = [[NSMutableArray alloc]init];
    _similarLength = [[NSMutableArray alloc]init];
    
    _indexOfSymbol = 200;
    
    //设置背景图片
//    [self dataSourceInit];
    [self setbackImage];
//    [self setMapView:_title];
    //显示详细；
    detail = [[UILabel alloc]initWithFrame:CGRectMake(40, KHight*0.4, KWight-40, 100)];
    detail.textColor = [UIColor blackColor];
    detail.font = [UIFont fontWithName:@"Arial" size:14];
    detail.textAlignment = NSTextAlignmentLeft;
    detail.numberOfLines = 0;
//    detail.backgroundColor = [UIColor blackColor];
    //    detial.alpha = 0.4;
    //    detial.text = @"日期:  潮高(m):";
    [self.view addSubview:detail];

    [self setButton];
    [self setNavTitle:_title];
   
    [self initTableAndPicture];
//    NSArray *dateArray1 = [self  getDataFromNet:_title];
    [self  getDataFromNet:_title];
//    [self setXY:dateArray1];
    
    [self setTextNoRefesh];
   
}



-(void)setbackImage
{
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
}

-(void)initTableAndPicture

{
    //获取网络数据用于展示用
    graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
    //给画板添加一个主题
//    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    CPTTheme *theme = [[DiyTheme alloc] init];
    [graph applyTheme:theme];
    
    /* 添加hostingView作为graph的容器，因为graph只能在这上面显示 */
    //创建主画板视图添加画板
     _hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0.41*KHight, KWight, KHight*0.6-44)];
    _hostView.hostedGraph = graph;
    _hostView.alpha = 0.6;
    _hostView.collapsesLayers = NO;
    [self.view addSubview:_hostView];
    
    //设置留白
    graph.paddingLeft = 3;
    graph.paddingTop = 20;
    graph.paddingRight = 3;
    graph.paddingBottom = 15;

    graph.plotAreaFrame.paddingLeft = 30.0;
    graph.plotAreaFrame.paddingTop = 20.0;
    graph.plotAreaFrame.paddingRight = 5.0;
    graph.plotAreaFrame.paddingBottom = 20.0;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    //允许用户交互
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0)   lengthDecimal:CPTDecimalFromFloat(20.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0) lengthDecimal:CPTDecimalFromFloat(16.0)];
    plotSpace.delegate = self;
    
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:@(0) length:@(80)];
    //            plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal];
//    NSLog(@"%@",dateArray1);
    

    _windTable = [[UITableView alloc] initWithFrame:CGRectMake(0+KWight, 0.4*KHight, KWight, KHight*0.6 - 44)];
    _windTable.layer.cornerRadius = 10;
    _windTable.layer.masksToBounds = YES;
    _windTable.alpha = 0.6;
    [_windTable setDelegate:self];
    [_windTable setDataSource:self];
    [self.view addSubview:_windTable];
}

-(void)setNavTitle:(NSString *)title
{
    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(0, 0, 60, 40);
    _titleLabel.text = _title;
    [select setTitle:_title forState:UIControlStateNormal];
    select.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0,  0);
    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
    select.imageEdgeInsets = UIEdgeInsetsMake(0,  0, 0, -60);
    [select addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = select;
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

//    [exampleButton1 addTarget:self action:@selector(handleLongPress2) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
//    self.navigationItem.rightBarButtonItem = right;
    

  

}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}
//响应的事件
-(void)handleLongPress2{
    
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
    
}



-(void)selectPoint
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.4, 64, 100, 190) selectData:@[@"A点",@"B点",@"C点",@"D点"] action:^(NSInteger index) {
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A点";
            _picture.image = [UIImage imageNamed:@"pointA"];
        }
        if (index == 1) {
            _title = @"B点";
            _picture.image = [UIImage imageNamed:@"pointB"];

        }
        if (index == 2) {
            _title = @"C点";
            _picture.image = [UIImage imageNamed:@"pointC"];

        }
        if (index == 3) {
            _title = @"D点";
            _picture.image = [UIImage imageNamed:@"pointD"];

        }
        [self viewDidAppear:YES];
        NSLog(@"%@",_title);
        
   // NSArray *dateArray2 = [self getDataFromNet:_title];
        
        [self setNavTitle:_title];
//        [self setMapView:_title];
        [self judgePoint:_title];
        //[self setXY:dateArray2];
        [_windTable reloadData];
        [self getDataFromNet:_title];
        //NSArray *dateArray1 = [self  getDataFromNet:_title];
        //[self setXY:dateArray1];
        detail.text = @" ";
        _indexOfSymbol = 200;
        [graph reloadData];
        
    } animated:YES];
}
//初始化不需要刷新的控件
-(void)setTextNoRefesh
{
//    UILabel *unitName = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.5, 0.15*KHight, 100, 40)];
//    unitName.text = @"国家海洋局";
//    unitName.textAlignment = UITextAlignmentCenter;
//    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:18];
//    [self.view addSubview:unitName];
//    UILabel *unitName1 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.5, 0.2*KHight, 150, 40)];
//    unitName1.text = @"东海预报中心";
//    //    unitName1.textAlignment = NSTextAlignmentCenter;
//    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:18];
//    [self.view addSubview:unitName1];
//    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(KWight*0.5, 0.18*KHight, KWight*0.5, 0.2*KHight)];
//    label2.text = @"数据时间:2015-11-25 09:30";
//    label2.font = [UIFont systemFontOfSize:12.0];
//    label2.textColor = [UIColor blackColor];
//    [self.view addSubview:label2];
    UILabel *unitName = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.15, 0.08*KHight, KWight*0.5, 0.2*KHight)];
    unitName.numberOfLines = 0;
    unitName.text = @"国家海洋局\n东海预报中心";
    unitName.textAlignment = UITextAlignmentCenter;
    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16];
    [self.view addSubview:unitName];
    
    UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(15,KHight*0.12,KWight*0.19,KWight*0.19)];
    logo.image=[UIImage imageNamed:@"LOGO.png"];
    [self.view addSubview:logo];
    
    releaseTime = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.05, KHight*0.2 , 200, 100)];
    //releaseTime.text = @"发布时间:2015-11-16 09:00";
    //releaseTime.text=pubtime;
    releaseTime.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:14];
    [self.view addSubview:releaseTime];
    
    //不要写死不要写死
    _picture = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.58, 65, KWight*0.38, KWight*0.38)];
    _picture.layer.cornerRadius = 10.0;
    _picture.layer.masksToBounds = YES;
    _picture.image = [UIImage imageNamed:@"pointA"];
    [self.view addSubview:_picture];
   
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"图",@"表", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    segment.frame = CGRectMake(KWight*0.23,0.33 *KHight,KWight*0.625, KWight*0.125);
    segment.segmentedControlStyle =UISegmentedControlStyleBar;
    segment.tintColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    //    [segment setBackgroundColor:[UIColor redColor]];
    //    [segment setTintColor:[UIColor whiteColor]];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
}



-(void)segmentChange:(UISegmentedControl *)object
{
    int Index = (int)object.selectedSegmentIndex;
    NSLog(@"序号是多少=====%d",Index);
    switch (Index) {
        case 0:
            [self firstSegment];//调用firstsegment方法
            break;
        case 1:
            [self secondSegment];//
            break;
                default:
            break;
    }

}


- (void)firstSegment
{
     _windTable.frame  = CGRectMake(0+KWight, 0.4*KHight,KWight,KHight*0.6-44);
      _windTable.hidden  = YES;
      _hostView.frame = CGRectMake(0 ,0.4*KHight,KWight,KHight*0.6-44);
    graph.hidden = NO;
    detail.hidden = NO;
     _hostView.hidden = NO;

   
}

- (void)secondSegment
{
    
    _hostView.frame  = CGRectMake(0+ KWight,0.4*KHight,KWight,KHight*0.6-44);
      NSLog(@"%f",_hostView.frame.origin.x);
    _hostView.hidden  = YES;
     graph.hidden = YES;
    detail.hidden = YES;
    _windTable.hidden = NO;
    _windTable.frame = CGRectMake(0,0.4*KHight,KWight,KHight*0.6-44);
    
    NSLog(@"%f",_windTable.frame.origin.x);
}



//设置XY轴的坐标样式
-(void)setXY:(NSArray *)dateArray
{
    
    //    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 8.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 1.5f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 8.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    gridLineStyle.lineColor = [CPTColor grayColor];
    gridLineStyle.lineWidth = 0.5f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet =(CPTXYAxisSet *)graph.axisSet;
    // 3 - Configure x-axis
    CPTAxis *X = axisSet.xAxis;
//    X.title = @"数据时间";
    X.titleTextStyle = axisTitleStyle;
    X.titleOffset = -10.0f;
    X.axisLineStyle = axisLineStyle;
    X.labelingPolicy = CPTAxisLabelingPolicyNone;
    X.labelTextStyle = axisTextStyle;
    X.majorTickLineStyle = axisLineStyle;
    X.majorTickLength = 4.0f;
    X.tickDirection = CPTSignNegative;
   
    //构造MutableArray，用于存放自定义的轴标签
    NSMutableArray*customLabels = [NSMutableArray arrayWithCapacity:_valueArray.count];
    //构造一个TextStyle
    static CPTTextStyle*labelTextStyle=nil;
    labelTextStyle=[[CPTTextStyle alloc]init];
    NSString *text = @"nihao";
    NSString *labelText;
    //做判断，若缩放则展示的日期数据就3个，若不缩放则展示全部的数据
    for (int i=0;i<_valueArray.count;) {
        NSString *textdate = dateArray[i];
        
        labelText = textdate;
        text = [textdate substringToIndex:6];

        if ([_dataJQ[i] isEqualToString:_publishTime.text]) {
            
            CPTAxisLabel *newLabel =[[CPTAxisLabel alloc] initWithText:text textStyle:labelTextStyle];
            //更改显示位置
            newLabel.tickLocation = @(i+_similarLength.count/2);
            newLabel.offset = 5;  //X.labelOffset + X.majorTickLength
            newLabel.rotation = 2*M_PI;
            [customLabels addObject:newLabel];
            [_keduArray addObject:[NSNumber numberWithInt:i]];
            
            i=i+_similarLength.count;
        }else{
        
        CPTAxisLabel *newLabel =[[CPTAxisLabel alloc] initWithText:text textStyle:labelTextStyle];
        //更改显示位置
        newLabel.tickLocation = @(i+12);
        newLabel.offset = 5;  //X.labelOffset + X.majorTickLength
        newLabel.rotation = 2*M_PI;
        [customLabels addObject:newLabel];
        [_keduArray addObject:[NSNumber numberWithInt:i]];
        i=i+24;
        }
        
        
    }
    
     X.majorTickLocations = [NSSet setWithArray:_keduArray];
    X.axisLabels =  [NSSet setWithArray:customLabels];
    
    
    
    //y轴
    CPTXYAxis *y =axisSet.yAxis;
    //y轴：不显示小刻度线
    y.minorTickLineStyle = nil;
    //大刻度线间距：50单位
    
    y.majorIntervalLength = @(2.0);
    y.orthogonalPosition = @(50);
    y.titleLocation = @(16.5);
    y.titleOffset =  0.f;
    //坐标原点：0
    y.titleRotation= 2 * M_PI;
    y.title= @"m/s";
//        y.labelingPolicy = CPTAxisLabelingPolicyNone;
    //固定XY轴的显示位置，使其不随屏幕的滑动而移动
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    
    
    //    创建蓝色区域
    CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
    boundLinePlot.plotSymbolMarginForHitDetection = 10.0f;
    boundLinePlot.dataSource = self;
    boundLinePlot.delegate = self;
    //    设置绿色区域边框的样式
    CPTMutableLineStyle *lineStlye = [CPTMutableLineStyle lineStyle];
 
    
    
    lineStlye.miterLimit = 1.0f;
    lineStlye.lineWidth  = 1.0f;
    lineStlye.lineColor  = [CPTColor blackColor];
    boundLinePlot.dataLineStyle = lineStlye;
    boundLinePlot.identifier = @"Blue Plot";
  
    //设置数据源代理
    
    [graph addPlot:boundLinePlot];
    
    
    
    
    
    // Animate in the new plot: 淡入动画
//    boundLinePlot.opacity = 0.0f;
//    
//    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeInAnimation.duration            = 3.0f;
//    fadeInAnimation.removedOnCompletion = NO;
//    fadeInAnimation.fillMode            = kCAFillModeForwards;
//    fadeInAnimation.toValue             = [NSNumber numberWithFloat:1.0];
//    [boundLinePlot addAnimation:fadeInAnimation forKey:@"shadowOffset"];
//    
//    
    
//    [graph addPlot:boundLinePlot];
    
    
    //手势添加
//    UIPanGestureRecognizer *panGr=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewPan:)];
//    [_hostView addGestureRecognizer:panGr];
   
  }



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"123123");
    NSUInteger pageNo = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    [self.pageControl setCurrentPage:pageNo];
}


    
-(NSURL *)judgePoint:(NSString *)title
{
    NSURL *url;
    
    if ([title isEqualToString:@"A点"]) {
        url= [NSURL URLWithString:@KPointwindA];
    }
    if ([title isEqualToString:@"B点"]) {
        url= [NSURL URLWithString:@KPointwindB];
    }
    if ([title isEqualToString:@"C点"]) {
       url= [NSURL URLWithString:@KPointwindC];
    }
    if ([title isEqualToString:@"D点"]) {
        url= [NSURL URLWithString:@KPointwindD];
    }
    return url;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewaa = [[UIView alloc] init];
    viewaa.backgroundColor = KTextColor;
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 0.25*KWight, 40)];
    [dateLabel setText:@"日期"];
    dateLabel.textColor = [UIColor blackColor];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0]];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:dateLabel];
    
    UILabel *fensuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.35*KWight, 0, 0.25*KWight, 40)];
    [fensuLabel setText:@"风速（m/s）"];
    fensuLabel.textColor = [UIColor blackColor];
    [fensuLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fensuLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fensuLabel];
    
    UILabel *fengliLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.55*KWight, 0, 0.25*KWight, 40)];
    [fengliLabel setText:@"风力"];
    fengliLabel.textColor = [UIColor blackColor];
    [fengliLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fengliLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fengliLabel];
    
    UILabel *fenxiangLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.75*KWight, 0, 0.25*KWight, 40)];
    [fenxiangLabel setText:@"风向"];
    fenxiangLabel.textColor = [UIColor blackColor];
    [fenxiangLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fenxiangLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fenxiangLabel];
    
    return viewaa;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 30.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//改这里
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _valueArray.count;
}



-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    fourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"fourTableViewCell" owner:self options:nil] lastObject];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)configureCell:(fourTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
        NSLog(@"标题是===%@",_title);
        NSURL *url = [self judgePoint:_title];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:100];
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *dateArray = [[NSMutableArray alloc] init];
        NSMutableArray *windSpeedArray = [[NSMutableArray alloc] init];
        NSMutableArray *windPowerArray = [[NSMutableArray alloc] init];
        NSMutableArray *windDirectionArray = [[NSMutableArray alloc] init];
//        for (NSDictionary *dic in array) {
//            
//            
//            NSString *dateString1 = [dic objectForKey:@"dataTime"];
//           
//            NSNumber *windspeed1 = [dic objectForKey:@"POWER"];
//            
//            NSString *windspeed = windspeed1.description;
//            NSNumber *winddir = [dic objectForKey:@"DIR"];
//
//           
//          
//            NSString *windPower = [_datAnaly judgeWindPower:windspeed1];
//             NSString *windDirecion =[_datAnaly judgeDirectionPower:winddir];
//            NSString *dateString = [_datAnaly  stringForAnaly:dateString1];
//            
//            
//            [dateArray addObject:dateString];
//            [windSpeedArray addObject:windspeed];
//            [windDirection addObject:windDirecion];
//            [windPowerArray addObject:windPower];
//        }
       NSString *pubtime = [array[0] objectForKey:@"publishtime"];
       NSString *pubtime2=[pubtime  substringToIndex:16];
        releaseTime.text=[NSString stringWithFormat:@"发布时间:%@",pubtime2];
        NSString *pubtime1 = [pubtime substringToIndex:10];
        for (int i = 0; i<array.count; i++) {
            NSString *publishtime = [array[i] objectForKey:@"publishtime"];
            NSString *publishtime1 = [publishtime substringToIndex:10];
            
            if ([publishtime1 isEqualToString:pubtime1]) {
                
                NSString *dateString1 = [array[i] objectForKey:@"datatime"];
                
                NSNumber *windspeed1 = [array[i] objectForKey:@"power"];
                
                NSString *windspeed = windspeed1.description;
                NSNumber *winddir = [array[i] objectForKey:@"dir"];
                
                NSString *windPower = [_datAnaly judgeWindPower:windspeed1];
                NSString *windDirecion =[_datAnaly judgeDirectionPower:winddir];
                NSString *dateString = [_datAnaly  stringForAnaly:dateString1];
                
//                windspeed = [windspeed substringToIndex:3];
                
                CGFloat windspeed2 = [windspeed1 doubleValue];
                NSString *windspeed3 = [NSString stringWithFormat:@"%.1f",windspeed2];

                
                [dateArray addObject:dateString];
                [windSpeedArray addObject:windspeed3];
                [windDirectionArray addObject:windDirecion];
                [windPowerArray addObject:windPower];
                
            }
        
        }
        
        cell.data1.text = dateArray[indexPath.row];
        cell.data2.text = windSpeedArray[indexPath.row];
        cell.data3.text = windPowerArray[indexPath.row];
        cell.data4.text = windDirectionArray[indexPath.row];
        NSLog(@"数据大小是多少：%lu",(unsigned long)dateArray.count);
    }];
    
}



//获取网络数据
-(void )getDataFromNet:(NSString *)title

{
    [_datetimeArray removeAllObjects];
    [_valueArray removeAllObjects];
    [_windDirForTu removeAllObjects];
    [datasForPlot removeAllObjects];
    [_dataJQ removeAllObjects];
    
    [MyRequest GET:@"http://xxs.dhybzx.org:8888/OFT/GetTBVECGRIDWIND_A" CacheTime:10 isLoadingView:@"正在加载" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        _array = [NSMutableArray arrayWithObject:jsonDic].firstObject;
        NSString *pubtime = [_array[0] objectForKey:@"publishtime"];
        NSString *pubtime1 = [pubtime substringToIndex:10];
        _publishTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _publishTime.text = pubtime1;
        [self.view addSubview:_publishTime];
        
        for (int i = 0; i<_array.count; i++) {
            NSString *publishtime = [_array[i] objectForKey:@"publishtime"];
            NSString *publishtime1 = [publishtime substringToIndex:10];
            if ([publishtime1 isEqualToString:pubtime1]) {
                
                NSString *dateString1 = [_array[i] objectForKey:@"datatime"];
                NSString *jiequ = [dateString1 substringToIndex:10];
                if ([jiequ isEqualToString:publishtime1]) {
                    [_similarLength addObject:jiequ];
                }
                NSString *dateString = [_datAnaly stringForAnaly:dateString1];
                NSNumber *windspeed = [_array[i] objectForKey:@"power"];
                NSString *windspeed1 = windspeed.description;
                
                NSNumber *winddir = [_array[i] objectForKey:@"dir"];
                NSString *windDirecion =[_datAnaly judgeDirectionPower:winddir];
                CGFloat windspeed11 = [windspeed doubleValue];
                NSString *windspeed2 = [NSString stringWithFormat:@"%.1f",windspeed11];
                
                
                [_windDirForTu addObject:windDirecion];
                [_datetimeArray addObject:dateString];
                [_valueArray addObject:windspeed2];
                [_dataJQ addObject:jiequ];
                [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:dateString,@"date",windspeed2,@"speed",windDirecion,@"direct", nil]];
            }
        }
        
        
        
        
        for (int i=0; i<num; i++) {
            NSLog(@"你好-----%@",_valueArray[i]);
            
            NSString  *value = _valueArray[i];
            double yy = value.doubleValue;
            y1[i] = yy;
            xl[i] = i;
            NSString  *ii = [NSString stringWithFormat:@"%d",i];
            [_interArray addObject:ii];
            NSLog(@"%@===%f",_datetimeArray[i],y1[i]);
        }
        [self setXY:_datetimeArray];
        
    } failure:^(NSError *error) {
        
    }];
    
    

    
}


//代理函数
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return num;
}

//每个点的数据是什么
-(double*)doublesForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange{
    
    //返回类型：一个double指针（数组）
    double *values = NULL;
    
    switch (fieldEnum){
            //如果请求的数据是散点x坐标,直接返回x坐标（两个图形是一样的），否则还要进一步判断是那个图形
        case CPTScatterPlotFieldX:
            values= xl ;
            break;
        case CPTScatterPlotFieldY:
            //如果请求的数据是散点y坐标，则对于图形1，使用y1数组，对于图形2，使用y2数组
            values=y1;
            break;
    }
    //数组指针右移个indexRage.location单位，则数组截去indexRage.location个元素
    return values+indexRange.location ;
}


//添加箭头部分
-(CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)plot
                           recordIndex:(NSUInteger)index
{
    
    NSLog(@"%@",_windDirForTu[index]);
    NSLog(@"%lu",(unsigned long)_indexOfSymbol);
    
    CPTMutableLineStyle * symbolLineStyle = [CPTMutableLineStyle lineStyle];
    
    symbolLineStyle.lineColor = [CPTColor clearColor];
    
    symbolLineStyle.lineWidth = 1.0;
    
    CPTPlotSymbol * plotSymbol = [CPTPlotSymbol  ellipsePlotSymbol];
    
    if ([_windDirForTu[index] isEqualToString:@"E"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"E-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"ENE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"ENE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu
               [index] isEqualToString:@"ESE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"ESE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"N"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"N-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"NE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"NNE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NNE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"NNW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NNW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"NW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"S"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"S-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"SE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"SSE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SSE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"SSW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SSW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"SW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"W"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"W-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"WNW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"WNW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_windDirForTu[index] isEqualToString:@"WSW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"WSW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }

    if (_indexOfSymbol == index) {
        
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
    }
    
     plotSymbol.size = CGSizeMake(15.0,15.0);
    
    return plotSymbol;
    
}

//添加数据标签
-(CPTLayer*)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    //定义一个白色的TextStyle
    static CPTTextStyle *whiteText= nil;
    
    if (!whiteText ) {
        whiteText= [[CPTTextStyle alloc] init];
        
        //        whiteText.color = [CPTColor whiteColor];
    }
    //定义一个TextLayer
    CPTTextLayer *newLayer =nil;
    
    //    NSString*identifier=(NSString*)[plot identifier];
    NSLog(@"-----------%f",y1[index]);
    if (index%3 == 0) {

    }
   
    
    
    return newLayer;
}
//suofangfanwei缩放
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space
     willChangePlotRangeTo:(CPTPlotRange *)newRange
             forCoordinate:(CPTCoordinate)coordinate{
        if (coordinate == CPTCoordinateY)
    {
        newRange = ((CPTXYPlotSpace*)space).yRange;
    }
//    [graph reloadData];
    NSLog(@"Plot changes %@", newRange);
    return newRange;
    
}



-(BOOL)plotSpace:(CPTPlotSpace *)space shouldScaleBy:(CGFloat)interactionScale aboutPoint:(CGPoint)interactionPoint{
    return true;
}




#pragma mark -
#pragma mark Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return  YES;
}
-(BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark -
#pragma mark CPTPlotSpaceDelegate methods
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceCancelledEvent:(UIEvent *)event
{
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceUpEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDownEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    NSLog(@"you putdown at point:%@",[NSValue valueWithCGPoint:point]
          );
    NSLog(@"%.2f===%.2f",point.x,point.y);

    _pointOfTouch = point;
    
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    return YES;
}

#pragma mark -
#pragma mark CPTScatterPlotDelegate
//当我们选择相应的点时，弹出注释：
-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)idx withEvent:(UIEvent *)event
{
    
    _indexOfSymbol = idx;
    
    if (symbolTextAnnotation ) {
        [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        symbolTextAnnotation = nil;
    }
    NSLog(@"%lu",(unsigned long)idx);
    
    // Setup a style for the annotation
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
//    hitAnnotationTextStyle.color    = [CPTColor colorWithComponentRed:26 green:188 blue:156 alpha:1];
    hitAnnotationTextStyle.color = [CPTColor blackColor];
    
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    // Determine point of symbol in plot coordinates
    NSNumber *x          =
    [[datasForPlot objectAtIndex:idx] valueForKey:@"date"];
    NSNumber *y          = [[datasForPlot objectAtIndex:idx] valueForKey:@"speed"];
    CGFloat y1 = [y doubleValue];
    NSString *dir = [[datasForPlot objectAtIndex:idx]valueForKey:@"direct"];
    
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    NSString *yString = [formatter stringFromNumber:y];
    NSString *myString = [NSString stringWithFormat:@"日期：%@\n风速：%.1f\n风向：%@",x,y1,dir];
    
    detail.text = myString;
    // Now add the annotation to the plot area
//    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:myString/*yString*/ style:hitAnnotationTextStyle];
//    symbolTextAnnotation              = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
//    symbolTextAnnotation.contentLayer = textLayer;
//    NSLog(@"%@",[NSValue valueWithCGPoint:_pointOfTouch]);
//
//    
//    if (idx>50) {
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20) - 400;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,30.0);
//    }else{
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20) - 0.4*viewWidth;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,30.0);
//  
//    }
//    symbolTextAnnotation.displacement = CGPointMake(_pointOfTouch.x, _pointOfTouch.y);
    
//    CGFloat pointOfX = _pointOfTouch.x;
//    CGFloat pointOfY = _pointOfTouch.y;

//    float viewWidth=_hostView.frame.size.width - 30;
//    float viewHeight=_hostView.frame.size.height;
    
//    float coorX = idx*(viewWidth/20) - 0.45*viewWidth;
//    float coordinateX=(pointOfX-XRANGEBEGIN)*viewWidth/XRANGELENGTH;
//    float coordinateY=(-1)*(pointOfY-YRANGEBEGIN-YRANGELENGTH)*(viewHeight-GRAPAHBOTTOMPAD)/YRANGELENGTH;
//    symbolTextAnnotation.displacement = CGPointMake(coorX,20.0);
    
    
    //    symbolTextAnnotation.displacement = _pointOfTouch;
//    [graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
    
    [graph reloadData];
    
    
}

//-(void)dataSourceInit
//{
//    datasForPlot = [NSMutableArray arrayWithCapacity:100];
//    //    for (int i = 0; i < 100; i++) {
//    //        [datasForPlot addObject:[NSNull null]];//在数组初始化后，先给根据数组的长度填充NSNull对象。
//    //    }
//    for (int i = 0; i < 100; i++) {
//        id x = [NSNumber numberWithFloat:(0 + i * 0.5)];
//        id y = [NSNumber numberWithFloat:(1.2 * rand()/(float)RAND_MAX + 1.2)];
//        NSDate *now = [NSDate date];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        formatter.dateStyle = NSDateFormatterShortStyle;
//        formatter.timeStyle = NSDateFormatterShortStyle;
//        formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//        NSString *dateString = [formatter stringFromDate:now];
//        
//        [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x,@"x",y,@"y",dateString,@"date", nil]];
//        //[datasForPlot replaceObjectAtIndex:i withObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x,@"x",y,@"y", nil]];
//    }
//}



//
//-(void)viewPan:(UIPanGestureRecognizer *)tapGr
//{
//    CGPoint now=[tapGr locationInView:self.view];
//    
//    //手势变化并且接近折点旁边
//    if([tapGr state]==UIGestureRecognizerStateChanged&&[self isNearByThePoint:now]){
//        CGPoint coordinate=[self CoordinateTransformRealToAbstract:now];
//        [datasForPlot removeAllObjects];
//        [_reverseDic removeAllObjects];
//        NSUInteger i;
//        for(i=0;i<NUM;i++){
//            id x=[NSNumber numberWithFloat:0+i];
//            id y=[NSNumber numberWithFloat:3*i+coordinate.y];
//            [_reverseDic setObject:y forKey:[NSString stringWithFormat:@"%.0f",[x floatValue]]];
//            [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x,@"x",y,@"y",nil]];
//        }
//        [graph reloadData];
//    }
//    
//    
//}
//
////判断手指触摸点是否在折点旁边
//-(BOOL)isNearByThePoint:(CGPoint)p{
//    
//    //从手指触摸点的实际坐标得到抽象坐标
//    CGPoint abstractCoordinate=[self CoordinateTransformRealToAbstract:p];
//    //获取临近坐标点
//    int acX=(int)(abstractCoordinate.x+0.5);
//    //判断临近坐标点是否存在折点，存在则取出
//    float acY=[[_reverseDic objectForKey:[NSString stringWithFormat:@"%d",acX]] floatValue];
//    
//    //构造临近坐标折点，并转化为实际屏幕坐标点
//    CGPoint temp=[self CoordinateTransformAbstractToReal:CGPointMake([[NSNumber numberWithInt:acX] floatValue], acY)];
//    //计算临近坐标点与手指触摸点的距离
//    double distance=sqrt(pow((p.x-temp.x),2)+pow((p.y-temp.y),2));
//    
//    //NSLog(@"%f",distance);
//    return distance>25?NO:YES;
//    
//}
//
//
////空间坐标转换:实际坐标转化自定义坐标
//-(CGPoint)CoordinateTransformRealToAbstract:(CGPoint)point{
//    
//    float viewWidth=_hostView.frame.size.width;
//    float viewHeight=_hostView.frame.size.height;
//    
//    float coordinateX=(XRANGELENGTH*point.x)/viewWidth+XRANGEBEGIN;
//    float coordinateY=YRANGELENGTH-((YRANGELENGTH*point.y)/(viewHeight-GRAPAHBOTTOMPAD))+YRANGEBEGIN;
//
//    return CGPointMake(coordinateX,coordinateY);
//}
////空间坐标转换:自定义坐标转化实际坐标
//-(CGPoint)CoordinateTransformAbstractToReal:(CGPoint)point{
//    
//    float viewWidth=_hostView.frame.size.width;
//    float viewHeight=_hostView.frame.size.height;
//    
//    float coordinateX=(point.x-XRANGEBEGIN)*viewWidth/XRANGELENGTH;
//    float coordinateY=(-1)*(point.y-YRANGEBEGIN-YRANGELENGTH)*(viewHeight-GRAPAHBOTTOMPAD)/YRANGELENGTH;
//
//    return CGPointMake(coordinateX,coordinateY);
//    
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//
//{
//    return YES;
//}
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


