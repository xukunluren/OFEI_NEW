//
//  PointPredictViewController.h
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sendPointTitleDelegate <NSObject>

-(void)sendTitle:(NSString *)title;

@end



@interface PointPredictViewController : UIViewController
@property(nonatomic,assign) id <sendPointTitleDelegate> delegate;



@end
