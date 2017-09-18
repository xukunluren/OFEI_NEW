
//
//  TyphoonPredictViewController.m
//  OFei
//
//  Created by admin on 15/10/31.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "TyphoonPredictViewController.h"

@interface TyphoonPredictViewController ()

@end

@implementation TyphoonPredictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"台风预警";
    [self setNavTitle:title];
    // Do any additional setup after loading the view.
}


-(void)setNavTitle:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = text;
    [label sizeToFit];
    
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
