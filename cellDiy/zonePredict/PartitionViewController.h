//
//  PartitionViewController.h
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>



@interface PartitionViewController : UIViewController<NSURLConnectionDataDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (weak,nonatomic)UIPageControl *pageControl;

//24h
@property(strong,nonatomic)UILabel *wind;
@property(strong,nonatomic)UILabel *windDirection;
@property(strong,nonatomic)UILabel *windAvg;

@property(strong,nonatomic)UILabel *wave;
@property(strong,nonatomic)UILabel *waveDirection;
@property(strong,nonatomic)UILabel *waveAvg;
//48h
@property(strong,nonatomic)UILabel *wind_48;
@property(strong,nonatomic)UILabel *windDirection_48;
@property(strong,nonatomic)UILabel *windAvg_48;

@property(strong,nonatomic)UILabel *wave_48;
@property(strong,nonatomic)UILabel *waveDirection_48;
@property(strong,nonatomic)UILabel *waveAvg_48;
//72h
@property(strong,nonatomic)UILabel *wind_72;
@property(strong,nonatomic)UILabel *windDirection_72;
@property(strong,nonatomic)UILabel *windAvg_72;

@property(strong,nonatomic)UILabel *wave_72;
@property(strong,nonatomic)UILabel *waveDirection_72;
@property(strong,nonatomic)UILabel *waveAvg_72;
@property(strong,nonatomic)NSMutableData *listData_72;

- (NSString *)word:(NSString *)dirdir;



@end
