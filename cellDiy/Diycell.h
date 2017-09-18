//
//  Diycell.h
//  dreamOnPhone
//
//  Created by admin on 15/9/3.
//  Copyright (c) 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Diycell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *logo;




@property (weak, nonatomic) IBOutlet UIButton *saomiao;
@end
