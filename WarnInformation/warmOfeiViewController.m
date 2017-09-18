//
//  warmOfeiViewController.m
//  OFei
//
//  Created by admin on 15/12/1.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "warmOfeiViewController.h"
#import "OFeiCommon.h"
#import "Diycell.h"
#import "warmDetail.h"
#import "LxFTPRequest.h"
#import "PellTableViewSelect.h"
#import "NormalViewController.h"
#import "Warm.h"
#import "Warm+CoreDataProperties.h"
#import "WZLBadgeImport.h"
#import "UIView+Frame.h"


static NSString * const FTP_ADDRESS_A = @"ftp://ftp.dhybzx.org/%EA%B1%B7%C9%D4%A4%BE%AF%B1%A8/%BA%A3%C0%CB%BE%AF%B1%A8/";
static NSString * const FTP_ADDRESS_B = @"ftp://ftp.dhybzx.org/%EA%B1%B7%C9%D4%A4%BE%AF%B1%A8/%B7%E7%B1%A9%B3%B1%BE%AF%B1%A8/";

static NSString * const USERNAME = @"ybs";
static NSString * const PASSWORD = @"56637190";

@interface warmOfeiViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
{


    // CoreData数据操作的上下文，负责所有的数据操作，类似于SQLite的数据库连接句柄
    NSManagedObjectContext *_context;
    
    NSString *netTime;

}
@end

@implementation warmOfeiViewController
{
    //  __block  NSMutableArray *_nameArray;
    NSMutableArray *_numberArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_colorArray;
//    NSMutableArray *_dateArray;
    NSMutableArray *_date;
    NSMutableArray *_titlenameArray;
    NSMutableArray *_datenumArray;
    NSMutableArray *_urlArray;
    NSArray *_zhongzhuanArray;
    
    NSString *_title;
    NSString *_ftpURL;
    NSString *_biaozhi;
    NSString *_dateinfo;
    
    
    NormalViewController *normal;
}

#pragma mark - 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏底部线
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bargound.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mydelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    normal=[[NormalViewController alloc]init];
    _nameArray = [[NSMutableArray alloc] init];
    _dateArray = [[NSMutableArray alloc] init];
    _numberArray =[[NSMutableArray alloc] init];
    _titleArray =[[NSMutableArray alloc] init];
    _colorArray = [[NSMutableArray alloc] init];
    _date = [[NSMutableArray alloc] init];
    _titlenameArray = [[NSMutableArray alloc] init];
    _datenumArray = [[NSMutableArray alloc] init];
    _urlArray = [[NSMutableArray alloc] init];
//    _zhongzhuanArray = [[NSMutableArray alloc] init];
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
    _title = @"海浪预警";
    [self createTable];
    [self setNavTitle:_title];
    [self getList];
    [self getNetTime];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 定时刷新获取最新公文
        [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(getList) userInfo:_title repeats:YES];
        
        [[NSRunLoop currentRunLoop] run];
    });
    
    
   

}



-(void)setNavTitle:(NSString *)title
{
    
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    self.navigationItem.leftBarButtonItem = left;
    
    UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(70, 0, 70, 40);
    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
    [select addTarget:self action:@selector(selectWarm) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake( 20, 10, 40, 40);
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    _titleLabel = label;
    _titleLabel.text = _title;
    NSLog(@"当时的标题:%@",_title);
    [_titleLabel sizeToFit];
    [middle addSubview:select];
    [middle addSubview:label];
    
    [label sizeToFit];
    self.navigationItem.titleView = middle;
    
    
    //    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    //    [exampleButton1 addTarget:self action:@selector(selectWarm) forControlEvents:UIControlEventTouchUpInside];
    //    [exampleButton1 setImage:[UIImage imageNamed:@"down-25.png"] forState:UIControlStateNormal];
    //    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
    //    self.navigationItem.rightBarButtonItem = right;
}

-(void)selectWarm
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(KWight*0.5-67.5, 64, 150, 120) selectData:@[@"海浪预警",@"风暴潮预警"] action:^(NSInteger index) {
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"海浪预警";
        }
        if (index == 1) {
            _title = @"风暴潮预警";
        }
//        if (index == 2) {
//            _title = @"大风预警";
//        }
        
        [self viewDidAppear:YES];
        NSLog(@"%@",_title);
        [self setNavTitle:_title];
        [_warmTable removeFromSuperview];
        [self getList];
        
    } animated:YES];
}


