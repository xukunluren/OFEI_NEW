
//
//  tidePositionViewController.m
//  OFei
//
//  Created by admin on 15/11/12.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "tidePositionViewController.h"
#import "OFeiCommon.h"
#import "twoTableViewCell.h"

#import "CNPGridMenu.h"
#import "PellTableViewSelect.h"
#import "NormalViewController.h"
#import "dataAnaly.h"
#import "DiyTheme.h"
#import "FYChartView.h"
#import "MyRequest.h"
#define num 100

@interface tidePositionViewController ()<UITableViewDataSource,UITableViewDelegate,CNPGridMenuDelegate,CPTPlotDataSource,CPTPlotSpaceDelegate,CPTAxisDelegate,CPTScatterPlotDataSource,FYChartViewDataSource>
{
    double xl[num];//散点的x坐标
    double y1[num];//第1个散点图的y坐标
    double db[2];
    
}
@property (nonatomic, strong) CNPGridMenu *gridMenu;

//@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
//@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation tidePositionViewController
{
    NSString *_title;
    UIButton *_upButton;
    NSMutableArray *_array;
    UILabel *_titleLabel;
    NSMutableArray *timeArr;
    NSMutableArray *valueArr;
    dataAnaly *_datAnaly ;
    NSMutableArray *_keduArray;
    CPTPlotRange *_xplotRange;
    CPTPlotRange *_yplotRange;
    FYChartView *detialView;
    UIImageView *_routePic;
    
    NSMutableArray *_dataJQ;
    NSMutableArray *_similarLength;
    NSString *_publishTime;
    
    NSUInteger *_indexOfSymbol;
    CGPoint point;
    
    UILabel *detial;
    
    UILabel *releaseTime ;
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
    timeArr = [[NSMutableArray alloc]init];
    valueArr = [[NSMutableArray alloc]init];
    _datAnaly = [[dataAnaly alloc] init];
    _keduArray = [[NSMutableArray alloc] init];
    _array = [[NSMutableArray alloc] init];
    _dataJQ = [[NSMutableArray alloc]init];
    _similarLength = [[NSMutableArray alloc]init];
    _indexOfSymbol = 200;
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    
    _yplotRange = [CPTPlotRange plotRangeWithLocation:@(-3.0) length:@(6)];
    _xplotRange = [CPTPlotRange plotRangeWithLocation:@(0) length:@(50)];
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
    _title = @"霓屿山北堤航线";
    
    //显示详细；
    detial = [[UILabel alloc]initWithFrame:CGRectMake(40, KHight*0.4, KWight-40, 100)];
    detial.textColor = [UIColor blackColor];
    detial.font = [UIFont fontWithName:@"Arial" size:14];
    detial.textAlignment = NSTextAlignmentLeft;
    detial.numberOfLines = 0;
    [self.view addSubview:detial];
    
    [self initTableAndPicture];
    
    [self  getDataFromNet:_title];
    
    [self setButton];
    [self setNavTitle:_title];
   
    [self setTextNoRefesh];
    
}
//手势滑动  并且刷新
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    NSArray *nameArr = [NSArray arrayWithObjects:@"霓屿山北堤航线",@"霓屿山东堤北段航线",@"凤凰山东堤南段航线",@"凤凰山南堤航线", nil];
    NSLog(@"%lu",(unsigned long)nameArr.count);

    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if ([_title isEqualToString:@"霓屿山北堤航线"]) {
            _title = nameArr[1];
            [self setNavTitle:_title];
            [self judgeRoutes:_title];
            [self getDataFromNet:_title];
            [_tidePositionTable reloadData];
            NSLog(@"title%@",_title);
        }
        else if ([_title isEqualToString:@"霓屿山东堤北段航线"]) {
            _title = nameArr[2];
            [self setNavTitle:_title];
            [self judgeRoutes:_title];
            [self getDataFromNet:_title];
            [_tidePositionTable reloadData];
        }
        else if ([_title isEqualToString:@"凤凰山东堤南段航线"]){
            _title = nameArr[3];
            [self setNavTitle:_title];
            [self judgeRoutes:_title];
            [self getDataFromNet:_title];
            [_tidePositionTable reloadData];
        }
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if ([_title isEqualToString:@"霓屿山东堤北段航线"]) {
            _title = nameArr[0];
            [self setNavTitle:_title];
            [self judgeRoutes:_title];
            [self getDataFromNet:_title];
            [_tidePositionTable reloadData];
            NSLog(@"title%@",_title);
        }
        else if ([_title isEqualToString:@"凤凰山东堤南段航线"]) {
            _title = nameArr[1];
            [self setNavTitle:_title];
            [self judgeRoutes:_title];
            [self getDataFromNet:_title];
            [_tidePositionTable reloadData];
        }
        else if ([_title isEqualToString:@"凤凰山南堤航线"]){
            _title = nameArr[2];
            [self setNavTitle:_title];

            [self judgeRoutes:_title];
            [self getDataFromNet:_title];
            [_tidePositionTable reloadData];
        }
    }
    
     NSLog(@"zuohua%@",_title);
}



