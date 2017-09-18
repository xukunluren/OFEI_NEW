//
//  normalView.m
//  OFei
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "normalView.h"
#import "OFeiCommon.h"

@implementation normalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect mainView = [UIScreen mainScreen].bounds;

        //设置背景图片
        self.imageView = [[UIImageView alloc] initWithFrame:mainView];
        _imageView.image = [UIImage imageNamed:@"mainBackImage"];
//        _imageView.alpha = 1;
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:_imageView];
        
        //下面的背景色
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height*0.44, self.frame.size.width,1)];
        backImage.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
        [self addSubview:backImage];
        
        //下面的背景色
        UIImageView *backImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height*0.87, self.frame.size.width,1)];
        backImage1.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.26];
        [self addSubview:backImage1];

        UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*0.19, self.frame.size.height*0.22, 25, 25)];
        locationImage.image = [UIImage imageNamed:@"Marker Filled-25.png"];
//        locationImage.backgroundColor = [UIColor redColor];
        [self addSubview:locationImage];

        
        //地理信息
        self.location = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.25, self.frame.size.height*0.2, 200, 50)];
        self.location.text=@"上海";
        self.location.textColor = KTextColor;
//        self.location.textColor=[UIColor grayColor];
        _location.font = [UIFont systemFontOfSize:26.0];
        [self addSubview:_location];
        
     
        
        
        //设置天气图标
        self.weatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.15, self.frame.size.height*0.3, 40, 40)];
        _weatherImage.image = [UIImage imageNamed:@"weather11.png"];
        [self addSubview:_weatherImage];
        
        
        self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*0.25, self.frame.size.height*0.31, 200, 50)];
        self.weatherLabel.text = @"多云：15-9℃";
        _weatherLabel.font = [UIFont systemFontOfSize:15.0];
        _weatherLabel.textColor = [UIColor grayColor];
        _weatherLabel.tintColor = [UIColor redColor];
        [self addSubview:_weatherLabel];
        

        
        
        //设置风速信息
        self.windImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.15, self.frame.size.height*0.5, 40, 40)];
        _windImage.image = [UIImage imageNamed:@"Wind Turbine-50.png"];
        [self addSubview:_windImage];
        
        
        self.windLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*0.13, self.frame.size.height*0.6, 200, 50)];
        self.windLabel.text = @"北风:3-4级";
          _windLabel.font = [UIFont systemFontOfSize:16.0];
        _windLabel.textColor =[UIColor whiteColor];
        _windLabel.tintColor = [UIColor blackColor];
        [self addSubview:_windLabel];
        
        
        //能见度信息
        self.pmImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.45, self.frame.size.height*0.5, 50, 50)];
        _pmImage.image = [UIImage imageNamed:@"Fog Day-50.png"];
        [self addSubview:_pmImage];
        
        self.pmLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*0.45, self.frame.size.height*0.6, 200, 50)];
        self.pmLabel.text = @"2-5㎞";
        _pmLabel.font = [UIFont systemFontOfSize:16.0];
        _pmLabel.textColor =[UIColor whiteColor];
        _pmLabel.tintColor = [UIColor blackColor];
        [self addSubview:_pmLabel];
        
        //浪高信息
        self.waveImage =[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*0.75, self.frame.size.height*0.5, 40, 40)];
        _waveImage.image=[UIImage imageNamed:@"Sea Waves-50.png"];
        [self addSubview:_waveImage];
        
        self.waveLableN =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.7, self.frame.size.height*0.6, 200, 50)];
        self.waveLableN.text =@"北：";
        self.waveLableN.textColor =[UIColor whiteColor];
        _waveLableN.font=[UIFont systemFontOfSize:16.0];
        _waveLableN.tintColor= [UIColor blackColor];
        [self addSubview:_waveLableN];
        
        
        self.waveLableS =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.7, self.frame.size.height*0.7, 200, 50)];
        self.waveLableS.text =@"南：";
        self.waveLableS.textColor =[UIColor whiteColor];
        _waveLableS.font=[UIFont systemFontOfSize:16.0];
        _waveLableS.tintColor= [UIColor blackColor];
        [self addSubview:_waveLableS];
        
        
        
        
        
        //发布单位
        UILabel *danwei = [[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height-50,self.frame.size.width,10)];
        danwei.textAlignment = NSTextAlignmentCenter;
        danwei.text = @"国家海洋局~东海预报中心";
        [danwei setFont:[UIFont systemFontOfSize:8.0]];
        danwei.textAlignment = NSTextAlignmentCenter;
        danwei.textColor =[UIColor grayColor];
        danwei.tintColor = [UIColor grayColor];
        [self addSubview:danwei];
        //时间地理位置信息
        self.DataDate = [[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height-30,self.frame.size.width,10)];
        self.DataDate.text = @"2015-12-27 04:35";
        [_DataDate setFont:[UIFont systemFontOfSize:8.0]];
        _DataDate.textAlignment = NSTextAlignmentCenter;
        _DataDate.textColor =[UIColor grayColor];
        _DataDate.tintColor = [UIColor grayColor];
        [self addSubview:_DataDate];
    
    }
   
    return self;

}

@end
