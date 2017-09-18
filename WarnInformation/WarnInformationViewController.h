//
//  WarnInformationViewController.h
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sendWarmTitleDelegate <NSObject>

-(void)sendTitle:(NSString *)title;

@end




@interface WarnInformationViewController : UIViewController
@property(nonatomic,retain) id <sendWarmTitleDelegate> delegate;



@end
