//
//  TyphoneViewController.m
//  OFei
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "TyphoneViewController.h"

@interface TyphoneViewController ()

@end

@implementation TyphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setbackImage];
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.wztf121.com/"];
    [self.view addSubview:web];
    self.typhoneWeb = web;
    [self.typhoneWeb loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)setbackImage
{
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
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
