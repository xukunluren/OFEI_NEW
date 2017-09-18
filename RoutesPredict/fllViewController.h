//
//  fllViewController.h
//  OFei
//
//  Created by admin on 15/11/12.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface fllViewController : UIViewController<CPTPlotDataSource>
{
    CPTXYGraph                  *graph;             //画板
    
}
@property ( nonatomic , strong ) CPTGraphHostingView * hostView;
@property ( nonatomic , strong ) CPTGraphHostingView * waveHostView;

@property(nonatomic,strong)NSString *route;

@end
