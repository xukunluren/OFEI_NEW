//
//  DiyCellDetailDesc.h
//  OFei
//
//  Created by shou on 15/11/5.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiyCellDetailDesc : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;
@property (weak, nonatomic) IBOutlet UILabel *DetailInfor;
@property (weak, nonatomic) IBOutlet UILabel *DetailNumber;
@property (weak, nonatomic) IBOutlet UITextView *DetailText;

@end
