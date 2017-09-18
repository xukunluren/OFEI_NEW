//
//  waveViewController.h
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface waveViewController : UIViewController<CPTPlotDataSource,CPTPlotSpaceDelegate,CPTAxisDelegate>


{
    CPTXYGraph                  *graph;             //画板
    CPTPlotRange *_xPlotRange;
    CPTPlotRange *_yPlotRange;
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
    
    
}


@property ( nonatomic , strong ) CPTGraphHostingView * hostView ;



@property(strong,nonatomic)UITableView *waveTable;
@property(nonatomic,strong)NSString *point;

@property(nonatomic,strong)UIView *picture;


@property (weak,nonatomic)UIPageControl *pageControl;
@property (strong,nonatomic)UIScrollView *scrollView;

@end