-(void)initTableAndPicture

{
    //获取网络数据用于展示用
//    NSArray *dateArray1 = [self  getDataFromNet:_title];
    graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
    //给画板添加一个主题
    CPTTheme *theme = [[DiyTheme alloc] init];
    [graph applyTheme:theme];
    
    detialView  = [[FYChartView alloc]init];
    detialView.dataSource = self;
    [_hostView addSubview:detialView];
    
    CPTTheme *graphTheme = [[DiyTheme alloc]init];
    [graph applyTheme:graphTheme];

//    /* 添加hostingView作为graph的容器，因为graph只能在这上面显示 */
//    //创建主画板视图添加画板
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
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0)   lengthDecimal:CPTDecimalFromFloat(20.0)];
//    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(-3.0) lengthDecimal:CPTDecimalFromFloat(3.0)];
    plotSpace.delegate = self;
    plotSpace.globalYRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(-5.0) lengthDecimal:CPTDecimalFromFloat(5.0)];
     plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0) lengthDecimal:CPTDecimalFromFloat(50.0)];
//    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal];
//    NSLog(@"%@",dateArray1);
//    [self setXY:dateArray1];
    
    
    _tidePositionTable = [[UITableView alloc] initWithFrame:CGRectMake(0+KWight, 0.4*KHight, KWight, KHight*0.6 - 44)];
    _tidePositionTable.layer.cornerRadius = 10;
    _tidePositionTable.layer.masksToBounds = YES;
    _tidePositionTable.alpha = 0.6;
    [_tidePositionTable setDelegate:self];
    [_tidePositionTable setDataSource:self];
    [self.view addSubview:_tidePositionTable];
    
    
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
    _routePic = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.58, 65, KWight*0.38, KWight*0.38)];
    _routePic.layer.cornerRadius = 10.0;
    _routePic.layer.masksToBounds = YES;
    _routePic.image = [UIImage imageNamed:@"routeA"];
    [self.view addSubview:_routePic];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"图",@"表", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    segment.frame = CGRectMake(KWight*0.23,0.33 *KHight, KWight*0.625  , KWight*0.125);
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
    
    _tidePositionTable.frame  = CGRectMake(0+KWight, 0.4*KHight,KWight,KHight*0.6-44);
    _tidePositionTable.hidden  = YES;
    _hostView.frame = CGRectMake(0 ,0.4*KHight,KWight,KHight*0.6-44);
    graph.hidden = NO;
    detial.hidden = NO;
    _hostView.hidden = NO;

}

- (void)secondSegment
{
    
    _hostView.frame  = CGRectMake(0+ KWight,0.4*KHight,KWight,KHight*0.6-44);
    NSLog(@"%f",_hostView.frame.origin.x);
    _hostView.hidden  = YES;
    graph.hidden = YES;
    
    _tidePositionTable.hidden = NO;
    _tidePositionTable.frame = CGRectMake(0,0.4*KHight,KWight,KHight*0.6-44);
    
    detial.hidden = YES;
    NSLog(@"%f",_tidePositionTable.frame.origin.x);
}


