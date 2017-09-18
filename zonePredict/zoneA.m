//
//  zoneA.m
//  OFei
//
//  Created by zey on 15/12/21.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "zoneA.h"
#import "PartitionViewController.h"
#import "OFeiCommon.h"

#define kwidth self.bounds.size.width
#define kheight self.bounds.size.height

@implementation zoneA


- (void)drawRect:(CGRect)rect {
    //不会动得位置
    
    _releaseTime = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.05, self.bounds.size.height*0.25 , 200, 100)];
//    [self addSubview:_releaseTime];
    
    self.navigationCtrl.navigationItem.title=@"A区";
    UIView *view24H = [[UIView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height*0.35, self.bounds.size.width-20, self.bounds.size.height/6)];
    view24H.layer.cornerRadius = 10;
    view24H.layer.masksToBounds = YES;
    view24H.backgroundColor = [UIColor blackColor];
    view24H.alpha = 0.4;
    UIImageView *time24 = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-20, self.bounds.size.height*0.32, self.bounds.size.width/9, self.bounds.size.width/9)];
    [time24 setImage:[UIImage imageNamed:@"time24.png"]];
    [self addSubview:view24H];
    [self addSubview:time24];
    UILabel *contentWind = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.25, self.bounds.size.height*0.35, 100, 40)];
    contentWind.text = @"风";
    contentWind.textColor = [UIColor whiteColor];
    contentWind.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:contentWind];
    
    UILabel *windUnit = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.3, self.bounds.size.height*0.4, 100, 40)];
    windUnit.text = @"级";
    windUnit.textColor = [UIColor whiteColor];
    windUnit.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:windUnit];
    
    //    UILabel *windAvgUnit = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.3, KHight*0.52, 100, 40)];
    //    windAvgUnit.text = @"m/s";
    //    windAvgUnit.textColor = [UIColor whiteColor];
    //    windAvgUnit.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:windAvgUnit];
    
    UILabel *waveContent = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.73, self.bounds.size.height*0.35, 100, 40)];
    waveContent.text = @"浪";
    waveContent.textColor = [UIColor whiteColor];
    waveContent.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:waveContent];
    
//    UILabel *maxWave = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.54, self.bounds.size.height*0.45, 100, 40)];
//    maxWave.text = @"最大小";
//    maxWave.textColor = [UIColor whiteColor];
//    maxWave.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//    [self addSubview:maxWave];
    
//    UILabel *minWave = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.63, self.bounds.size.height*0.5, 100, 40)];
//    minWave.textColor = [UIColor whiteColor];
//    minWave.text = @"方向";
//    minWave.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//    [self addSubview:minWave];

    
    //风等级
    _wind = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.2, self.bounds.size.height*0.4, 100, 40)];
    _wind.textColor = [UIColor whiteColor];
    _wind.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:_wind];
    //方向设置
    _windDirection = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.13, self.bounds.size.height*0.45, self.frame.size.width*0.3125, self.frame.size.width*0.125)];
    _windDirection.textColor = [UIColor whiteColor];
    _windDirection.textAlignment = NSTextAlignmentCenter;
    _windDirection.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_windDirection];
    
    //浪
    _wave = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.65, self.bounds.size.height*0.4, 100, 40)];
    _wave.textColor = [UIColor whiteColor];
    _wave.textAlignment = NSTextAlignmentCenter;
    _wave.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_wave];
    
    _waveDirection  = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.63, self.bounds.size.height*0.45, self.frame.size.width*0.3125, self.frame.size.width*0.125)];
    _waveDirection.textColor = [UIColor whiteColor];
    _waveDirection.textAlignment = NSTextAlignmentCenter;
    _waveDirection.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_waveDirection];
    
    UIView *view48H = [[UIView alloc]initWithFrame:CGRectMake(10, kheight*0.57, kwidth-20, kheight/6)];
    view48H.layer.cornerRadius = 10;
    view48H.layer.masksToBounds = YES;
    view48H.backgroundColor = [UIColor blackColor];
    view48H.alpha = 0.4;
    UIImageView *time48 = [[UIImageView alloc]initWithFrame:CGRectMake(kwidth/2-20, self.bounds.size.height*0.54, kwidth/9, kwidth/9)];
    [time48 setImage:[UIImage imageNamed:@"time48.png"]];
    [self addSubview:view48H];
    [self addSubview:time48];
    
    UILabel *contentWind_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth/4, kheight*0.57, 100, 40)];
    contentWind_48.text = @"风";
    contentWind_48.textColor = [UIColor whiteColor];
    contentWind_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:contentWind_48];
    
    UILabel *windUnit_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.3, kheight*0.62, 100, 40)];
    windUnit_48.text = @"级";
    windUnit_48.textColor = [UIColor whiteColor];
    windUnit_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:windUnit_48];
    
    //    UILabel *windAvgUnit_48 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.3, KHight*0.72, 100, 40)];
    //    windAvgUnit_48.text = @"m/s";
    //    windAvgUnit_48.textColor = [UIColor whiteColor];
    //    windAvgUnit_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:windAvgUnit_48];
    
    UILabel *waveContent_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.73, kheight*0.57, 100, 40)];
    waveContent_48.text = @"浪";
    waveContent_48.textColor = [UIColor whiteColor];
    waveContent_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:waveContent_48];
    
