//
//  windGraph.h
//  OFei
//
//  Created by zey on 15/12/13.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

#define num 100

@interface windGraph : UIView<CPTPlotDataSource,CPTPlotSpaceDelegate,CPTAxisDelegate,CPTScatterPlotDelegate,CPTPlotSpaceDelegate>
{
    CPTXYGraph                  *graph;  //画板
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
    double xl[num];//散点的x坐标
    double y1[num];//第1个散点图的y坐标
    
    CPTPlotRange *_xPlotRange;
    CPTPlotRange *_yPlotRange;
    
//    NSString *_title;
}

- (NSString *)backwithTitle:(NSString *)title;
-(NSURL *)judgeRoutes:(NSString *)title;
-(NSArray *)getDataFromNet:(NSString *)title;
@property(nonatomic,strong)NSString *title;
@property ( nonatomic , strong ) CPTGraphHostingView * hostView;
//@property(nonatomic,strong)NSMutableArray *flowTimeArr;

@end
