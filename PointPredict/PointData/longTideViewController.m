//
//  longTideViewController.m
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "longTideViewController.h"
#import "CustomTableView.h"
#import "OFeiCommon.h"
#import "fiveTableViewCell.h"
#import "PellTableViewSelect.h"
#import "NormalViewController.h"

@interface longTideViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation longTideViewController

{
    NSString *_title;
    UILabel *_titleLabel;
    NSMutableArray *_dateArray;
    
    NSMutableArray *_arrCount;
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
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];

    _longTideTable = [[UITableView alloc] initWithFrame:CGRectMake(0,66,KWight,KHight- 115) style:UITableViewStylePlain];
    _longTideTable.layer.cornerRadius = 10;
    _longTideTable.layer.masksToBounds = YES;
    _longTideTable.alpha = 0.5;
    [_longTideTable setDelegate:self];
    [_longTideTable setDataSource:self];
    [self.view addSubview:_longTideTable];
    
    _dateArray = [[NSMutableArray alloc] init];
    _arrCount = [[NSMutableArray alloc]init];
    
    _title = @"A点";
    self.tabBarController.tabBar.hidden = NO;
    [self setButton];
    [self setNavTitle:_title];
    [self getArrayCount];
    
}


//- (void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = YES;
//    
//}
-(void)setNavTitle:(NSString *)title
{

    
//    UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
//    select.frame = CGRectMake(15, 0, 40, 40);
//    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
//    [select addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.frame = CGRectMake(0, 10, 40, 40);
//    label.font = [UIFont boldSystemFontOfSize:16.0];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor]; // change this color
//    _titleLabel = label;
//    _titleLabel.text = _title;
//    [_titleLabel sizeToFit];
//    [middle addSubview:select];
//    [middle addSubview:label];
//    
//    [label sizeToFit];
//    self.navigationItem.titleView = middle;
    
    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(0, 0, 60, 40);
    _titleLabel.text = _title;
    [select setTitle:_title forState:UIControlStateNormal];
    select.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0,  0);
    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
    select.imageEdgeInsets = UIEdgeInsetsMake(0,  0, 0, -60);
    [select addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = select;
}

-(void)setButton
{
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
//    [exampleButton1 addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
//    self.navigationItem.rightBarButtonItem = right;

}

- (void)backHome
{
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
    self.tabBarController.tabBar.hidden = NO;
}

//- (void)viewWillDisappear:(BOOL)animated
//{}


//返回
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)selectPoint
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.4, 64, 100, 190) selectData:@[@"A点",@"B点",@"C点",@"D点"] action:^(NSInteger index) {
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A点";
        }
        if (index == 1) {
            _title = @"B点";
        }
        if (index == 2) {
            _title = @"C点";
        }
        if (index == 3) {
            _title = @"D点";
        }
        [self viewDidAppear:YES];
        NSLog(@"%@",_title);
        [self setNavTitle:_title];
        [self.longTideTable reloadData];
        [self judgePoint:_point];
    } animated:YES];
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewaa = [[UIView alloc] init];
    viewaa.backgroundColor =KTextColor;
    
    CGFloat wight = self.view.frame.size.width;
    
//    UILabel *longTide = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wight, 30)];
//    [longTide setText:@"长期潮位表"];
//    [longTide setFont:[UIFont systemFontOfSize:14.0]];
//    [longTide setTextAlignment:NSTextAlignmentCenter];
//    [viewaa addSubview:longTide];
//    
    UILabel *datelabel = [[UILabel alloc] initWithFrame:CGRectMake(0,KHight*0.03, 0.3*wight, 20)];
    [datelabel setText:@"日期"];
    [datelabel setFont:[UIFont systemFontOfSize:12.0]];
    [datelabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:datelabel];
    
    //添加表格第一行日期、数据等信息
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.3*wight, self.view.frame.size.height*0.01, 0.35*wight, 20)];
    [dateLabel setText:@"高潮(cm)"];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0]];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:dateLabel];
    
    UILabel *chaoshi1 = [[UILabel alloc] initWithFrame:CGRectMake(0.3*wight, self.view.frame.size.height*0.05, 0.175*wight, 20)];
    [chaoshi1 setText:@"潮时"];
    [chaoshi1 setFont:[UIFont systemFontOfSize:12.0]];
    [chaoshi1 setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:chaoshi1];
    
    UILabel *chaowei1 = [[UILabel alloc] initWithFrame:CGRectMake(0.45*wight, self.view.frame.size.height*0.05, 0.175*wight, 20)];
    [chaowei1 setText:@"潮位"];
    [chaowei1 setFont:[UIFont systemFontOfSize:12.0]];
    [chaowei1 setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:chaowei1];
    
    UILabel *fensuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.65*wight, self.view.frame.size.height*0.01, 0.35*wight, 20)];
    [fensuLabel setText:@"低潮（cm）"];
    [fensuLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fensuLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fensuLabel];
    
    UILabel *chaoshi2 = [[UILabel alloc] initWithFrame:CGRectMake(0.65*wight, self.view.frame.size.height*0.05, 0.175*wight, 20)];
    [chaoshi2 setText:@"潮时"];
    [chaoshi2 setFont:[UIFont systemFontOfSize:12.0]];
    [chaoshi2 setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:chaoshi2];
    
    UILabel *chaowei2 = [[UILabel alloc] initWithFrame:CGRectMake(0.8*wight, self.view.frame.size.height*0.05, 0.175*wight, 20)];
    [chaowei2 setText:@"潮位"];
    [chaowei2 setFont:[UIFont systemFontOfSize:12.0]];
    [chaowei2 setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:chaowei2];
    
    return viewaa;
    
}