//    UILabel *maxWave_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.54, kheight*0.65, 100, 40)];
//    maxWave_48.text = @"最大小";
//    maxWave_48.textColor = [UIColor whiteColor];
//    maxWave_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//    [self addSubview:maxWave_48];
    
//    UILabel *minWave_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.63, kheight*0.7, 100, 40)];
//    minWave_48.textColor = [UIColor whiteColor];
//    minWave_48.text = @"方向";
//    minWave_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//    [self addSubview:minWave_48];
    
    //    UILabel *avgWave_48 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.63, KHight*0.72, 100, 40)];
    //    avgWave_48.text = @"平均";
    //    avgWave_48.textColor = [UIColor whiteColor];
    //    avgWave_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:avgWave_48];
    //风等级
    _wind_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.08, kheight*0.62, 100, 40)];
    _wind_48.textAlignment = NSTextAlignmentCenter;
    _wind_48.textColor = [UIColor whiteColor];
    _wind_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:_wind_48];
    //方向设置
    _windDirection_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.13, kheight*0.67,self.frame.size.width*0.3125, self.frame.size.width*0.125)];
//    _windDirection_48.backgroundColor = [UIColor blackColor];
    _windDirection_48.textColor = [UIColor whiteColor];
    _windDirection_48.textAlignment = NSTextAlignmentCenter;
    _windDirection_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_windDirection_48];
    //平均风速
    //    _windAvg_48 = [[UILabel alloc]initWithFrame:CGRectMake(KWight/12, KHight*0.75, 100, 40)];
    //    _windAvg_48.textColor = [UIColor whiteColor];
    //    _windAvg_48.textAlignment = NSTextAlignmentCenter;
    //    _windAvg_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:_windAvg_48];
    
    //浪
    _wave_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.65, kheight*0.62, 100, 40)];
    _wave_48.textColor = [UIColor whiteColor];
    _wave_48.textAlignment = NSTextAlignmentCenter;
    _wave_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_wave_48];
    
    _waveDirection_48 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.63, kheight*0.67, self.frame.size.width*0.3125, self.frame.size.width*0.125)];
    _waveDirection_48.textColor = [UIColor whiteColor];
    _waveDirection_48.textAlignment = NSTextAlignmentCenter;
    _waveDirection_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_waveDirection_48];
    
    //    _waveAvg_48 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.75, KHight*0.72, 100, 40)];
    //    _waveAvg_48.textColor = [UIColor whiteColor];
    //    _waveAvg_48.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:_waveAvg_48];
    
    
    //72h信息
    UIView *view72H = [[UIView alloc]initWithFrame:CGRectMake(10,kheight*0.79, kwidth-20, kheight/6)];
    view72H.layer.cornerRadius = 10;
    view72H.layer.masksToBounds = YES;
    view72H.backgroundColor = [UIColor blackColor];
    view72H.alpha = 0.4;
    UIImageView *time72 = [[UIImageView alloc]initWithFrame:CGRectMake(kwidth/2-20,self.bounds.size.height*0.75,kwidth/9, kwidth/9)];
    [time72 setImage:[UIImage imageNamed:@"time72.png"]];
    [self addSubview:view72H];
    [self addSubview:time72];
    
    UILabel *contentWind_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth/4, kheight*0.79, 100, 40)];
    contentWind_72.text = @"风";
    contentWind_72.textColor = [UIColor whiteColor];
    contentWind_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:contentWind_72];
    
    UILabel *windUnit_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.3, kheight*0.84, 100, 40)];
    windUnit_72.text = @"级";
    windUnit_72.textColor = [UIColor whiteColor];
    windUnit_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:windUnit_72];
    
    //    UILabel *windAvgUnit_72 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.3, KHight*0.92, 100, 40)];
    //    windAvgUnit_72.text = @"m/s";
    //    windAvgUnit_72.textColor = [UIColor whiteColor];
    //    windAvgUnit_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:windAvgUnit_72];
    
    UILabel *waveContent_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.73, kheight*0.79, 100, 40)];
    waveContent_72.text = @"浪";
    waveContent_72.textColor = [UIColor whiteColor];
    waveContent_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:waveContent_72];
    