-(void)createTable
{
    _warmTable = [[UITableView alloc] initWithFrame:CGRectMake(0,65,KWight,KHight) style:UITableViewStylePlain];
    _warmTable.alpha = 0.7;
    _warmTable.layer.cornerRadius = 10;
    _warmTable.layer.masksToBounds = YES;
//    [_warmTable setSeparatorColor:[UIColor blackColor]];
    [_warmTable setDelegate:self];
    [_warmTable setDataSource:self];
    [self.view addSubview:_warmTable];
}

-(NSArray *)getList
//:(NSString *)title
{

//    NSLog(@"%@",title);
    
    NSLog(@"%@",_title);
    //为了防止预警信息切换后数据组不是空的情况
    [_nameArray removeAllObjects];
    [_numberArray removeAllObjects];
    [_titleArray removeAllObjects];
    [_colorArray removeAllObjects];
    [_dateArray removeAllObjects];
    [_date removeAllObjects];
    [_titlenameArray removeAllObjects];
    [_datenumArray removeAllObjects];
    
    typeof(self) __weak weakSelf = self;
    if ([_title isEqualToString:@"海浪预警"]) {
        _ftpURL = FTP_ADDRESS_A;
        _biaozhi = @"A";
    }else if ([_title isEqualToString:@"风暴潮预警"])
    {
        _ftpURL = FTP_ADDRESS_B;
        _biaozhi = @"B";
    }else
    {//为大风预警信息预留空间
        _ftpURL = FTP_ADDRESS_A;
        _biaozhi = @"A";
    }
    NSLog(@"%@",_ftpURL);
    LxFTPRequest * request = [LxFTPRequest resourceListRequest];
    request.serverURL = [[NSURL URLWithString:_ftpURL]URLByAppendingPathComponent:@""];
    request.username = USERNAME;
    request.password = PASSWORD;
    request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
        
        totalSize = MAX(totalSize, finishedSize);
    };
    request.successAction = ^(Class resultClass, id result) {
        
        
        NSArray * resultArray = (NSArray *)result;
        
        NSLog( @"%lu",(unsigned long)_nameArray.count);
        for (NSDictionary *dic in resultArray) {
            NSLog(@"----------------------%@",dic);
            NSString *nameUrl = [dic objectForKey:@"kCFFTPResourceName"];
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSDictionary *dic1 = [self entryByReencodingNameInEntry:dic encoding:gbkEncoding];
            NSString *name1 =[dic1 objectForKey:@"kCFFTPResourceName"];
            
        
            if (name1.length>2) {
                NSDate *datestring1 = [dic objectForKey:@"kCFFTPResourceModDate"];
//                NSString *datestring2 = [datestring1 substringToIndex:10];
                NSLog(@"%@",datestring1);
                [_date addObject:datestring1];
                
                
                [self stringForAnaly:name1 andBiaozhi:_biaozhi];
                NSString *name1111 =[name1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"%@",name1111);
                //获取url链接的内容并存入数组中，等待对数据内容进行排序
                NSString *name = [nameUrl stringByAddingPercentEscapesUsingEncoding:NSMacOSRomanStringEncoding];
                [_nameArray addObject:name];
            }

        }
        //数组的比较将最近日期的预警信息放到最前面显示
        
    
        _titlenameArray = [self compareArraydate:_date andTitle:_titleArray];
        NSLog(@"====%@",_dateArray);
      
        NSLog(@"%@",_dateinfo);
        [self campareOfStringForTuisong];
        _urlArray = [self compareArrayurl:_date andTitle:_nameArray];
        NSLog(@"%@,%@",_titlenameArray[0],_titlenameArray[2]);
        [_warmTable removeFromSuperview];
        [weakSelf createTable];
    };
    request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
        
        NSLog(@"%@==失败",errorMessage);
    };
    [request start];
    NSLog(@"%lu",(unsigned long)_nameArray.count);
    return _nameArray;
}

