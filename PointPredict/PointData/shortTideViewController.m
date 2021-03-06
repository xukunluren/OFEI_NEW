//
//  shortTideViewController.m
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "shortTideViewController.h"
//#import "CustomTableView.h"
#import "twoTableViewCell.h"
#import "headview.h"
#import "OFeiCommon.h"

#import "PellTableViewSelect.h"
#import "NormalViewController.h"
#import "dataAnaly.h"
#import "DiyTheme.h"
#import "MyRequest.h"
@interface shortTideViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CPTScatterPlotDelegate,CPTPlotSpaceDelegate>
{
    
    double xl[KtableNum];//散点的x坐标
    double y1[KtableNum];//第1个散点图的y坐标
    
}
@end


@implementation shortTideViewController

{
    NSString *_title;
    UILabel *_titleLabel;
    dataAnaly *_datAnaly;

    NSMutableArray *_datetimeArray;
    NSMutableArray *_valueArray;
    NSMutableArray *_keduArray;
    NSMutableArray *_stideDirForTu;
    NSMutableArray *datasForPlot;
    
    NSMutableArray *_dataJQ;
    NSMutableArray *_similarLength;
    NSString *_publishTime;
    
    UIImageView *zoneA;
    NSUInteger *_indexOfSymbol;
    
    UILabel *detail;
       NSMutableArray *_array;
    UILabel *releaseTime;
    
    NSMutableArray *dateArray ;
    NSMutableArray *windHighArray ;
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
    
    //可变数组的初始化
    _datetimeArray = [[NSMutableArray alloc] init];
    _valueArray = [[NSMutableArray alloc] init];
    _keduArray = [[NSMutableArray alloc]init];
    _stideDirForTu = [[NSMutableArray alloc] init];
    _datAnaly = [[dataAnaly alloc] init];
    datasForPlot = [[NSMutableArray alloc] init];
    _array = [[NSMutableArray alloc] init];
    
    _dataJQ = [[NSMutableArray alloc]init];
    _similarLength = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc] init];
    windHighArray = [[NSMutableArray alloc] init];
    _indexOfSymbol = 200;

    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
    
    _title = @"A点";
    self.tabBarController.tabBar.hidden = NO;
    
    //显示详细；
    detail = [[UILabel alloc]initWithFrame:CGRectMake(40, KHight*0.4, KWight-40, 100)];
    detail.textColor = [UIColor blackColor];
    detail.font = [UIFont fontWithName:@"Arial" size:14];
    detail.textAlignment = NSTextAlignmentLeft;
    detail.numberOfLines = 0;
    //    detial.backgroundColor = [UIColor blackColor];
    //    detial.alpha = 0.4;
    //    detial.text = @"日期:  潮高(m):";
    [self.view addSubview:detail];
    [self setButton];
    [self setNavTitle:_title];
    [self initTableAndPicture];
    [self getDataFromNet:_title];
//    [self setXY:dateArray1];
    
    [self setTextNoRefesh];

}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = YES;
//    
//}

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
    [exampleButton1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];

    
}

- (void)backHome
{
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
}


//返回
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)selectPoint
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.4, 64, 100, 190) selectData:@[@"A点",@"B点",@"C点",@"D点"] action:^(NSInteger index) {
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A点";
            zoneA.image = [UIImage imageNamed:@"pointA"];
        }
        if (index == 1) {
            _title = @"B点";
            zoneA.image = [UIImage imageNamed:@"pointB"];
        }
        if (index == 2) {
            _title = @"C点";
            zoneA.image = [UIImage imageNamed:@"pointC"];
        }
        if (index == 3) {
            _title = @"D点";
            zoneA.image = [UIImage imageNamed:@"pointD"];
        }
        [self viewDidAppear:YES];
        [self setNavTitle:_title];
        [self judgePoint:_point];
        [self.shortTideTable reloadData];
        [self getDataFromNet:_title];
        detail.text = @" ";
        _indexOfSymbol = 200;
    } animated:YES];
}