//    UILabel *maxWave_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.54, kheight*0.85, 100, 40)];
//    maxWave_72.text = @"最大小";
//    maxWave_72.textColor = [UIColor whiteColor];
//    maxWave_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//    [self addSubview:maxWave_72];
    
//    UILabel *minWave_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.63, kheight*0.9, 100, 40)];
//    minWave_72.textColor = [UIColor whiteColor];
//    minWave_72.text = @"方向";
//    minWave_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//    [self addSubview:minWave_72];
    
    //    UILabel *avgWave_72 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.63, KHight*0.92, 100, 40)];
    //    avgWave_72.text = @"平均";
    //    avgWave_72.textColor = [UIColor whiteColor];
    //    avgWave_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:avgWave_72];
    //风等级
    _wind_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.08, kheight*0.84, 100, 40)];
    _wind_72.textAlignment = NSTextAlignmentCenter;
    _wind_72.textColor = [UIColor whiteColor];
    _wind_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    [self addSubview:_wind_72];
    //方向设置
    _windDirection_72 = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.13, kheight*0.89, self.frame.size.width*0.3125, self.frame.size.width*0.125)];
    _windDirection_72.textColor = [UIColor whiteColor];
    _windDirection_72.textAlignment = NSTextAlignmentCenter;
    _windDirection_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_windDirection_72];
    //平均风速
    //    _windAvg_72 = [[UILabel alloc]initWithFrame:CGRectMake(KWight/12, KHight*0.92, 100, 40)];
    //    _windAvg_72.textColor = [UIColor whiteColor];
    //    _windAvg_72.textAlignment = NSTextAlignmentCenter;
    //    _windAvg_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    //    [self.view addSubview:_windAvg_72];
    
    //浪
    _wave_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.65, kheight*0.84, 100, 40)];
    _wave_72.textColor = [UIColor whiteColor];
    _wave_72.textAlignment = NSTextAlignmentCenter;
    _wave_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_wave_72];
    
    _waveDirection_72 = [[UILabel alloc]initWithFrame:CGRectMake(kwidth*0.63, kheight*0.89, self.frame.size.width*0.3125, self.frame.size.width*0.125)];
    _waveDirection_72.textColor = [UIColor whiteColor];
    _waveDirection_72.textAlignment = NSTextAlignmentCenter;
    _waveDirection_72.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:_waveDirection_72];
    
    [self getUrl:_title];
}