#pragma MARK - 网络数据获取图的展示
-(void)getDataFromNet:(NSString *)title
{
    
    
    //第一步，创建URL
    NSString *url = [self judgeRoutesWithStr:_title];
    [timeArr removeAllObjects];
    [valueArr removeAllObjects];
    [_dataJQ removeAllObjects];
    [MyRequest GET:url CacheTime:10 isLoadingView:@"正在加载" success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        _array = [NSMutableArray arrayWithObject:jsonDic].firstObject;
        
        NSString *pubtime = [_array[0] objectForKey:@"publishtime"];
        
        
        NSString *pubtime1 = [pubtime substringToIndex:10];
        _publishTime = pubtime1;
        
        
        for (int i = 0; i<_array.count; i++) {
            NSString *publishtime = [_array[i] objectForKey:@"publishtime"];
            NSString *publishtime1 = [publishtime substringToIndex:10];
            NSString *varname = [_array[i] objectForKey:@"varname"];
            if ([publishtime1 isEqualToString:pubtime1]&&[varname isEqualToString:@"TIDE"]) {
                
                NSString *dateString1 = [_array[i] objectForKey:@"datatime"];
                NSString *jiequ = [dateString1 substringToIndex:10];
                if ([jiequ isEqualToString:publishtime1]) {
                    [_similarLength addObject:jiequ];
                }
                NSString *dateString = [_datAnaly stringForAnaly:dateString1];
                
                NSNumber *tideHigh = [_array[i] objectForKey:@"power"];
                CGFloat tideHigh1 = [tideHigh doubleValue];
                NSString *tideHigh2 = [NSString stringWithFormat:@"%.2f",tideHigh1];
                
                [timeArr addObject:dateString];
                [valueArr addObject:tideHigh2];
                
                [_dataJQ addObject:jiequ];
            }
        }
        
        for (int i=0; i<valueArr.count; i++) {
            NSLog(@"你好-----%@",valueArr[i]);
            
            NSString  *value = valueArr[i];
            double yy = value.doubleValue;
            y1[i] = yy;
            xl[i] = i;
                    }
        
        
        
        [graph reloadData];
        [self setXY:timeArr];
        [_tidePositionTable reloadData];
        
    } failure:^(NSError *error) {
        
    }];
//    //第二步，通过URL创建网络请求
//    
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
//    
//    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
//    //第三步，连接服务器
//    
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    
//    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
//   
////    for (NSDictionary *dic in array) {
////        
////        
////        NSString *dateString1 = [dic objectForKey:@"dataTime"];
////        NSString *dateString = [_datAnaly stringForAnaly:dateString1];
////        
////        NSNumber *windspeed = [dic objectForKey:@"POWER"];
////        
////        
////        
////        [timeArr addObject:dateString];
////        [valueArr addObject:windspeed];
////        
////        
////    }
//    
//    NSString *pubtime = [array[0] objectForKey:@"publishtime"];
//   
//    
//    NSString *pubtime1 = [pubtime substringToIndex:10];
//    _publishTime = pubtime1;
//    
//    
//    for (int i = 0; i<array.count; i++) {
//        NSString *publishtime = [array[i] objectForKey:@"publishtime"];
//        NSString *publishtime1 = [publishtime substringToIndex:10];
//        NSString *varname = [array[i] objectForKey:@"varname"];
//        if ([publishtime1 isEqualToString:pubtime1]&&[varname isEqualToString:@"TIDE"]) {
//            
//            NSString *dateString1 = [array[i] objectForKey:@"datatime"];
//            NSString *jiequ = [dateString1 substringToIndex:10];
//            if ([jiequ isEqualToString:publishtime1]) {
//                [_similarLength addObject:jiequ];
//            }
//            NSString *dateString = [_datAnaly stringForAnaly:dateString1];
//            
//            NSNumber *tideHigh = [array[i] objectForKey:@"power"];
//            CGFloat tideHigh1 = [tideHigh doubleValue];
//            NSString *tideHigh2 = [NSString stringWithFormat:@"%.2f",tideHigh1];
//            
//            [timeArr addObject:dateString];
//            [valueArr addObject:tideHigh2];
//            
//            [_dataJQ addObject:jiequ];
//        }
//    }
//    
//    for (int i=0; i<valueArr.count; i++) {
//        NSLog(@"你好-----%@",valueArr[i]);
//        
//        NSString  *value = valueArr[i];
//        double yy = value.doubleValue;
//        y1[i] = yy;
//        xl[i] = i;
////        NSString  *ii = [NSString stringWithFormat:@"%d",i];
////        [_interArray addObject:ii];
////        NSLog(@"%@===%f",timeArr[i],y1[i]);
//    }
//    return timeArr;
    
}


