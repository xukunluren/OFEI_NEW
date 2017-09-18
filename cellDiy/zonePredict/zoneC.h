//
//  zoneC.h
//  OFei
//
//  Created by zey on 15/12/21.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zoneC : UIView<NSURLConnectionDelegate>

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

@property(strong,nonatomic)NSString *title;

- (NSString *)word:(NSString *)dirdir;

@end
