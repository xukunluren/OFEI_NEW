//
//  tideGraph.m
//  OFei
//
//  Created by zey on 15/12/16.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "tideGraph.h"
#import "OFeiCommon.h"
#import "tidePositionViewController.h"

@implementation tideGraph
{
    NSMutableArray *_tideTimeArr;
    NSMutableArray *_tideValueArr;
    NSMutableArray *_keduArray;
     CPTPlotRange *_yplotRange;
     CPTPlotRange *_xplotRange;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tideTimeArr = [[NSMutableArray alloc]init];
        _tideValueArr = [[NSMutableArray alloc]init];
        
         _yplotRange = [CPTPlotRange plotRangeWithLocation:@(-3.0) length:@(6)];
        NSLog(@"%@",_title);
        
        
    }
    return self;
}

-(NSString *)backwithTitle:(NSString *)title
{
    _title = title;
    NSLog(@"%@",title);
    
    return title;
}



- (void)drawRect:(CGRect)rect {
    NSLog(@"%@",_title);
    
    NSArray *dateArray = [self getDataFromNet:_title];
    [self initGraph];
    NSLog(@"%lu",(unsigned long)dateArray.count);
    [self setXY:dateArray];
    
}


-(void)initGraph

{
    //获取网络数据用于展示用
    graph = [[CPTXYGraph alloc] initWithFrame:self.bounds];
    //给画板添加一个主题
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph applyTheme:theme];
    
    /* 添加hostingView作为graph的容器，因为graph只能在这上面显示 */
    //创建主画板视图添加画板
    _hostView = [[CPTGraphHostingView alloc]initWithFrame:self.bounds];
    _hostView.hostedGraph = graph;
    //    _hostView.alpha = 0.6;
    _hostView.collapsesLayers = NO;
    [self addSubview:_hostView];
    
    //设置留白
    graph.paddingLeft = 0;
    graph.paddingTop = 0;
    graph.paddingRight = 0;
    graph.paddingBottom = 0;
    
    graph.plotAreaFrame.paddingLeft = 30.0;
    graph.plotAreaFrame.paddingTop = 0.0;
    graph.plotAreaFrame.paddingRight = 5.0;
    graph.plotAreaFrame.paddingBottom = 20.0;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    //允许用户交互
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0)   lengthDecimal:CPTDecimalFromFloat(20.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0) lengthDecimal:CPTDecimalFromFloat(10.0)];
    plotSpace.delegate = self;
    
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0) lengthDecimal:CPTDecimalFromFloat(100.0)];
    //            plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal];
    //    NSLog(@"%@",dateArray1);
    //    [self setXY:dateArray1];
}