#pragma mark -- 曲线代理函数
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return valueArr.count;
}

//每个点的数据是什么
-(double*)doublesForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange{
    
    //返回类型：一个double指针（数组）
//    double *values = NULL;
//    
//    switch (fieldEnum){
//            //如果请求的数据是散点x坐标,直接返回x坐标（两个图形是一样的），否则还要进一步判断是那个图形
//        case CPTScatterPlotFieldX:
//            values= xl ;
//            break;
//        case CPTScatterPlotFieldY:
//            //如果请求的数据是散点y坐标，则对于图形1，使用y1数组，对于图形2，使用y2数组
//            values=y1;
//            break;
//    }
//    //数组指针右移个indexRage.location单位，则数组截去indexRage.location个元素
//    return values+indexRange.location ;
    
    double *values = NULL;
    NSString*identifier=(NSString*)[plot identifier];
    
    switch (fieldEnum){
            //如果请求的数据是散点x坐标,直接返回x坐标（两个图形是一样的），否则还要进一步判断是那个图形
        case CPTScatterPlotFieldX:
            values=xl;
            break;
        case CPTScatterPlotFieldY:
            //如果请求的数据是散点y坐标，则对于图形1，使用y1数组，对于图形2，使用y2数组
            if([identifier isEqualToString:@"BluePlot"]) {
                values=y1;
            }else
                values=y1;
            break;
            
    }
    //数组指针右移个indexRage.location单位，则数组截去indexRage.location个元素
    return values +indexRange.location ;
}


//添加箭头部分
-(CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)plot
                           recordIndex:(NSUInteger)index
{
    
    NSLog(@"%lu===",(unsigned long)index);
    CPTPlotSymbol *symbol = nil;
    symbol = [CPTPlotSymbol ellipsePlotSymbol];
    //    symbol.fill = [CPTFill fillWithImage:[CPTImage imageForPNGFile:[[NSBundle mainBundle] pathForResource:@"left" ofType:@"png"]]];
    symbol.size = CGSizeMake(5.0, 5.0);
    
    if (_indexOfSymbol == index) {
        
        symbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
        symbol.size = CGSizeMake(10.0, 10.0);
    }
    
//    symbolTextAnnotation.displacement = CGPointMake(index,30.0);
    return symbol;
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
    
//    newLayer= [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.2f", y1[index]] style:whiteText];
    
//    symbolTextAnnotation.displacement = CGPointMake(index,30.0);
    return newLayer;
}

//缩放
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space
     willChangePlotRangeTo:(CPTPlotRange *)newRange
             forCoordinate:(CPTCoordinate)coordinate{
    

    //限制缩放和移动的时候。不超过原始范围
    if ( coordinate == CPTCoordinateX)
    {
        if ([ _xplotRange containsRange:newRange])
        {
            //如果缩放范围在原始范围内。则返回缩放范围
            return newRange;
            
        }
        
        else if([newRange containsRange:_xplotRange])
        {
//            symbolTextAnnotation.displacement = CGPointMake(50.0,30.0);
            //如果缩放范围在原始范围外，则返回原始范围
            return newRange;
        }
       
        return newRange;
        
    }
    
    else{
        return _yplotRange;
    }
    
}

//
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldScaleBy:(CGFloat)interactionScale aboutPoint:(CGPoint)interactionPoint{
    
//    NSArray *annotations = space.graph.plotAreaFrame.plotArea.annotations;
//    for (id annotation in annotations) {
//        if ([annotation isKindOfClass:[CPTPlotSpaceAnnotation class]]) {
//            CPTPlotSpaceAnnotation *textAnnotation = (CPTPlotSpaceAnnotation *)annotation;
//            if ([textAnnotation.contentLayer isKindOfClass:[CPTTextLayer class]]) {
//                // I want to resize font and reposition the annotation when the user zooms
////                textAnnotation.displacement = CGPointMake(<#CGFloat x#>, <#CGFloat y#>);
//                
//            }
//        }
//    }
    NSLog(@"%f------%f",interactionPoint.x,interactionPoint.y);
    return true;
}

