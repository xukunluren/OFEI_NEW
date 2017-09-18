//
//  warmDetail.m
//  OFei
//
//  Created by admin on 15/12/16.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "warmDetail.h"
#import "warmOfeiViewController.h"
#import "LxFTPRequest.h"
#import "JGProgressHUD.h"
#import "JGProgressHUDPieIndicatorView.h"

static NSString * const FTP_ADDRESS = @"ftp://ftp.dhybzx.org/%EA%B1%B7%C9%D4%A4%BE%AF%B1%A8/%BA%A3%C0%CB%BE%AF%B1%A8/";
static NSString * const USERNAME = @"ybs";
static NSString * const PASSWORD = @"56637190";


//ftp://ftp.dhybzx.org/%EA%B1%B7%C9%D4%A4%BE%AF%B1%A8/%BA%A3%C0%CB%BE%AF%B1%A8/002%25EA%25B1%25B7%25C9%25BA%25A3%25C0%25CB%25B6%25FE%25BC%25B6%25B3%25C8%25C9%25AB15070916.doc
//ftp://ftp.dhybzx.org/%EA%B1%B7%C9%D4%A4%BE%AF%B1%A8/%BA%A3%C0%CB%BE%AF%B1%A8/002%EA%B1%B7%C9%BA%A3%C0%CB%B6%FE%BC%B6%B3%C8%C9%AB15070916.doc

@interface warmDetail ()<SendUrlDelegate>

@end

@implementation warmDetail
{
    NSString *_localPath;
    JGProgressHUD * _progressHUD;
    NSURL *_title;
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
    NSLog(@"nihao%@ ===== %@",self.url,_title);
   
    //显示主背景颜色
    self.tabBarController.tabBar.hidden = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
   
    
    //设置背景为白色
    self.view.backgroundColor = [UIColor whiteColor];
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
   
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width, self.view.frame.size.height*0.9)];
    [self.view addSubview:webView];
    [webView setDataDetectorTypes:UIDataDetectorTypeAll];
    self.webView = webView;
     [self setButton];
    [self downFromFTP];

}

-(void)sendTitle:(NSURL *)title andName:(NSString *)name
{
    NSLog(@"yyyyy%@",title);
    NSLog(@"此时的标题:%@",name);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.04, self.view.frame.size.width*0.6, self.view.frame.size.height*0.2)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = name;

    self.url = title;
    _title = title;
}

-(void)setButton
{
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    
    self.navigationItem.leftBarButtonItem = left;
    

    
}

//返回按钮
- (void)backTo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString  *path1 = NSHomeDirectory();
    NSLog(@"path:%@",path1);
    NSURL *url = [[NSURL fileURLWithPath:NSHomeDirectory()]  URLByAppendingPathComponent:@"Documents/你好222.doc"];
    [fileManager removeItemAtURL:url error:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downFromFTP
{
    NSLog(@"%@",self.url);
    NSLog(@"%@",_title);
    typeof(self) __weak weakSelf = self;
    LxFTPRequest * request = [LxFTPRequest downloadRequest];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FTP_ADDRESS,@"039%EA%B1%B7%C9%BA%A3%C0%CB%CB%C4%BC%B6%C0%B6%C9%AB15092916.doc"]];
    request.serverURL = self.url;
    request.localFileURL = [[NSURL fileURLWithPath:NSHomeDirectory()]  URLByAppendingPathComponent:@"Documents/你好222.doc"];
    request.username = USERNAME;
    request.password = PASSWORD;
    request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
        
//        NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent);
        
        totalSize = MAX(totalSize, finishedSize);
        
        _progressHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
    };
    request.successAction = ^(Class resultClass, id result) {
        
        [_progressHUD dismissAnimated:YES];
        
        typeof(weakSelf) __strong strongSelf = weakSelf;
        
        NSLog(@"%@",result);
        [strongSelf showMessage:result];
        
        
        //用于显示文档
        NSString  *path1 = NSHomeDirectory();
        NSLog(@"path:%@",path1);
        NSURL *url = [[NSURL fileURLWithPath:NSHomeDirectory()]  URLByAppendingPathComponent:@"Documents/你好222.doc"];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"text.pdf" ofType:nil];
//        NSURL *url = [NSURL fileURLWithPath:path];
//        NSLog(@"url:%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSLog(@"request:%@",request);
        self.webView.scalesPageToFit=YES;
        
        [self.webView loadRequest:request];
        
    };
    request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
        
        [_progressHUD dismissAnimated:YES];
//        NSLog(@"domain = %ld, error = %ld, errorMessage = %@", domain, error, errorMessage);    //
    };
    [request start];
    
    _progressHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    _progressHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
    _progressHUD.progress = 0;
    
    typeof(weakSelf) __strong strongSelf = weakSelf;
    [_progressHUD showInView:strongSelf.view animated:YES];
    

}

- (void)showMessage:(NSString *)message
{
//    NSLog(@"message = %@", message);//
    
    JGProgressHUD * hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    hud.indicatorView = nil;
    hud.textLabel.text = message;
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:3];
}



-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
    [webView loadRequest:request];
    
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
