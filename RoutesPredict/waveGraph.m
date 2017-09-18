//
//  waveGraph.m
//  OFei
//
//  Created by zey on 15/12/10.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "waveGraph.h"
#import "OFeiCommon.h"
#import "fllViewController.h"
#import "DiyTheme.h"
#import "dataAnaly.h"



@implementation waveGraph
{
    NSMutableArray *_waveTimeArr;
    NSMutableArray *_waveValueArr;
    NSMutableArray *_keduArray;
    NSMutableArray *_waveDir;
    waveGraph *waveGraph;
    
    fllViewController *_waveGraph;
    dataAnaly *_dataAnaly;
    NSUInteger *_indexOfSymbol;
    
    NSMutableArray *_dataJQ;
    NSMutableArray *_similarLength;
    NSString *_publishTime;
    
    UILabel *detail;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _waveTimeArr = [[NSMutableArray alloc]init];
        _waveValueArr = [[NSMutableArray alloc]init];
        _waveDir = [[NSMutableArray alloc]init];
        _keduArray = [[NSMutableArray alloc]init];
        
        _dataJQ = [[NSMutableArray alloc]init];
        _similarLength = [[NSMutableArray alloc]init];
        _dataAnaly = [[dataAnaly alloc]init];
        _indexOfSymbol = 200;
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
    
    
    //显示详细；
    detail = [[UILabel alloc]initWithFrame:CGRectMake(40, self.frame.size.height*0.1 , self.frame.size.width-40, 100)];
    detail.textColor = [UIColor blackColor];
    detail.font = [UIFont fontWithName:@"Arial" size:12];
    detail.textAlignment = NSTextAlignmentLeft;
    detail.numberOfLines = 0;
    
    CPTTheme *theme = [[DiyTheme alloc] init];
    [graph applyTheme:theme];
    //    detial.backgroundColor = [UIColor blackColor];
    //    detial.alpha = 0.4;
    //    detial.text = @"日期:  潮高(m):";
    [self addSubview:detail];
    
    
    NSArray *dateArray = [self getDataFromNet:_title];
    [self initGraph];
    NSLog(@"%lu",(unsigned long)dateArray.count);
    [self setXY:dateArray];
    
}


-(void)initGraph

{
    //获取网络数据用于展示用
    graph = [[CPTXYGraph alloc] initWithFrame:self.bounds];
    graph.title = @"未来三天浪曲线";
    //给画板添加一个主题
    CPTTheme *theme = [[DiyTheme alloc] init];
    [graph applyTheme:theme];
    
//    CPTTheme *graphTheme = [[DiyTheme alloc]init];
//    [graph applyTheme:graphTheme];
    
    /* 添加hostingView作为graph的容器，因为graph只能在这上面显示 */
    //创建主画板视图添加画板
    _hostView = [[CPTGraphHostingView alloc]initWithFrame:self.bounds];
    _hostView.hostedGraph = graph;
//    _hostView.alpha = 0.6;
    _hostView.collapsesLayers = NO;
    [self addSubview:_hostView];
    
    //设置留白
    graph.paddingLeft = 3;
    graph.paddingTop = 20;
    graph.paddingRight = 3;
    graph.paddingBottom = 5;
    
    graph.plotAreaFrame.paddingLeft = 30.0;
    graph.plotAreaFrame.paddingTop = 20.0;
    graph.plotAreaFrame.paddingRight = 5.0;
    graph.plotAreaFrame.paddingBottom = 20.0;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    //允许用户交互
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0)   lengthDecimal:CPTDecimalFromFloat(20.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0) lengthDecimal:CPTDecimalFromFloat(3.0)];
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
    [_waveDir removeAllObjects];
    [_waveTimeArr removeAllObjects];
    [_waveValueArr removeAllObjects];
    [_dataJQ removeAllObjects];
    if (array.count == 0) {
        NSString *datestring = @"0";
        NSNumber *windspeed = @(0);
        NSString *windDir = @"0";
        [_waveTimeArr addObject:datestring];
        [_waveValueArr addObject:windspeed];
        [_waveDir addObject:windDir];
    }else {
        NSString *pubtime = [array[0] objectForKey:@"publishtime"];
        NSString *pubtime1 = [pubtime substringToIndex:10];
        _publishTime = pubtime1;
    
    for (NSDictionary *dic in array) {
        
        
        NSString *dateString1 = [dic objectForKey:@"datatime"];
        NSString *jiequ = [dateString1 substringToIndex:10];
        if ([jiequ isEqualToString:_publishTime]) {
            [_similarLength addObject:jiequ];
        }
        NSString *dateString = [_dataAnaly stringForAnaly:dateString1];
        NSNumber *wavespeed = [dic objectForKey:@"power"];
        NSNumber *wavedir = [dic objectForKey:@"dir"];
        NSString *waveDirection = [_dataAnaly judgeDirectionPower:wavedir];
        
        [_waveTimeArr addObject:dateString];
        [_waveValueArr addObject:wavespeed];
        [_waveDir addObject:waveDirection];
        [_dataJQ addObject:jiequ];
    }
    }
    
    
    for (int i=0; i<num; i++) {
        
        
        
        NSString  *value = _waveValueArr[i];
        double yy = value.doubleValue;
        y1[i] = yy;
        xl[i] = i;
        
    }
    detail.text = @" ";
    _indexOfSymbol = 200;
    [graph reloadData];
    return _waveTimeArr;
}