-(BOOL) plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(UIEvent *)event atPoint:(CGPoint)point
{
//    CGPoint dragPoint = [graph convertPoint:point toLayer:graph.plotAreaFrame.plotArea];
//    double db[2];
//    [space doublePrecisionPlotPoint:db numberOfCoordinates:2 forPlotAreaViewPoint:dragPoint];
//    NSLog(@"drag(%.2f, %.2f), db (%.2f, %.2f)", dragPoint.x, dragPoint.y, db[0], db[1]);
    return YES;
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
//    X.title = @"DateTime";
    X.titleTextStyle = axisTitleStyle;
    X.titleOffset = -10.0f;
    X.axisLineStyle = axisLineStyle;
    X.labelingPolicy = CPTAxisLabelingPolicyNone;
    X.labelTextStyle = axisTextStyle;
    X.majorTickLineStyle = axisLineStyle;
    X.majorTickLength = 4.0f;
    X.tickDirection = CPTSignNegative;
    
    
    //构造MutableArray，用于存放自定义的轴标签
    NSMutableArray*customLabels = [NSMutableArray arrayWithCapacity:valueArr.count];
    //构造一个TextStyle
    static CPTTextStyle*labelTextStyle=nil;
    labelTextStyle=[[CPTTextStyle alloc]init];
    NSString *text = @"nihao";
    NSString *labelText;
    //做判断，若缩放则展示的日期数据就3个，若不缩放则展示全部的数据
    for (int i=0;i<valueArr.count;) {
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
    
    y.majorIntervalLength = @(1.0);
    y.orthogonalPosition = @(0);
    y.titleLocation = @(3.3);
    y.titleOffset = 0.f;
    //坐标原点：0
    y.titleRotation=2*M_PI;
    y.title= @"m";
    //    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    //固定XY轴的显示位置，使其不随屏幕的滑动而移动
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    
    
    //    创建蓝色区域
    CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
    //    设置绿色区域边框的样式
    CPTMutableLineStyle *lineStlye = [CPTMutableLineStyle lineStyle];
    
    boundLinePlot.delegate = self;
    boundLinePlot.dataSource = self;
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
//    [self presentViewController:normal animated:YES completion:nil];
    [self.navigationController pushViewController:normal animated:NO];
}

-(void)setNavTitle:(NSString *)title
{

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
    
    
//    CNPGridMenuItem *laterToday = [[CNPGridMenuItem alloc] init];
//    //    laterToday.icon = [UIImage imageNamed:@"LaterToday"];
//    laterToday.title = @"分区预报";
//    
//    CNPGridMenuItem *thisEvening = [[CNPGridMenuItem alloc] init];
//    //    thisEvening.icon = [UIImage imageNamed:@"ThisEvening"];
//    thisEvening.title = @"点预报";
//    
//    CNPGridMenuItem *tomorrow = [[CNPGridMenuItem alloc] init];
//    //    tomorrow.icon = [UIImage imageNamed:@"Tomorrow"];
//    tomorrow.title = @"航线预报";
//    
//    CNPGridMenuItem *thisWeekend = [[CNPGridMenuItem alloc] init];
//    //    thisWeekend.icon = [UIImage imageNamed:@"ThisWeekend"];
//    thisWeekend.title = @"预警信息";
//    
//    CNPGridMenuItem *nextWeek = [[CNPGridMenuItem alloc] init];
//    //    nextWeek.icon = [UIImage imageNamed:@"NextWeek"];
//    nextWeek.title = @"台风路径";
//    
//    
//    
//    CNPGridMenu *gridMenu = [[CNPGridMenu alloc] initWithMenuItems:@[laterToday, thisEvening, tomorrow, thisWeekend, nextWeek]];
//    gridMenu.delegate = self;
//    [self presentGridMenu:gridMenu animated:YES completion:^{
//        NSLog(@"Grid Menu Presented");
//    }];
//    
//    
//    NSLog(@"长按事件");
    
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
    
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
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.2, 64, 200, 190) selectData:@[@"霓屿山北堤航线",@"霓屿山东堤北段航线",@"凤凰山东堤南段航线",@"凤凰山南堤航线"] action:^(NSInteger index){
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"霓屿山北堤航线";
            _routePic.image = [UIImage imageNamed:@"routeA@2x"];
        }
        if (index == 1) {
            _title = @"霓屿山东堤北段航线";
            _routePic.image = [UIImage imageNamed:@"routeB@2x"];
        }
        if (index == 2) {
            _title = @"凤凰山东堤南段航线";
            _routePic.image = [UIImage imageNamed:@"routeC@2x"];
        }
        if (index == 3) {
            _title = @"凤凰山南堤航线";
            _routePic.image = [UIImage imageNamed:@"routeD@2x"];
        }
        [self viewDidAppear:YES];
        NSLog(@"%@",_title);
        [self setNavTitle:_title];
//        [self setMapView:_title];
        [self judgeRoutes:_title];
        [_tidePositionTable reloadData];
        [self getDataFromNet:_title];
        detial.text = @" ";
        _indexOfSymbol = 200;
        [graph reloadData];
        
    } animated:YES];
}





