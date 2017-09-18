//
//  DiyTheme.h
//  OFei
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
@interface DiyTheme : CPTTheme


//-( void )applyThemeToAxisSet:( CPAxisSet *)axisSet;
-(void)applyThemeToAxisSet:(CPTXYAxisSet *)axisSet;
-(void)applyThemeToPlotArea:(CPTPlotAreaFrame *)plotAreaFrame;
-(void)applyThemeToBackground:(CPTGraph *)graph;
@end