-(NSURL *)judgeRoutes:(NSString *)title
{
    NSURL *url;
    if ([title isEqualToString:@"霓屿山北堤航线"]) {
        url= [NSURL URLWithString:KRouteWaveP1];
    }
    if ([title isEqualToString:@"霓屿山东堤北段航线"]) {
        url= [NSURL URLWithString:KRouteWaveP2];
    }
    if ([title isEqualToString:@"凤凰山东堤南段航线"]) {
        url= [NSURL URLWithString:KRouteWaveP3];
    }
    if ([title isEqualToString:@"凤凰山南堤航线"]) {
        url= [NSURL URLWithString:KRouteWaveP4];
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
    NSMutableArray*customLabels = [NSMutableArray arrayWithCapacity:KtableNum];
    //构造一个TextStyle
    static CPTTextStyle*labelTextStyle=nil;
    labelTextStyle=[[CPTTextStyle alloc]init];
    NSString *text = @"nihao";
    NSString *labelText;
    //做判断，若缩放则展示的日期数据就3个，若不缩放则展示全部的数据
    for (int i=0;i<KtableNum;) {
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
//        //        NSLog(@"数据日期是多少====%@",dateArray[i]);
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
    y.titleOffset = 0;
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
    boundLinePlot.plotSymbolMarginForHitDetection = 5.0f;
    
    
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
    NSLog(@"%@",_waveDir[index]);
    
    CPTMutableLineStyle * symbolLineStyle = [CPTMutableLineStyle lineStyle];
    
    symbolLineStyle.lineColor = [CPTColor clearColor];
    
    symbolLineStyle.lineWidth = 1.0;
    
    CPTPlotSymbol * plotSymbol = [CPTPlotSymbol  ellipsePlotSymbol];
    
    if ([_waveDir[index] isEqualToString:@"E"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"E-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"ENE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"ENE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"ESE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"ESE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"N"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"N-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"NE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"NNE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NNE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"NNW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NNW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"NW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"S"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"S-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"SE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"SSE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SSE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"SSW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SSW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"SW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"W"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"W-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"WNW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"WNW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDir[index] isEqualToString:@"WSW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"WSW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }
    
    plotSymbol.size = CGSizeMake(15.0,15.0);
    
    if (_indexOfSymbol == index) {
        
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
        plotSymbol.size = CGSizeMake(8.0, 8.0);
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
//    NSLog(@"-----------%f",y1[index]);
    
    
    //
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
//    if (coordinate == CPTCoordinateX) {
//        newRange = ((CPTXYPlotSpace*)space).xRange;
//    }
    NSLog(@"Plot changes %@", newRange);
    return newRange;
}


-(BOOL)plotSpace:(CPTPlotSpace *)space shouldScaleBy:(CGFloat)interactionScale aboutPoint:(CGPoint)interactionPoint{
    return true;
}

-(BOOL) plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    
    return YES;
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
    NSNumber *x = [_waveValueArr objectAtIndex:idx];
    NSNumber *y = [_waveValueArr objectAtIndex:idx];
    NSString *date = [_waveTimeArr objectAtIndex:idx];
    NSString *dir = [_waveDir objectAtIndex:idx];
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    NSString *yString = [formatter stringFromNumber:y];
//    NSString *myString = [NSString stringWithFormat:@"数值：%@\n日期：%@\n事件：%@",yString,date,nil];
    NSString *myString = [NSString stringWithFormat:@"日期：%@\n浪高：%@\n浪向：%@\n",date,x,dir];
    detail.text = myString;
    
    // Now add the annotation to the plot area
//    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:myString/*yString*/ style:hitAnnotationTextStyle];
//    symbolTextAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
//    symbolTextAnnotation.contentLayer = textLayer;
//    
//    if (idx>50) {
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20) - 300;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,20.0);
//        
//    }else{
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20) - 0.1*viewWidth;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,20.0);
//    }
//    [graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
    
    [graph reloadData];
}



@end