-(NSArray *)getDataFromNet:(NSString *)title
{
    NSLog(@"zey%@",title);
    NSURL *url;
    //第一步，创建URL
    url = [self judgeRoutes:title];
    NSLog(@"url是===%@",url);
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    
    [_tideTimeArr removeAllObjects];
    [_tideValueArr removeAllObjects];
    
    
    
    if (array.count == 0) {
        for (int i=0; i<num; i++) {
            NSString *datestring = @"0";
            NSNumber *windspeed = @(0);
            [_tideTimeArr addObject:datestring];
            [_tideValueArr addObject:windspeed];
        }
    }else{
        for (NSDictionary *dic in array) {
            
            
            NSString *dateString1 = [dic objectForKey:@"datatime"];
            
            NSNumber *windspeed = [dic objectForKey:@"power"];
            
            [_tideTimeArr addObject:dateString1];
            [_tideValueArr addObject:windspeed];
        }
    }
    
    
    for (int i=0; i<num; i++) {
        
        
        
        NSString  *value = _tideValueArr[i];
        double yy = value.doubleValue;
        y1[i] = yy;
        xl[i] = i;
        
    }
    [graph reloadData];
    return _tideTimeArr;
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
    //    NSLog(@"您选择的区域是%@",url);
    return url;
}

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
    X.title = @"DateTime";
    X.titleTextStyle = axisTitleStyle;
    X.titleOffset = -10.0f;
    X.axisLineStyle = axisLineStyle;
    X.labelingPolicy = CPTAxisLabelingPolicyNone;
    X.labelTextStyle = axisTextStyle;
    X.majorTickLineStyle = axisLineStyle;
    X.majorTickLength = 4.0f;
    X.tickDirection = CPTSignNegative;
    
    //构造MutableArray，用于存放自定义的轴标签
    NSMutableArray*customLabels = [NSMutableArray arrayWithCapacity:KtableNum];
    //构造一个TextStyle
    static CPTTextStyle*labelTextStyle=nil;
    labelTextStyle=[[CPTTextStyle alloc]init];
    for (int i=0;i<KtableNum;) {
        //        NSLog(@"数据日期是多少====%@",dateArray[i]);
        CPTAxisLabel *newLabel =[[CPTAxisLabel alloc] initWithText:dateArray[i] textStyle:labelTextStyle];
        newLabel.tickLocation = @(i);
        newLabel.offset = 5;//X.labelOffset + X.majorTickLength
        newLabel.rotation = 2*M_PI;
        [customLabels addObject:newLabel];
        [_keduArray addObject:[NSNumber numberWithInt:i]];
        i=i+11;
    }
    
    X.majorTickLocations = [NSSet setWithArray:_keduArray];
    X.axisLabels =  [NSSet setWithArray:customLabels];
    
    
    
    //y轴
    CPTXYAxis *y =axisSet.yAxis;
    //y轴：不显示小刻度线
    y.minorTickLineStyle = nil;
    //大刻度线间距：50单位
    
    y.majorIntervalLength = @(1.0);
    y.orthogonalPosition = @(0);
    y.titleLocation = @(100.f);
    y.titleOffset = -10.f;
    //坐标原点：0
    
    y.title= @"数值";
    //    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    //固定XY轴的显示位置，使其不随屏幕的滑动而移动
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    
    
    //    创建蓝色区域
    CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
    //    设置绿色区域边框的样式
    CPTMutableLineStyle *lineStlye = [CPTMutableLineStyle lineStyle];
    
    
    
    lineStlye.miterLimit = 1.0f;
    lineStlye.lineWidth  = 2.0f;
    lineStlye.lineColor  = [CPTColor greenColor];
    boundLinePlot.dataLineStyle = lineStlye;
    boundLinePlot.identifier = @"Blue Plot";
    //设置数据源代理
    boundLinePlot.dataSource = self;
    [graph addPlot:boundLinePlot];
}


#pragma mark --曲线代理函数
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
    
    //    NSLog(@"%lu===",(unsigned long)index);
    CPTPlotSymbol *symbol = nil;
    symbol = [CPTPlotSymbol plotSymbol];
    
    //    CPTTradingRangePlot *oh = [[CPTTradingRangePlot alloc] init];
    //    oh.plotStyle = CPTTextAlignmentCenter;
    
    
    //    NSString *ii = _interArray[index];
    //    NSInteger iii = ii.integerValue;
    //    if (iii>5) {
    //        symbol.fill = [CPTFill fillWithImage:[CPTImage imageNamed:@"uptoleft.png"]];
    
    //    }else {
    symbol.fill = [CPTFill fillWithImage:[CPTImage imageForPNGFile:[[NSBundle mainBundle] pathForResource:@"downleft" ofType:@"png"]]];
    //    }
    symbol.size = CGSizeMake(5.0, 5.0);
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
    //    NSLog(@"-----------%f",y1[index]);
    if (index%3 == 0) {
        newLayer= [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.2f", y1[index]] style:whiteText];
    }
    
    
    
    return newLayer;
}
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space
     willChangePlotRangeTo:(CPTPlotRange *)newRange
             forCoordinate:(CPTCoordinate)coordinate{
    
    
    //限制缩放和移动的时候。不超过原始范围
    if ( coordinate == CPTCoordinateX)
    {
        if ([ _xplotRange containsRange:newRange])
        {
            //如果缩放范围在 原始范围内。则返回缩放范围
            return newRange;
            
        }else if([newRange containsRange:_xplotRange])
        {
            //如果缩放范围在原始范围外，则返回原始范围
            return _xplotRange;
        }
        return newRange;
    }else{
        return _yplotRange;
    }
}


-(BOOL)plotSpace:(CPTPlotSpace *)space shouldScaleBy:(CGFloat)interactionScale aboutPoint:(CGPoint)interactionPoint{
    return true;
}

-(BOOL) plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    
    return YES;
}



@end