- (void)segAction:(UISegmentedControl *)segCrtl
{
    NSInteger Index = segCrtl.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [self graphView];
            break;
        case 1:
            [self chartView];
        default:
            break;
    }
}

-(void)graphView
{
    _tidePositionTable.frame  = CGRectMake(0+KWight, 0.4*KHight,KWight,KHight*0.6-44);
    _tidePositionTable.hidden  = YES;
    _hostView.frame = CGRectMake(0 ,0.4*KHight,KWight,KHight*0.6-44);
    graph.hidden = NO;
    _hostView.hidden = NO;
    
}

-(void)chartView
{
    _hostView.frame  = CGRectMake(0+ KWight,0.4*KHight,KWight,KHight*0.6-44);
    NSLog(@"%f",_hostView.frame.origin.x);
    _hostView.hidden  = YES;
    graph.hidden = YES;
    
    _tidePositionTable.hidden = NO;
    _tidePositionTable.frame = CGRectMake(0,0.4*KHight,KWight,KHight*0.6-44);
    
    NSLog(@"%f",_tidePositionTable.frame.origin.x);
}

-(NSURL *)judgeRoutes:(NSString *)title
{
    NSURL *url;
    if ([title isEqualToString:@"霓屿山北堤航线"]) {
        url= [NSURL URLWithString:KRouteTideP1];
    }
    if ([title isEqualToString:@"霓屿山东堤北段航线"]) {
        url= [NSURL URLWithString:KRouteTideP2];
    }
    if ([title isEqualToString:@"凤凰山东堤南段航线"]) {
        url= [NSURL URLWithString:KRouteTideP3];
    }
    if ([title isEqualToString:@"凤凰山南堤航线"]) {
        url= [NSURL URLWithString:KRouteTideP4];
    }
    NSLog(@"您选择的区域是%@",url);
    return url;
}

-(NSString *)judgeRoutesWithStr:(NSString *)title
{
    NSString *url;
    if ([title isEqualToString:@"霓屿山北堤航线"]) {
        url= [NSString stringWithFormat:KRouteTideP1];
    }
    if ([title isEqualToString:@"霓屿山东堤北段航线"]) {
        url= [NSString stringWithFormat:KRouteTideP2];
    }
    if ([title isEqualToString:@"凤凰山东堤南段航线"]) {
        url= [NSString stringWithFormat:KRouteTideP3];
    }
    if ([title isEqualToString:@"凤凰山南堤航线"]) {
        url= [NSString stringWithFormat:KRouteTideP4];
    }
    NSLog(@"您选择的区域是%@",url);
    return url;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewaa = [[UIView alloc] init];
    viewaa.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
   
    
    CGFloat wight = self.view.frame.size.width;
    //添加表格第一行日期、数据等信息
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5*wight, 35)];
    [dateLabel setText:@"日期"];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0]];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:dateLabel];
    
    UILabel *fensuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.51*wight, 0, 0.5*wight, 35)];
    [fensuLabel setText:@"潮高（m）"];
    [fensuLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fensuLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fensuLabel];
    
    return viewaa;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return valueArr.count;
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
    
    
    [self configureCell:cell forIndexPath:indexPath];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)configureCell:(twoTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"标题是===%@",_title);
    NSURL *url = [self judgeRoutes:_title];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *dataTime = [[NSMutableArray alloc] init];
        NSMutableArray *tideHigh = [[NSMutableArray alloc] init];
        
        NSString *pubtime = [array[0] objectForKey:@"publishtime"];
        NSString *pubtime2=[pubtime substringToIndex:16];
        releaseTime.text=[NSString stringWithFormat:@"发布时间:%@",pubtime2];
        
        for (NSDictionary *dic in array) {
            NSString *dateString1 = [dic objectForKey:@"datatime"];
            NSString *dateString = [self stringForAnaly:dateString1];
            
            NSString *tideString1 = [dic objectForKey:@"power"];
            CGFloat tideString2 = [tideString1 doubleValue];
            NSString *tideString = [NSString stringWithFormat:@"%.2f",tideString2];
            
            [dataTime addObject:dateString];
            
            [tideHigh addObject:tideString];
        }
        
        cell.data1.text = dataTime[indexPath.row];
        cell.data2.text = tideHigh[indexPath.row];
        
        NSLog(@"数据的行数:%lu",(unsigned long)dataTime.count);
        
        
    }];
}