#pragma 设置表头内容

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewaa = [[UIView alloc] init];
    
    viewaa.backgroundColor = KTextColor;
    
    CGFloat wight = self.view.frame.size.width;
    //添加表格第一行日期、数据等信息
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 0.3*wight, 40)];
    [dateLabel setText:@"日期"];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0]];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:dateLabel];
    
    UILabel *fensuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.51*wight, 0, 0.5*wight, 40)];
    [fensuLabel setText:@"潮高（m）"];
    [fensuLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fensuLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fensuLabel];
    
    return viewaa;
    
}






- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _valueArray.count;
}



-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    twoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"twoTableViewCell" owner:self options:nil] lastObject];
    }
    
    //设置每行数据
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(twoTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
        cell.data1.text = dateArray[indexPath.row];
        cell.data2.text = windHighArray[indexPath.row];
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma 判断点的位置

-(NSURL *)judgePoint:(NSString *)point
{
    NSURL *url;
    if ([point isEqualToString:@"A点"]) {
        url= [NSURL URLWithString:@KPointSTideA];
    }
    if ([point isEqualToString:@"B点"]) {
        url= [NSURL URLWithString:@KPointSTideB];
    }
    if ([point isEqualToString:@"C点"]) {
        url= [NSURL URLWithString:@KPointSTideC];
    }
    if ([point isEqualToString:@"D点"]) {
        url= [NSURL URLWithString:@KPointSTideD];
    }
    return url;
}

-(NSString *)judgePointWithStr:(NSString *)point
{
    NSString *url;
    if ([point isEqualToString:@"A点"]) {
        url= [NSString stringWithFormat:@KPointSTideA];
    }
    if ([point isEqualToString:@"B点"]) {
        url= [NSString stringWithFormat:@KPointSTideB];
    }
    if ([point isEqualToString:@"C点"]) {
        url= [NSString stringWithFormat:@KPointSTideC];
    }
    if ([point isEqualToString:@"D点"]) {
        url= [NSString stringWithFormat:@KPointSTideD];
    }
    return url;
}

#pragma 设置初始化图表控件----xk
-(void)initTableAndPicture

{
    
    graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
    //给画板添加一个主题
    DiyTheme *theme = [[DiyTheme alloc] init] ;
    [graph applyTheme:theme];
    
    /* 添加hostingView作为graph的容器，因为graph只能在这上面显示 */
    //创建主画板视图添加画板
    _hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0.4*KHight, KWight, KHight*0.6-44)];
    _hostView.hostedGraph = graph;
    _hostView.alpha = 0.6;
    _hostView.collapsesLayers = NO;
    [self.view addSubview:_hostView];
    
    //设置留白
    graph.paddingLeft = 3;
    graph.paddingTop = 20;
    graph.paddingRight = 3;
    graph.paddingBottom = 10;
    
    graph.plotAreaFrame.paddingLeft = 30.0;
    graph.plotAreaFrame.paddingTop = 20.0;
    graph.plotAreaFrame.paddingRight = 5.0;
    graph.plotAreaFrame.paddingBottom = 20.0;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    //允许用户交互
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0)   lengthDecimal:CPTDecimalFromFloat(15.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(-3.0) lengthDecimal:CPTDecimalFromFloat(6.0)];
    plotSpace.delegate = self;
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:@(0) length:@(80)];
    
    //            plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal];
    
    
    _shortTideTable = [[UITableView alloc] initWithFrame:CGRectMake(0+KWight, 0.4*KHight, KWight, KHight*0.6 - 44)];
    _shortTideTable.layer.cornerRadius = 10;
    _shortTideTable.layer.masksToBounds = YES;
    _shortTideTable.alpha = 0.6;
    [_shortTideTable setDelegate:self];
    _shortTideTable.backgroundColor = [UIColor clearColor];
    
    [_shortTideTable setDataSource:self];
    [self.view addSubview:_shortTideTable];
    
    
}