-(void)campareOfStringForTuisong
{
    
    for (NSString *str in _dateArray) {
        [self setdataToCoreData:str];
    }
  
    
//    _dateinfo = @"2016-01-11";
//    NSString *iiii = _dateArray.firstObject;
//    NSLog(@"%@======%@",_dateinfo,iiii);
////    _dateinfo = _dateArray.firstObject;
//    if ([_dateinfo isEqualToString:iiii]) {
//        NSLog(@"无最新预警信息");
//    }else{
//        
//        NSLog(@"有最新预警信息");
//        _dateinfo = _dateArray.firstObject;
//    }

}

-(void)setdataToCoreData:(NSString *)str{
    
    NSInteger intId = 0;
    NSArray *date111 = [self getdatafromCoreData:@"Warm"];
    
    for (Warm *items in date111) {
        NSLog(@"%@",items.date);
        if ([items.date isEqualToString:str]) {
            NSLog(@"%@",items);
            intId = 1;
        }
    }
    
    if (intId == 0) {
        
        NSLog(@"有最新预警信息");
        
        Warm *items = (Warm *)[NSEntityDescription insertNewObjectForEntityForName:@"Warm" inManagedObjectContext:self.mydelegate.managedObjectContext];
        [items setValue:str forKey:@"date"];
        [items setValue:str forKey:@"title"];
        
        
//        [self notification];
        
    }
}


