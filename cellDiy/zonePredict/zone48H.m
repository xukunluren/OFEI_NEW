//
//  zone48H.m
//  OFei
//
//  Created by zey on 15/11/12.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "zone48H.h"

@implementation zone48H


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2.5, self.bounds.size.height/14, 100, 40)];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:44];
        [self addSubview:_titleLabel];
    }
    return self;
}


#pragma mark - 页面布局
-(void)drawRect:(CGRect)rect
{
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.width/4, self.bounds.size.height/10, 100, 40)];
    time.text = @"48H";
    time.textColor = [UIColor blueColor];
    //    time.font = [UIFont fontWithName:@"Arial" size:16];
    time.font = [UIFont fontWithName:@"Zapfino" size:14];
    
    [self addSubview:time];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/6, self.bounds.size.width, 10)];
    line.image = [UIImage imageNamed:@"Line.png"];
    [self addSubview:line];
    
    UILabel *contentWind = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/5, self.bounds.size.height/4.5, 100, 40)];
    contentWind.text = @"风：";
    contentWind.textColor = [UIColor blackColor];
    contentWind.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:30];
    [self addSubview:contentWind];
    
    UILabel *windUnit = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.width/3, self.bounds.size.height/4.5, 100, 40)];
    windUnit.text = @"级";
    windUnit.textColor = [UIColor blackColor];
    windUnit.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:windUnit];
    
    //设置变量  风级
    _wind = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/3, self.bounds.size.height/4.5, 100, 50)];
    _wind.textAlignment = NSTextAlignmentCenter;
    _wind.textColor = [UIColor blueColor];
    //    _wind.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:26];
    _wind.font = [UIFont fontWithName:@"Zapfino" size:26];
    
    [self addSubview:_wind];
    
    //方向设置
    _windDirection = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.width/4.5, self.bounds.size.height/4.5, 50, 40)];
    _windDirection.textColor = [UIColor blueColor];
    _windDirection.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:26];
    [self addSubview:_windDirection];
    
    
    UILabel *windAvgUnit = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.width/3, self.bounds.size.height/3, 100, 40)];
    windAvgUnit.text = @"m/s";
    windAvgUnit.textColor = [UIColor blackColor];
    windAvgUnit.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:windAvgUnit];
    
    //设置变量  风速平均
    _windAvg = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/3, self.bounds.size.height/3, 100, 50)];
    _windAvg.textColor = [UIColor blueColor];
    _windAvg.textAlignment = NSTextAlignmentCenter;
    //    _windAvg.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:26];
    _windAvg.font = [UIFont fontWithName:@"Zapfino" size:26];
    
    [self addSubview:_windAvg];
    
    _detailWind = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.height/2.4, rect.size.width, 30)];
    _detailWind.textColor = [UIColor blackColor];
    _detailWind.textAlignment = NSTextAlignmentCenter;
    _detailWind.font = [UIFont fontWithName:@"Arial" size:16];
    [self addSubview:_detailWind];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/2.1, self.bounds.size.width,10)];
    line1.image = [UIImage imageNamed:@"Line.png"];
    [self addSubview:line1];
    
    UILabel *contentWave = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/5,self.bounds.size.height - self.bounds.size.height/2.2, 100, 30)];
    contentWave.text = @"浪：";
    contentWave.textColor = [UIColor blackColor];
    contentWave.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:30];
    [self addSubview:contentWave];
    
    //设置浪高
    _wave = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/3, self.bounds.size.height - self.bounds.size.height/2.2, 100, 50)];
    _wave.textColor = [UIColor blueColor];
    _wave.textAlignment = NSTextAlignmentCenter;
    _wave.font = [UIFont fontWithName:@"Zapfino" size:11];
    [self addSubview:_wave];
    
    //浪的方向
    _waveDirection = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.width/4.5, self.bounds.size.height - self.bounds.size.height/2.2, 100, 50)];
    _waveDirection.textColor = [UIColor blueColor];
    _waveDirection.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:26];
    [self addSubview:_waveDirection];
    
    UILabel *waveUnit = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width -  self.bounds.size.width/3,self.bounds.size.height - self.bounds.size.height/2.3, 100, 30)];
    waveUnit.text = @"m";
    waveUnit.textColor = [UIColor blackColor];
    waveUnit.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:waveUnit];
    
    UILabel *waveAvgUnit = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width -  self.bounds.size.width/3,self.bounds.size.height - self.bounds.size.height/2.8, 100, 40)];
    waveAvgUnit.text = @"m";
    waveAvgUnit.textColor = [UIColor blackColor];
    waveAvgUnit.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
    [self addSubview:waveAvgUnit];
    
    //设置浪平均高
    _waveAvg = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/3, self.bounds.size.height - self.bounds.size.height/2.8, 100, 50)];
    _waveAvg.textColor = [UIColor blueColor];
    _waveAvg.font = [UIFont fontWithName:@"Zapfino" size:26];
    [self addSubview:_waveAvg];
    
    _detailWave = [[UILabel alloc]initWithFrame:CGRectMake(10,self.bounds.size.height - self.bounds.size.height/4, rect.size.width, 40)];
    _detailWave.font = [UIFont fontWithName:@"Arial" size:16];
    _detailWave.textColor = [UIColor blackColor];
    _detailWave.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_detailWave];
}

