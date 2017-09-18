//
//  shortTideViewController.h
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface shortTideViewController : UIViewController<CPTPlotDataSource,CPTAxisDelegate,CPTPlotSpaceDelegate>


{
    CPTXYGraph                  *graph;             //画板
    CPTPlotSpaceAnnotation *symbolTextAnnotation;

    
}


@property ( nonatomic , strong ) CPTGraphHostingView * hostView ;
@property(strong,nonatomic)UITableView *shortTideTable;
@property(nonatomic,strong)NSString *point;

@property(nonatomic,strong)UIView *picture;
@property (weak,nonatomic)UIPageControl *pageControl;
@property (strong,nonatomic)UIScrollView *scrollView;

@end