#pragma mark - Local Notification
//- (void)notification
//{
//    // 创建一个本地推送
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    //设置10秒之后
//    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
//    if (notification != nil) {
//        // 设置推送时间
//        notification.fireDate = pushDate;
//        // 设置时区
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        // 设置重复间隔
//        notification.repeatInterval = kCFCalendarUnitDay;
//
//        // 推送声音
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        // 推送内容
//        notification.alertBody = [NSString stringWithFormat:@"您有新的预警信息请查收。"];
//        // 推送时小图标的设置，
//        notification.alertLaunchImage=[[NSBundle mainBundle] pathForResource:@"Icon-Small" ofType:@"png"];
//        // 显示在icon上的红色圈中的数子
//        //        _badgeNumber++;
////        [UIApplication sharedApplication].applicationIconBadgeNumber = _badgeNumber;
////        
////        NSDictionary *info = [NSDictionary dictionaryWithObject:objectName forKey:keyGUID];
////        notification.userInfo = info;
//        // 添加推送到UIApplication
//        UIApplication *app = [UIApplication sharedApplication];
//        // 计划本地推送
//        [app scheduleLocalNotification:notification];
//        // 即时推送
//        //        [app presentLocalNotificationNow:notification];
//    }
//}
//返回排序好的标题内容
-(NSMutableArray *)compareArraydate:(NSMutableArray *)dateArray andTitle:(NSMutableArray *)titleArray
{
    int i,j;

    for (i=0; i<dateArray.count-1; i++) {
        for (j=i+1; j<dateArray.count; j++) {
            if ([dateArray[i] timeIntervalSinceDate:dateArray[j]] < 0.0) {
                [dateArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                [titleArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                [_colorArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                [_nameArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    _datenumArray = [NSMutableArray arrayWithArray:dateArray];
    [self analyDataArray:dateArray];
    NSLog(@"%@",_datenumArray[0]);
    return titleArray;
}

//返回排序好的URL链接地址
-(NSMutableArray *)compareArrayurl:(NSMutableArray *)dateArray andTitle:(NSMutableArray *)nameArray
{
    int i,j;
    
    for (i=0; i<dateArray.count-1; i++) {
        for (j=i+1; j<dateArray.count; j++) {
            if ([dateArray[i] timeIntervalSinceDate:dateArray[j]] < 0.0) {
                [dateArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                [nameArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                [_nameArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    _datenumArray = [NSMutableArray arrayWithArray:dateArray];
    [self analyDataArray:dateArray];
    NSLog(@"%@",_datenumArray[0]);
    return nameArray;
}
#pragma 对日期数据进行解析
-(void)analyDataArray:(NSMutableArray*)dateArray
{
    for (NSDate *date in dateArray) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:date];
        NSLog(@"%@",destDateString);
        [_dateArray addObject:destDateString];
    }
}
#pragma 字符串的分割
-(void)stringForAnaly:(NSString *)name andBiaozhi:(NSString *)biaozhi
{
    //从文档名字中解析出想要的信息
    NSString *number = [name substringToIndex:3];
    [_numberArray addObject:number];
    NSString *title1 = [name substringFromIndex:3];
    if ([name length]<16) {
        NSString *title = [title1 substringToIndex:[title1 length]-4];
        [_titleArray addObject:title];
//        NSString *date = @"yymmhh";
//        [_dateArray addObject:date];
        NSString *color = @"blue";
        [_colorArray addObject:color];
        
        NSLog(@"%@",_colorArray);
    }else{
        NSString *title = [title1 substringToIndex:[title1 length]-14];
        [_titleArray addObject:title];
        NSString *color1 = [name substringFromIndex:[name length]-14];
        NSString *color = [color1 substringToIndex:1];
        [_colorArray addObject:color];
//        NSString *date1 = [name substringFromIndex:[name length]-12];
//        NSString *date = [date1 substringToIndex:[date1 length]-4];
//        [_dateArray addObject:date];
    }
    
}
- (NSDictionary *)entryByReencodingNameInEntry:(NSDictionary *)entry encoding:(NSStringEncoding)newEncoding

{
    NSDictionary *  result;
    NSString *      name;
    NSData *        nameData;
    NSString *      newName;
    
    newName = nil;
    
    
    name = [entry objectForKey:(id) kCFFTPResourceName];
    if (name != nil) {
        assert([name isKindOfClass:[NSString class]]);
        
        nameData = [name dataUsingEncoding:NSMacOSRomanStringEncoding];
        if (nameData != nil) {
            newName = [[NSString alloc] initWithData:nameData encoding:newEncoding];
        }
    }
    
    
    
    // If the above failed, just return the entry unmodified.  If it succeeded,
    // make a copy of the entry and replace the name with the new name that we
    // calculated.
    
    if (newName == nil) {
        
        result = (NSDictionary *) entry;
    } else {
        NSMutableDictionary *   newEntry;
        
        newEntry = [entry mutableCopy];
        assert(newEntry != nil);
        
        [newEntry setObject:newName forKey:(id) kCFFTPResourceName];
        
        result = newEntry;
    }
    
    return result;
}


-(void)back{
    
//    normal.dotImage.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES ];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    Diycell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Diycell" owner:self options:nil] lastObject];
    }
    //cell后端的返回键
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.year.text = _numberArray[indexPath.row];
    cell.date.text = _dateArray[indexPath.row];
    cell.title.text=_titleArray[indexPath.row];
    
//    NSString *string=@"2016-07-09";
    
    //图标new
    if ([_dateArray[indexPath.row] isEqualToString:netTime]) {
        cell.newlogo.hidden = NO;
        
    }else{
        cell.newlogo.hidden=YES;
    }
    NSLog(@"%@",_colorArray[indexPath.row]);
    if ([_colorArray[indexPath.row] isEqualToString:@"红"]) {
        //        cell.color.backgroundColor=[UIColor redColor];
        //        cell.color.layer.cornerRadius=5;
        cell.imageView.image = [UIImage imageNamed:@"red"];
        cell.imageView.layer.cornerRadius = 5;
        
    }else if ([_colorArray[indexPath.row] isEqualToString:@"黄"])
    {
        //        UIColor *myColor1= [UIColor colorWithRed:(CGFloat)225/255.0 green:(CGFloat)200/255.0 blue:(CGFloat)0 alpha:1];
        //        cell.color.backgroundColor=myColor1;
        //        cell.color.layer.cornerRadius=5;
        cell.imageView.image = [UIImage imageNamed:@"yellow"];
        cell.imageView.layer.cornerRadius = 5;
        
    }else if ([_colorArray[indexPath.row] isEqualToString:@"蓝"])
    {
        //        cell.color.backgroundColor=[UIColor blueColor];
        //        cell.color.layer.cornerRadius=5;
        cell.imageView.image = [UIImage imageNamed:@"blue"];
        cell.imageView.layer.cornerRadius = 5;
        
    }else if ([_colorArray[indexPath.row] isEqualToString:@"橙"])
    {
        //        UIColor *myColor2=[UIColor colorWithRed:(CGFloat)255/255.0 green:(CGFloat)100/255.0 blue:(CGFloat)0 alpha:1];
        //        cell.color.backgroundColor=myColor2;
        //        cell.color.layer.cornerRadius=5;
        cell.imageView.image = [UIImage imageNamed:@"orange"];
        cell.imageView.layer.cornerRadius = 5;
        
    }
    else if ([_colorArray[indexPath.row] isEqualToString:@"通"])
    {
        
        cell.imageView.image = [UIImage imageNamed:@"alarmoff2"];
        cell.imageView.layer.cornerRadius = 5;
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"alarmoff2"];
        cell.imageView.layer.cornerRadius = 5;
    }
    
    //    tableView.separatorStyle=UITableViewCellEditingStyleNone;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"你选择了%ld",(long)indexPath.row);
    NSString *name = _urlArray[indexPath.row];
    NSLog(@"名字是%@",name);
    NSString *url1 = [NSString stringWithFormat:@"%@%@",_ftpURL,name];
    //    NSURL *url = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:name];
    NSURL *url = [NSURL URLWithString:url1];
    warmDetail  *waemdetail = [[warmDetail alloc] init];
    self.delegate = waemdetail;
    waemdetail.url = url;
    [self.delegate sendTitle:url andName:_title];
    [self.navigationController pushViewController:waemdetail animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

// 自绘分割线
- (void)drawRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.view.frame.size.width, 1));
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, self.view.frame.size.height - 1, self.view.frame.size.width, 1));
}


//hidden
- (void)viewWillDisappear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = NO;
//    normal.dotImage.hidden=YES;
}




-(NSArray *)getdatafromCoreData:(NSString *)par{
    
    
    
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:par inManagedObjectContext:self.mydelegate.managedObjectContext];
    [request setEntity:user];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_mydelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    
    
    return mutableFetchResult;
    
}


-(void)getNetTime{
    
    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    [connection start];
    
  
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dict=[httpResponse allHeaderFields];
        //      NSLog(@"dict--%@",dict);
        NSString *time=[dict objectForKey:@"Date"];
        NSLog(@"date--%@___class---%@",time,[time class]);
        [self dateFromNSString:time];
    }
}

-(NSDate *)dateFromNSString:(NSString *)str{
   
    NSString *timeStr=[str substringWithRange:NSMakeRange(5, 20)];//截取字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSLocale *local=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:local];//需要配置区域，不然会造成模拟器正常，真机日期为null的情况
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];//设置源时间字符串的格式
    NSDate* date = [formatter dateFromString:timeStr];//将源时间字符串转化为NSDate
    NSLog(@"zey.date--%@___class---%@",date,[date class]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
   
    netTime=[strDate substringToIndex:10];
    
//     NSLog(@"zeyzey---%@",netTime );

    
    //可以自己再换格式，上面是源，下面是目标
    //     NSDateFormatter* toformatter = [[NSDateFormatter alloc] init];
    //     [toformatter setDateStyle:NSDateFormatterMediumStyle];
    //     [toformatter setTimeStyle:NSDateFormatterShortStyle];
    //     [toformatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];//设置目标时间字符串的格式
    //     NSString *targetTime = [toformatter stringFromDate:date];//将时间转化成目标时间字符串
    //     NSDate* toDate = [formatter dateFromString:targetTime];//将源时间字符串转化为NSDate
    return date;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