//设置XY轴的坐标样式
-(void)setXY:(NSArray *)dateArray
{
    
    //    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 10.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 1.5f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
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
//    X.title = @"DateTime";
    X.titleTextStyle = axisTitleStyle;
    X.titleOffset = 85.0f;
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
//        if ([[textdate substringToIndex:5] isEqualToString:text]) {
//            labelText = [textdate substringFromIndex:6];
//        }else{
            labelText = textdate;
            text = [textdate substringToIndex:6];
//        }
        if ([_dataJQ[i] isEqualToString:_publishTime]) {
            
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
        
        newLabel.tickLocation = @(i+12);
        newLabel.offset = 5;//X.labelOffset + X.majorTickLength
        newLabel.rotation = 2*M_PI;
        [customLabels addObject:newLabel];
        [_keduArray addObject:[NSNumber numberWithInt:i]];
        i=i+24;
        
        }
    }

//    for (int i=0;i<KtableNum;) {
//        NSLog(@"数据日期是多少====%@",dateArray[i]);
//        CPTAxisLabel *newLabel =[[CPTAxisLabel alloc] initWithText:dateArray[i] textStyle:labelTextStyle];
//        newLabel.tickLocation = @(i);
//        newLabel.offset = 5;//X.labelOffset + X.majorTickLength
//        newLabel.rotation = 2*M_PI;
//        [customLabels addObject:newLabel];
//        [_keduArray addObject:[NSNumber numberWithInt:i]];
//        i=i+11;
//    }
    
    X.majorTickLocations = [NSSet setWithArray:_keduArray];
    X.axisLabels =  [NSSet setWithArray:customLabels];
    
    
    
    //y轴
    CPTXYAxis *y =axisSet.yAxis;
    //y轴：不显示小刻度线
    y.minorTickLineStyle = nil;
    //大刻度线间距：50单位
    
    y.majorIntervalLength = @(1);
    y.orthogonalPosition = @(-2.0);
    y.titleLocation = @(3.3);
    y.titleOffset = 0.f;
    //坐标原点：0
    y.titleRotation=2*M_PI;
    y.title= @"m";
//        y.labelingPolicy = CPTAxisLabelingPolicyNone;
    //固定XY轴的显示位置，使其不随屏幕的滑动而移动
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    
    
    //    创建蓝色区域
    CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
    //    设置绿色区域边框的样式
    CPTMutableLineStyle *lineStlye = [CPTMutableLineStyle lineStyle];
    
    boundLinePlot.delegate = self;
    boundLinePlot.plotSymbolMarginForHitDetection = 10.0f;
    
    lineStlye.miterLimit = 1.0f;
    lineStlye.lineWidth  = 1.0f;
    lineStlye.lineColor  = [CPTColor blackColor];
    boundLinePlot.dataLineStyle = lineStlye;
    boundLinePlot.identifier = @"Blue Plot";
    //设置数据源代理
    boundLinePlot.dataSource = self;
    [graph addPlot:boundLinePlot];
}


