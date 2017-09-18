//
//  windViewController.h
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
//#import <CorePlot/CorePlot.h>   明明就不行  胡改

@interface windViewController : UIViewController<CPTPlotDataSource,CPTPlotSpaceDelegate,CPTAxisDelegate>


{
    CPTXYGraph                  *graph;             //画板
    
    CPTPlotRange *_xPlotRange;
    CPTPlotRange *_yPlotRange;
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
}

//绘图view
@property ( nonatomic , strong ) CPTGraphHostingView * hostView ;




@property(nonatomic,strong)UITableView *windTable;
@property(nonatomic,strong)UIView *picture;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSMutableArray *dateArray;
@property(nonatomic,strong)NSMutableArray *windSpeedArray ;
@property(nonatomic,strong)NSMutableArray *windPowerArray;
@property(nonatomic,strong)NSMutableArray *windDirection;

@property (weak,nonatomic)UIPageControl *pageControl;
@property (strong,nonatomic)UIScrollView *scrollView;

//转换坐标系字典，与手指触摸点匹配
@property (nonatomic,retain) NSMutableDictionary *reverseDic;
//js引擎上下文
//@property (nonatomic,retain) JSGlobalContextRef context;



//坐标转换方法，实际坐标转化相对坐标
- (CGPoint)CoordinateTransformRealToAbstract:(CGPoint)point;
//坐标转换方法，相对坐标转化实际坐标
- (CGPoint)CoordinateTransformAbstractToReal:(CGPoint)point;
//判断手指触摸点是否在折点旁边
-(BOOL)isNearByThePoint:(CGPoint)p;

//js代码运行
- (NSString *)runsJS:(NSString *)aJSString;

-(void)handleLongPress2;
@end