- (void)getUrl:(NSString *)_title
{
    NSURL *url_24 = [self judgeZone24:@"A区"];
    NSURLRequest *requst_24 = [NSURLRequest requestWithURL:url_24 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:requst_24 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *date=[rootDic[0] objectForKey:@"publishtime"];
        NSString *pubtime=[date substringToIndex:16];
//        _releaseTime.text=[NSString stringWithFormat:@"发布时间:%@",pubtime];
        NSNumber *waveavg = [rootDic[0] objectForKey:@"power"];
        NSNumber *minwave = [rootDic[1] objectForKey:@"power"];
        NSNumber *maxwave = [rootDic[2] objectForKey:@"power"];
        CGFloat wavemin = [minwave doubleValue];
        CGFloat wavemax = [maxwave doubleValue];
        NSString *dirwave = [rootDic[1] objectForKey:@"dir"];
        const char *wavechars = [dirwave cStringUsingEncoding:NSUTF8StringEncoding];
        NSString *wavenew;
        NSString *wavenew2;
        NSMutableArray *wavearr = [[NSMutableArray alloc]init];
        int wavelen = strlen(wavechars);
        for (int i = 0; i < wavelen; i++) {
            wavenew = [NSString stringWithFormat:@"%c",wavechars[i]];
            wavenew2 = [self word:wavenew];
            [wavearr addObject:wavenew2];
        }
        NSLog(@"%d",wavelen);
        if (wavelen == 3) {
            NSLog(@"%@%@偏%@",wavearr[2],wavearr[1],wavearr[0]);
            _waveDirection.text = [NSString stringWithFormat:@"%@%@偏%@",wavearr[2],wavearr[1],wavearr[0]];
        }else if(wavelen == 2){
            NSLog(@"%@偏%@",wavearr[1],wavearr[0]);
            _waveDirection.text = [NSString stringWithFormat:@"%@偏%@",wavearr[1],wavearr[0]];
        }else if (wavelen == 1){
            NSLog(@"%@",wavearr[0]);
            _waveDirection.text = [NSString stringWithFormat:@"%@",wavearr[0]];
        }
         _wave.text = [NSString stringWithFormat:@"%.2f-%.2fm",wavemin,wavemax];
        
        
        if(rootDic.count>4){
        NSNumber *avgwind = [rootDic[3] objectForKey:@"power"];
        NSNumber *minwind = [rootDic[4] objectForKey:@"power"];
        NSString *minlevel = [self level:minwind];
        NSString *dirwind = [rootDic[4] objectForKey:@"dir"];
        const char *windchars = [dirwind cStringUsingEncoding:NSUTF8StringEncoding];
        NSString *windnew;
        NSString *windnew2;
        NSMutableArray *windarr = [[NSMutableArray alloc]init];
        int windlen = strlen(windchars);
        for (int i = 0; i < windlen; i++) {
            windnew = [NSString stringWithFormat:@"%c",windchars[i]];
            windnew2 = [self word:windnew];
            [windarr addObject:windnew2];
        }
        NSLog(@"%d",windlen);
        if (windlen == 3) {
            NSLog(@"%@%@偏%@",windarr[2],windarr[1],windarr[0]);
            _windDirection.text = [NSString stringWithFormat:@"%@%@偏%@",windarr[2],windarr[1],windarr[0]];
        }else if(windlen == 2){
            NSLog(@"%@偏%@",windarr[1],windarr[0]);
            _windDirection.text = [NSString stringWithFormat:@"%@偏%@",windarr[1],windarr[0]];
        }else if (windlen == 1){
            NSLog(@"%@",windarr[0]);
            _windDirection.text = [NSString stringWithFormat:@"%@",windarr[0]];
        }
        
        
        _wind.text = minlevel;
      
        }else{
            _windDirection_72.text=@" ";
            _wind_72.text=@" ";

        }
        
    }];
    
    NSURL *url_48 = [self judgeZone48:@"A区"];
    NSURLRequest *requst_48 = [NSURLRequest requestWithURL:url_48 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:requst_48 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSNumber *waveavg = [rootDic[0] objectForKey:@"power"];
        NSNumber *minwave = [rootDic[1] objectForKey:@"power"];
        NSNumber *maxwave = [rootDic[2] objectForKey:@"power"];
        CGFloat wavemin = [minwave doubleValue];
        CGFloat wavemax = [maxwave doubleValue];
        NSString *dirwave = [rootDic[1] objectForKey:@"dir"];
        const char *wavechars = [dirwave cStringUsingEncoding:NSUTF8StringEncoding];
        NSString *wavenew;
        NSString *wavenew2;
        NSMutableArray *wavearr = [[NSMutableArray alloc]init];
        int wavelen = strlen(wavechars);
        for (int i = 0; i < wavelen; i++) {
            wavenew = [NSString stringWithFormat:@"%c",wavechars[i]];
            wavenew2 = [self word:wavenew];
            [wavearr addObject:wavenew2];
        }
        NSLog(@"%d",wavelen);
        if (wavelen == 3) {
            NSLog(@"%@%@偏%@",wavearr[2],wavearr[1],wavearr[0]);
            _waveDirection_48.text = [NSString stringWithFormat:@"%@%@偏%@",wavearr[2],wavearr[1],wavearr[0]];
        }else if(wavelen == 2){
            NSLog(@"%@偏%@",wavearr[1],wavearr[0]);
            _waveDirection_48.text = [NSString stringWithFormat:@"%@偏%@",wavearr[1],wavearr[0]];
        }else if (wavelen == 1){
            NSLog(@"%@",wavearr[0]);
            _waveDirection_48.text = [NSString stringWithFormat:@"%@",wavearr[0]];
        }
        _wave_48.text = [NSString stringWithFormat:@"%.2f-%.2fm",wavemin,wavemax];
        
        
        if (rootDic.count>4) {
            
        NSNumber *avgwind = [rootDic[3] objectForKey:@"power"];
        NSNumber *minwind = [rootDic[4] objectForKey:@"power"];
        NSString *minlevel = [self level:minwind];
        NSString *dirwind = [rootDic[4] objectForKey:@"dir"];
        const char *windchars = [dirwind cStringUsingEncoding:NSUTF8StringEncoding];
        NSString *windnew;
        NSString *windnew2;
        NSMutableArray *windarr = [[NSMutableArray alloc]init];
        int windlen = strlen(windchars);
        for (int i = 0; i < windlen; i++) {
            windnew = [NSString stringWithFormat:@"%c",windchars[i]];
            windnew2 = [self word:windnew];
            [windarr addObject:windnew2];
        }
        NSLog(@"%d",windlen);
        if (windlen == 3) {
            NSLog(@"%@%@偏%@",windarr[2],windarr[1],windarr[0]);
            _windDirection_48.text = [NSString stringWithFormat:@"%@%@偏%@",windarr[2],windarr[1],windarr[0]];
        }else if(windlen == 2){
            NSLog(@"%@偏%@",windarr[1],windarr[0]);
            _windDirection_48.text = [NSString stringWithFormat:@"%@偏%@",windarr[1],windarr[0]];
        }else if (windlen == 1){
            NSLog(@"%@",windarr[0]);
            _windDirection_48.text = [NSString stringWithFormat:@"%@",windarr[0]];
        }
        
        
        _wind_48.text = minlevel;
       
        }else{
            _windDirection_72.text=@" ";
            _wind_72.text=@" ";
        }
        
        
    }];
    
    NSURL *url_72 = [self judgeZone72:@"A区"];
    NSURLRequest *requst_72 = [NSURLRequest requestWithURL:url_72 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:requst_72 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        
        NSLog(@"zeyzeyzye---%@",connectionError);
        
        NSMutableArray *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        
        NSNumber *waveavg = [rootDic[0] objectForKey:@"power"];
        NSNumber *minwave = [rootDic[1] objectForKey:@"power"];
        NSNumber *maxwave = [rootDic[2] objectForKey:@"power"];
        CGFloat wavemin = [minwave doubleValue];
        CGFloat wavemax = [maxwave doubleValue];
        NSString *dirwave = [rootDic[1] objectForKey:@"dir"];
        const char *wavechars = [dirwave cStringUsingEncoding:NSUTF8StringEncoding];
        NSString *wavenew;
        NSString *wavenew2;
        NSMutableArray *wavearr = [[NSMutableArray alloc]init];
        int wavelen = strlen(wavechars);
        for (int i = 0; i < wavelen; i++) {
            wavenew = [NSString stringWithFormat:@"%c",wavechars[i]];
            wavenew2 = [self word:wavenew];
            [wavearr addObject:wavenew2];
        }
        NSLog(@"%d",wavelen);
        if (wavelen == 3) {
            NSLog(@"%@%@偏%@",wavearr[2],wavearr[1],wavearr[0]);
            _waveDirection_72.text = [NSString stringWithFormat:@"%@%@偏%@",wavearr[2],wavearr[1],wavearr[0]];
        }else if(wavelen == 2){
            NSLog(@"%@偏%@",wavearr[1],wavearr[0]);
            _waveDirection_72.text = [NSString stringWithFormat:@"%@偏%@",wavearr[1],wavearr[0]];
        }else if (wavelen == 1){
            NSLog(@"%@",wavearr[0]);
            _waveDirection_72.text = [NSString stringWithFormat:@"%@",wavearr[0]];
        }
        
         _wave_72.text = [NSString stringWithFormat:@"%.2f-%.2fm",wavemin,wavemax];
        
        
        if (rootDic.count>4) {
            NSNumber *avgwind = [rootDic[3] objectForKey:@"power"];
            NSNumber *minwind = [rootDic[4] objectForKey:@"power"];
            NSString *minlevel = [self level:minwind];
            NSString *dirwind = [rootDic[4] objectForKey:@"dir"];
            const char *windchars = [dirwind cStringUsingEncoding:NSUTF8StringEncoding];
            NSString *windnew;
            NSString *windnew2;
            NSMutableArray *windarr = [[NSMutableArray alloc]init];
            int windlen = strlen(windchars);
            for (int i = 0; i < windlen; i++) {
                windnew = [NSString stringWithFormat:@"%c",windchars[i]];
                windnew2 = [self word:windnew];
                [windarr addObject:windnew2];
            }
            NSLog(@"%d",windlen);
            if (windlen == 3) {
                NSLog(@"%@%@偏%@",windarr[2],windarr[1],windarr[0]);
                _windDirection_72.text = [NSString stringWithFormat:@"%@%@偏%@",windarr[2],windarr[1],windarr[0]];
            }else if(windlen == 2){
                NSLog(@"%@偏%@",windarr[1],windarr[0]);
                _windDirection_72.text = [NSString stringWithFormat:@"%@偏%@",windarr[1],windarr[0]];
            }else if (windlen == 1){
                NSLog(@"%@",windarr[0]);
                _windDirection_72.text = [NSString stringWithFormat:@"%@",windarr[0]];
            }
            

            _wind_72.text = minlevel;
          
        }else{
            _windDirection_72.text=@" ";
            _wind_72.text=@" ";
        }
        
        
        
        
    }];
    
}



