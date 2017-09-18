//
//  RoutesPredictViewController.h
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendRoutesTitleDelegate <NSObject>

-(void)sendTitle:(NSString *)title;

@end


@interface RoutesPredictViewController : UIViewController
@property(nonatomic,retain) id <sendRoutesTitleDelegate> delegate;

@end
