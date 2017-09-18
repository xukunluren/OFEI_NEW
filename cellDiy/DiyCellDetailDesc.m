//
//  DiyCellDetailDesc.m
//  OFei
//
//  Created by shou on 15/11/5.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "DiyCellDetailDesc.h"

@implementation DiyCellDetailDesc

- (void)awakeFromNib {
    // Initialization code
    
    self.DetailImage.layer.cornerRadius = 5;
    self.DetailImage.layer.masksToBounds = YES;
    self.DetailImage.layer.borderWidth = 1.0;
    self.DetailImage.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//@interface DiyCellDetailDesc ()
//
//@end
//
//@implementation DiyCellDetailDesc
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