//获取网络数据
-(void)getDataFromNet:(NSString *)title
{
    
    NSString *url = [self judgePointWithStr:title];
    [_datetimeArray removeAllObjects];
    [_valueArray removeAllObjects];
    [_dataJQ removeAllObjects];
    
    [MyRequest GET:url CacheTime:21600 isLoadingView:@"正在加载" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        _array = [NSMutableArray arrayWithObject:jsonDic].firstObject;
        
        
        
        
        NSString *pubtime = [_array[0] objectForKey:@"publishtime"];
        NSString *pubtime2=[pubtime substringToIndex:16];
        releaseTime.text=[NSString stringWithFormat:@"发布时间:%@",pubtime2];
        
        NSString *pubtime1 = [pubtime substringToIndex:10];
        for (int i = 0; i<_array.count; i++) {
            NSString *publishtime = [_array[i] objectForKey:@"publishtime"];
            NSString *publishtime1 = [publishtime substringToIndex:10];
            if ([publishtime1 isEqualToString:pubtime1]) {
                
                dataAnaly *data = [[dataAnaly alloc] init];
                NSString *dateString1 = [_array[i] objectForKey:@"datatime"];
                NSString *dateString = [data stringForAnaly:dateString1];
                NSNumber *windhigh1 = [_array[i] objectForKey:@"power"];
                CGFloat windhigh2 = [windhigh1 doubleValue];
                NSString *windhigh = [NSString stringWithFormat:@"%.2f",windhigh2];
                
                //将获取到的数据放入数组中，以方便每行数据的展示
                [dateArray addObject:dateString];
                [windHighArray addObject:windhigh];
                
                
            }
        }

        
 
        _publishTime = pubtime1;
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
                
                [_datetimeArray addObject:dateString];
                [_valueArray addObject:windspeed];
                [_dataJQ addObject:jiequ];
                [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:dateString,@"date",windspeed,@"speed", nil]];
                
                
            }
        }
        
        
        for (int i=0; i<_valueArray.count; i++) {
            
            NSString  *value = _valueArray[i];
            double yy = value.doubleValue;
            y1[i] = yy;
            xl[i] = i;
        }
        [self setXY:_datetimeArray];
        [graph reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

//初始化不需要刷新的控件
-(void)setTextNoRefesh
{
    UILabel *unitName = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.15, 0.08 *KHight, KWight*0.5, 0.2*KHight)];
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
    releaseTime.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:14];
    [self.view addSubview:releaseTime];
    
    //不要写死不要写死
   zoneA = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.58, 65, KWight*0.38, KWight*0.38)];
    zoneA.layer.cornerRadius = 10.0;
    zoneA.layer.masksToBounds = YES;
    zoneA.image = [UIImage imageNamed:@"pointA"];
    [self.view addSubview:zoneA];
    
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"图",@"表", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    segment.frame = CGRectMake(KWight*0.23,0.33 *KHight, KWight*0.625,KWight*0.125);
    //    [segment setBackgroundColor:[UIColor redColor]];
    //    [segment setTintColor:[UIColor whiteColor]];
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
    segment.tintColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
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
    _shortTideTable.frame  = CGRectMake(0+KWight, 0.4*KHight,KWight,KHight*0.6-44);
    _shortTideTable.hidden  = YES;
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
    _shortTideTable.hidden = NO;
    _shortTideTable.frame = CGRectMake(0,0.4*KHight,KWight,KHight*0.6-44);
    
    NSLog(@"%f",_shortTideTable.frame.origin.x);
}

//代理函数
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return _valueArray.count;
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
    NSLog(@"%lu===",(unsigned long)index);
    CPTPlotSymbol *symbol = nil;
    symbol = [CPTPlotSymbol ellipsePlotSymbol];
    symbol.size = CGSizeMake(5.0, 5.0);
    CPTPlotSymbol * plotSymbol = [CPTPlotSymbol  ellipsePlotSymbol];
    if (_indexOfSymbol == index) {
        
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
        plotSymbol.size = CGSizeMake(8.0,8.0);
    }
    
    
    
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
//        newLayer= [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.2f", y1[index]] style:whiteText];
    }

    return newLayer;
}
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space
     willChangePlotRangeTo:(CPTPlotRange *)newRange
             forCoordinate:(CPTCoordinate)coordinate{
    
    
    if (coordinate == CPTCoordinateY)
    {
        newRange = ((CPTXYPlotSpace*)space).yRange;
    }
        return newRange;
    
}


-(BOOL)plotSpace:(CPTPlotSpace *)space shouldScaleBy:(CGFloat)interactionScale aboutPoint:(CGPoint)interactionPoint{
    return true;
}

-(BOOL) plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(UIEvent *)event atPoint:(CGPoint)point
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
    // Setup a style for the annotation
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    //    hitAnnotationTextStyle.color    = [CPTColor colorWithComponentRed:26 green:188 blue:156 alpha:1];
    hitAnnotationTextStyle.color = [CPTColor blackColor];
    
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    //    [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:dateString,@"date",windspeed,@"speed",windDirecion,@"direct", nil]];
    
    
    // Determine point of symbol in plot coordinates
    NSNumber *x          =
    [[datasForPlot objectAtIndex:idx] valueForKey:@"date"];
    NSNumber *y          = [[datasForPlot objectAtIndex:idx] valueForKey:@"speed"];
    CGFloat y1 = [y doubleValue];
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
//    NSString *yString = [formatter stringFromNumber:y];
    NSString *myString = [NSString stringWithFormat:@"日期：%@\n潮高：%.2f\n",x,y1];
    detail.text = myString;
   
    [graph reloadData];
}



@end
