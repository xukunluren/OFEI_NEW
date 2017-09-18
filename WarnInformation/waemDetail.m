//
//  waemDetail.m
//  OFei
//
//  Created by admin on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "waemDetail.h"
#import "UIScrollView+PullToRefreshCoreText.h"
//#import "DiyCellDetailDesc.h"
#import "WarnInformationViewController.h"
#import "warmViewController.h"


#define XTo 10.0
#define YTo 50.0



@interface waemDetail ()<PassTitleDelegate>

@end

@implementation waemDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示主背景颜色
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor purpleColor];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem.title=@"返回";
    [self setpageView];
    //设置背景为白色
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}


#pragma 委托代理传值实现方法
- (void)sendTitle:(NSString *)title
{
    
    NSLog(@"%@xixi",title);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = title;
    [label sizeToFit];
    
    
}

-(void)setpageView
{
    
#pragma mark -定义格式
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    
#pragma mark - 预报等级图片
    UIImageView *pic = [[UIImageView alloc]init];
    pic.image = [UIImage imageNamed:@"预警等级"];
    pic.frame = CGRectMake(0.12*width, 0.16*height, 0.06*width, 0.06*width);
    [pic setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:pic];
    
#pragma mark -XX海雾预警
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(0.27*width,0.108*height,width*0.4,height*0.14)];
    lable.text = @"XXX海雾预警";
    lable.backgroundColor = [UIColor whiteColor];
    lable.textColor = [UIColor redColor];
    //字体显示举中
    //lable.textAlignment = UITextAlignmentCenter;
    //自动折行设置
    //lable.lineBreakMode = UILineBreakModeCharacterWrap;
    lable.numberOfLines = 0;
    //设置字体
    //lable.font=[UIFont fontWithName:@"Helvetica" size:20];
    //设置阴影的颜色
    // lable.shadowColor = [UIColor blackColor];
    [self.view addSubview:lable];
    
#pragma mark -编号
    //UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(240,100,300,40)];
    UILabel *No = [[UILabel alloc]initWithFrame:CGRectMake(0.6*width,0.19*height,0.2*width,0.06*height)];
    No.text = @"编号：";
    No.backgroundColor = [UIColor whiteColor];
    No.textColor = [UIColor blackColor];
    No.font=[UIFont fontWithName:@"Helvetica" size:10];
    [self.view addSubview:No];
    
#pragma mark -XXX XXX XXX
    //UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(240,100,300,40)];
    UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake(0.7*width,0.19*height,0.68*width,0.06*height)];
    num.text = @"XXX XXX XXX";
    num.backgroundColor = [UIColor whiteColor];
    num.textColor = [UIColor blackColor];
    num.font=[UIFont fontWithName:@"Helvetica" size:12];
    [self.view addSubview:num];
    
#pragma mark -横线
    UIImageView *line = [[UIImageView alloc]init];
    line.image = [UIImage imageNamed:@"横线"];
    //line.frame = CGRectMake(0,130,500,1);
    line.frame = CGRectMake(0.03*width,0.25*height,0.94*width,1.6);
    [line setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:line];
    
#pragma mark - 预警提醒内容
    //UILabel *context = [[UILabel alloc]initWithFrame:CGRectMake(30,150,320,600)];
    UILabel *context = [[UILabel alloc]initWithFrame:CGRectMake(width*0.1,height*0.27,width*0.8,height*0.6)];
    context.text = @"2小时内可能出现能见度小于50米的雾，或者已经出现能见度小于50米的雾并将持续。";
    //设置自动换行
    context.numberOfLines = 3;
    //lable自适应大小
    [context sizeToFit];
    context.backgroundColor = [UIColor whiteColor];
    context.textColor = [UIColor blackColor];
    context.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [self.view addSubview:context];
    
#pragma mark -东海预报中心发布
    //UILabel *center = [[UILabel alloc]initWithFrame:CGRectMake(240,500,300,40)];
    UILabel *center = [[UILabel alloc]initWithFrame:CGRectMake(width*0.6,0.76*height,width*0.4,height*0.06)];
    center.text = @"东海预报中心发布";
    center.backgroundColor = [UIColor whiteColor];
    center.textColor = [UIColor blackColor];
    center.font=[UIFont fontWithName:@"Helvetica" size:12];
    [self.view addSubview:center];
    
#pragma mark -年月份
//    UILabel *year = [[UILabel alloc]initWithFrame:CGRectMake(210,540,300,40)];
    UILabel *year = [[UILabel alloc]initWithFrame:CGRectMake(width*0.54,height*0.81,width*0.4,height*0.06)];
    year.text = @"2015年10月9号";
    year.backgroundColor = [UIColor whiteColor];
    year.textColor = [UIColor blackColor];
    year.font=[UIFont fontWithName:@"Helvetica" size:12];
    [self.view addSubview:year];
    
#pragma mark -时间
    //UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(320,540,300,40)];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(width*0.84,height*0.81,width*0.4,height*0.06)];
    time.text = @"9时";
    time.backgroundColor = [UIColor whiteColor];
    time.textColor = [UIColor blackColor];
    time.font=[UIFont fontWithName:@"Helvetica" size:12];
    [self.view addSubview:time];
    
    
    

    
    
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
