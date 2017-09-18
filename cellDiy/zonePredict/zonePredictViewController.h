//
//  zonePredictViewController.h
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dock.h"

@protocol sendTitleDelegate <NSObject>

-(void)sendTitle:(NSString *)title;

@end
//typedef void(^returnTitleBlock)(NSString *title);
@interface zonePredictViewController : UIViewController

@property(nonatomic,retain) id <sendTitleDelegate> delegate;
//-(void)returnTitle:(returnTitleBlock)block;
@end
