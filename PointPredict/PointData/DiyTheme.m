//
//  DiyTheme.m
//  OFei
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "DiyTheme.h"

@implementation DiyTheme


//-(void)applyThemeToBackground:(CPTGraph *)graph
//{
//    // 终点色： 20 ％的灰度
//    CPTColor *endColor = [ CPTColor colorWithGenericGray : 0.2f ];
//    // 创建一个渐变区：起点、终点都是 0.2 的灰度
//    CPTGradient *graphGradient = [ CPTGradient gradientWithBeginningColor :endColor endingColor :endColor];
//    // 设置中间渐变色 1 ，位置在 30 ％处，颜色为 3 0 ％的灰
//    graphGradient = [graphGradient addColorStop :[ CPTColor colorWithGenericGray : 0.1f ] atPosition : 0.3f ];
//    // 设置中间渐变色 2 ，位置在 50 ％处，颜色为 5 0 ％的灰
//    graphGradient = [graphGradient addColorStop :[ CPTColor colorWithGenericGray : 0.2f ] atPosition : 0.5f ];
//    // 设置中间渐变色 3 ，位置在 60 ％处，颜色为 3 0 ％的灰
//    graphGradient = [graphGradient addColorStop :[ CPTColor colorWithGenericGray : 0.3f ] atPosition : 0.6f ];
//    // 渐变角度：垂直 90 度（逆时针）
//    graphGradient. angle = 90.0f ;
//    // 渐变填充
//    graph. fill = [ CPTFill fillWithGradient :graphGradient];
//}

-(void)applyThemeToAxisSet:(CPTXYAxisSet *)axisSet
{
    // 设置网格线线型
    CPTMutableLineStyle *majorGridLineStyle = [ CPTMutableLineStyle lineStyle ];
    majorGridLineStyle.lineWidth = 1.0f;
    majorGridLineStyle. lineColor = [ CPTColor lightGrayColor ];
    CPTXYAxis *axis = axisSet.yAxis;
    CPTXYAxis *axisy = axisSet.xAxis;
    // 轴标签方向： CPSignNone －无，同 CPSignNegative ， CPSignPositive －反向 , 在 y 轴的右边， CPSignNegative －正向，在 y 轴的左边
    axis.tickDirection = CPTSignNegative ;
    axisy.tickDirection = CPTSignNegative;
    // 设置平行线，默认是以大刻度线为平行线位置
    axis. majorGridLineStyle = majorGridLineStyle ;
    axisy.majorGridLineStyle = majorGridLineStyle;
}


//-( void )applyThemeToPlotArea:( CPTPlotAreaFrame *)plotAreaFrame
//{
//    // 创建一个 20 ％ -50 ％的灰色渐变区，用于设置绘图区。
//    CPTGradient *gradient = [ CPTGradient gradientWithBeginningColor :[ CPTColor colorWithGenericGray : 0.2f ] endingColor :[ CPTColor colorWithGenericGray : 0.7f ]];
//    gradient. angle = 45.0f ;
//    // 渐变填充
//    plotAreaFrame. fill = [ CPTFill fillWithGradient :gradient];
//}

@end