#pragma mark - 判断url
- (NSURL *)judgeZone24:(NSString *)_title
{
    NSURL *url;
    if ([_title isEqualToString:@"A区"]) {
        url = [NSURL URLWithString:urlZoneA24];
    }else if ([_title isEqualToString:@"B区"]){
        url = [NSURL URLWithString:urlZoneB24];
    }else if ([_title isEqualToString:@"C区"]){
        url = [NSURL URLWithString:urlZoneC24];
    }else if ([_title isEqualToString:@"D区"]){
        url = [NSURL URLWithString:urlZoneD24];
    }
    return url;
}



- (NSURL *)judgeZone48:(NSString *)_title
{
    NSURL *url;
    if ([_title isEqualToString:@"A区"]) {
        url = [NSURL URLWithString:urlZoneA48];
    }else if ([_title isEqualToString:@"B区"]){
        url = [NSURL URLWithString:urlZoneB48];
    }else if ([_title isEqualToString:@"C区"]){
        url = [NSURL URLWithString:urlZoneC48];
    }else if ([_title isEqualToString:@"D区"]){
        url = [NSURL URLWithString:urlZoneD48];
    }
    return url;
}



- (NSURL *)judgeZone72:(NSString *)_title
{
    NSURL *url;
    if ([_title isEqualToString:@"A区"]) {
        url = [NSURL URLWithString:urlZoneA72];
    }else if ([_title isEqualToString:@"B区"]){
        url = [NSURL URLWithString:urlZoneB72];
    }else if ([_title isEqualToString:@"C区"]){
        url = [NSURL URLWithString:urlZoneC72];
    }else if ([_title isEqualToString:@"D区"]){
        url = [NSURL URLWithString:urlZoneD72];
    }
    return url;
}