#pragma 字符串的分割
-(NSString *)stringForAnaly:(NSString *)string
{
    NSString *dateString1 = string;
    NSString *dateString2 = [dateString1 substringFromIndex:5];//截取下标5之后的字符串
    NSString *dateString3 = [dateString2 substringToIndex:8];//截取下标2之前的字符串
    NSArray *array1 = [dateString3 componentsSeparatedByString:@"-"]; //
    NSArray *array2 = [array1.lastObject componentsSeparatedByString:@" "];
    NSString *yue = @"月";
    NSString *shi = @"时";
    NSString *ri = @"日";
    NSString *dateString = [NSString stringWithFormat:@"%@%@%@%@ %@%@",array1.firstObject,yue,array2.firstObject,ri,array2.lastObject,shi];
    //    NSLog(@"日器值为%@",dateString);
    return dateString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    CGPoint dragPoint = [graph convertPoint:point toLayer:graph.plotAreaFrame.plotArea];
    double db[2];
    [space doublePrecisionPlotPoint:db numberOfCoordinates:2 forPlotAreaViewPoint:dragPoint];
    NSLog(@"drag(%.2f, %.2f), db (%.2f, %.2f)", dragPoint.x, dragPoint.y, db[0], db[1]);

    return YES;
}

#pragma mark -
#pragma mark CPTScatterPlotDelegate
//当我们选择相应的点时，弹出注释：
-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)idx withEvent:(UIEvent *)event
{
    _indexOfSymbol = idx;
 
    if ( symbolTextAnnotation ) {
        [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        symbolTextAnnotation = nil;
    }
    // Setup a style for the annotation
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color = [CPTColor blackColor];
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    // Determine point of symbol in plot coordinates
    NSNumber *x = [valueArr objectAtIndex:idx];
    NSNumber *y = [valueArr objectAtIndex:idx];
    NSString *date = [timeArr objectAtIndex:idx];
//    NSLog(@"%lu",(unsigned long)idx);
    
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    NSString *yString = [formatter stringFromNumber:y];
//    NSString *myString = [NSString stringWithFormat:@"温度：%@\n日期：%@\n事件：%@",yString,date,nil];
    NSString *myString = [NSString stringWithFormat:@"日期：%@\n潮高(m)：%@",date,x];

    // Now add the annotation to the plot area
//    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:myString style:hitAnnotationTextStyle];
//    symbolTextAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
//    symbolTextAnnotation.contentLayer = textLayer;
//    textLayer.position = CGPointMake(db[0], db[1]);
    
    
//    if (idx>50) {
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20)+300;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,30.0);
//        
//    }else if(idx<50){
//        float viewWidth=_hostView.frame.size.width ;
//        NSLog(@"%f---%lu",viewWidth,(unsigned long)idx);
//        float coorX = idx*(viewWidth/20);
//        symbolTextAnnotation.displacement = CGPointMake(coorX,30.0);
//    }
//    [graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
    
    
    
    detial.text = myString;
//    [plot.graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
    [graph reloadData];
}




@end
