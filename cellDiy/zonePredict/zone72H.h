//
//  zone72H.h
//  OFei
//
//  Created by zey on 15/11/12.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFeiCommon.h"

@interface zone72H : UIView

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UILabel *wind;
@property(strong,nonatomic)UILabel *windDirection;
@property(strong,nonatomic)UILabel *windAvg;
@property(strong,nonatomic)UILabel *detailWind;

@property(strong,nonatomic)UILabel *wave;
@property(strong,nonatomic)UILabel *waveDirection;
@property(strong,nonatomic)UILabel *waveAvg;
@property(strong,nonatomic)UILabel *detailWave;

@property(strong,nonatomic)NSMutableData *listData;

- (NSString *)level:(NSNumber *)windsu;
- (NSString *)sendtitle:(NSString *)gettitle;

@end