//风级转换
- (NSString *)word:(NSString *)dirdir
{
    NSString *word ;
    
    if ([dirdir isEqualToString:@"W"]) {
        word = @"西";
    }else if ([dirdir isEqualToString:@"S"]){
        word = @"南";
    }else if ([dirdir isEqualToString:@"N"]){
        word = @"北";
    }else if ([dirdir isEqualToString:@"E"]){
        word = @"东";
    }
    return word;
}



//风速等级转换
- (NSString *)level:(NSNumber *)windsu
{
    NSString *level;
    CGFloat number = [windsu doubleValue];
    NSLog(@"%f",number);
    //    NSNumber *windsu;
    
    if (0< number < 0.2) {
        level = @" 0 ";
    }else if (number < 1.5){
        level = @" 1 ";
    }else if (number < 3.3){
        level = @" 2 ";
    }else if (number < 5.4){
        level = @" 3 ";
    }else if (number < 7.9){
        level = @" 4 ";
    }else if (number < 10.7){
        level = @" 5 ";
    }else if (number < 13.8){
        level = @" 6 ";
    }else if (number < 17.1){
        level = @" 7 ";
    }else if (number < 20.7){
        level = @" 8 ";
    }else if (number < 24.4){
        level = @" 9 ";
    }else if (number < 28.4){
        level = @" 10 ";
    }else if (number< 32.6){
        level = @" 11 ";
    }else if (number > 32.6){
        level = @" 12 ";
    }
    return level;
}
 
@end
