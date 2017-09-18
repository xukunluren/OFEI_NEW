//
//  normalView.h
//  OFei
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface normalView : UIView

@property(nonatomic,strong)UIImageView *weatherImage;
@property(nonatomic,strong)UILabel *weatherLabel;
@property(nonatomic,strong)UILabel *weatherLabel1;

@property(nonatomic,strong)UIImageView *tempImage;
@property(nonatomic,strong)UILabel *tempLabel;


@property(nonatomic,strong)UIImageView *windImage;
@property(nonatomic,strong)UILabel *windLabel;
@property(nonatomic,strong)UILabel *windLabel1;

@property(nonatomic,strong)UIImageView *pmImage;
@property(nonatomic,strong)UILabel *pmLabel;

@property(nonatomic,strong)UILabel *DataDate;

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *backImage;

@property(nonatomic,strong)UIImageView *waveImage;
@property(nonatomic,strong)UILabel *waveLableN;

@property(nonatomic,strong)UILabel *waveLableS;

@property(nonatomic,strong)UILabel*location;

@end