//得到数组的长度
-(void)getArrayCount{
    
    NSURL *url = [self judgePoint:_title];
    NSLog(@"url是===%@",url);
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    _arrCount = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
//    [_datetimeArray removeAllObjects];
    
    
}





- (void)configureCell:(fiveTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"标题是===%@",_title);
    NSURL *url = [self judgePoint:_title];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        dateArray = [[NSMutableArray alloc] init];
        NSMutableArray *tideHTime = [[NSMutableArray alloc] init];
        NSMutableArray *tideHPosition = [[NSMutableArray alloc] init];
        NSMutableArray *tideDTime = [[NSMutableArray alloc] init];
        NSMutableArray *tideDPosition = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            NSString *varName = [dic objectForKey:@"varname"];
            if ([varName isEqualToString:@"TIDEDOWN"]) {
                
                
                NSString *dateString1 = [dic objectForKey:@"datatime"];
                NSString *dateString = [self stringForAnaly:dateString1].firstObject;
                NSString *time = [self stringForAnaly:dateString1].lastObject;
                NSNumber *tideD = [dic objectForKey:@"power"];
                CGFloat tide1 = [tideD doubleValue];
                NSString *tideDown = [NSString stringWithFormat:@"%.2f",tide1];
                
                [tideHPosition addObject:@" "];
                [tideHTime addObject:@" "];
                [_dateArray addObject:dateString];
                [tideDPosition addObject:tideDown];
                [tideDTime addObject:time];
                
                
            }else{
                NSString *dateString1 = [dic objectForKey:@"datatime"];
                NSString *dateString = [self stringForAnaly:dateString1].firstObject;
                NSString *time = [self stringForAnaly:dateString1].lastObject;
                NSNumber *tideH1 = [dic objectForKey:@"power"];
                NSString *tideH = tideH1.description;
                
                [tideDPosition addObject:@" "];
                [tideDTime addObject:@" "];
                [_dateArray addObject:dateString];
                [tideHPosition addObject:tideH];
                [tideHTime addObject:time];
        
            }
            
        }
        
        _dateArray = (NSMutableArray *)[[_dateArray reverseObjectEnumerator] allObjects];
        tideHPosition =(NSMutableArray *)[[tideHPosition reverseObjectEnumerator] allObjects];
        tideDPosition =(NSMutableArray *)[[tideDPosition reverseObjectEnumerator] allObjects];
        tideHTime = (NSMutableArray *) [[tideHTime reverseObjectEnumerator] allObjects];
        tideDTime = (NSMutableArray *) [[tideDTime reverseObjectEnumerator] allObjects];
          NSLog(@"ceshi数据大小是多少：%lu",(unsigned long)tideHTime.count);
        
        cell.data1.text = _dateArray[indexPath.row];
        cell.data2.text = tideHTime[indexPath.row];
        cell.data3.text = tideHPosition[indexPath.row];
        
        cell.data4.text = tideDTime[indexPath.row];
        cell.data5.text = tideDPosition[indexPath.row];
        
    }];

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return self.view.frame.size.height*0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


//显示条数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrCount.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    fiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"fiveTableViewCell" owner:self options:nil] lastObject];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}



#pragma 字符串的分割
-(NSArray *)stringForAnaly:(NSString *)string
{
    NSString *dateString1 = string;
    NSString *dateString2 = [dateString1 substringFromIndex:5];//截取下标5之后的字符串
    NSString *dateString3 = [dateString2 substringToIndex:11];//截取下标2之前的字符串
    NSArray *array1 = [dateString3 componentsSeparatedByString:@"-"]; //
    NSArray *array2 = [array1.lastObject componentsSeparatedByString:@" "];
    NSString *yue = @"月";
    NSString *shi = @"时";
    NSString *ri = @"日";
    NSString *dateString = [NSString stringWithFormat:@"%@%@%@%@",array1.firstObject,yue,array2.firstObject,ri];
    NSString *tideTime = [NSString stringWithFormat:@"%@%@", array2.lastObject,shi];
    NSArray *array = [NSArray arrayWithObjects:dateString,tideTime, nil];
    return array;
}
-(NSURL *)judgePoint:(NSString *)point
{
    NSURL *url;
    if ([point isEqualToString:@"A点"]) {
        url= [NSURL URLWithString:@KPointLTideA_M];
    }
    if ([point isEqualToString:@"B点"]) {
        url= [NSURL URLWithString:@KPointLTideB_M];
    }
    if ([point isEqualToString:@"C点"]) {
        url= [NSURL URLWithString:@KPointLTideC_M];
    }
    if ([point isEqualToString:@"D点"]) {
        url= [NSURL URLWithString:@KPointLTideD_M];
    }
    return url;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