#pragma mark - 数据获取代理
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"22222");
    [self.listData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _listData = [[NSMutableData alloc]init];
    NSError *error = nil;
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:_listData options:NSJSONReadingMutableLeaves error:&error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"huoquchenggong");
    NSString *string = [[NSString alloc]initWithData:self.listData encoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSArray *rootDic = [NSJSONSerialization JSONObjectWithData:_listData options:NSJSONReadingMutableLeaves error:&error];
    NSNumber *waveavg = [rootDic[0] objectForKey:@"POWER"];
    NSNumber *minwave = [rootDic[1] objectForKey:@"POWER"];
    NSNumber *maxwave = [rootDic[2] objectForKey:@"POWER"];
    NSString *dirwave = [rootDic[1] objectForKey:@"DIR"];
    
    NSNumber *avgwind = [rootDic[3] objectForKey:@"POWER"];
    NSNumber *minwind = [rootDic[4] objectForKey:@"POWER"];
    NSNumber *maxwind = [rootDic[5] objectForKey:@"POWER"];
    NSString *dirwind = [rootDic[4] objectForKey:@"DIR"];
    
    //向label中传值
    _wave.text = [NSString stringWithFormat:@"%@--%@",minwave,maxwave];
    _waveAvg.text = [NSString stringWithFormat:@"%@",waveavg];
    _waveDirection.text = dirwave;
    _detailWave.text = [NSString stringWithFormat:@"最小浪高%@m最大浪高%@m浪高均值%@m",minwave,maxwave,waveavg];
    
    NSString *minlevel = [self level:minwind];
    //    NSString *maxlevel = [self level:maxwind];
    _wind.text = [NSString stringWithFormat:@"%@",minlevel];
    _windAvg.text = [NSString stringWithFormat:@"%@",avgwind];
    _windDirection.text = dirwind;
    _detailWind.text = [NSString stringWithFormat:@"风力等级:%@，风速平均值:%@m/s",maxwind,avgwind];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
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
- (NSString *)sendtitle:(NSString *)gettitle
{
    NSLog(@"%@",gettitle);
    if ([gettitle isEqualToString:@"A区"]) {
        //1.请求地址
        NSURL *url = [NSURL URLWithString:urlZoneA48];
        //2.创建请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //3.连接服务器
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    }else if ([gettitle isEqualToString:@"B区"]){
        NSLog(@"chenggongjiuchifan");
        NSURL *url = [NSURL URLWithString:urlZoneB48];
        //2.创建请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //3.连接服务器
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    }else if ([gettitle isEqualToString:@"C区"]){
        NSURL *url = [NSURL URLWithString:urlZoneC48];
        //2.创建请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //3.连接服务器
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    }else if ([gettitle isEqualToString:@"D区"]){
        NSURL *url = [NSURL URLWithString:urlZoneD48];
        //2.创建请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        //3.连接服务器
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
    return gettitle;
}


@end
