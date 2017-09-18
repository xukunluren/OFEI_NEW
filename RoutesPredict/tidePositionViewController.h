//
//  tidePositionViewController.h
//  OFei
//
//  Created by admin on 15/11/12.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface tidePositionViewController : UIViewController<CPTPlotDataSource,CPTPlotSpaceDelegate,CPTAxisDelegate>

{
    CPTXYGraph                  *graph;             //画板
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
}

    
@property ( nonatomic , strong ) CPTGraphHostingView * hostView;
@property (nonatomic,strong) UITableView *tidePositionTable;
@property (nonatomic,strong) NSString *routes;
@property (nonatomic,strong) NSMutableArray *dataTime;
@property (nonatomic,strong) NSMutableArray *tideHigh;
@property(nonatomic,strong)UIView *picture;

//@property (weak,nonatomic)UIPageControl *pageControl;
//@property (strong,nonatomic)UIScrollView *scrollView;

@end
