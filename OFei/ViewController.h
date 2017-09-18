//
//  ViewController.h
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol locationDelegate <NSObject>
@optional
-(void)location:(NSString *)title weather:(NSString *)weather temp:(NSString *)temp wind:(NSString *)wind windD:(NSString *)windD date:(NSString *)date pm:(NSString *)pm;

@end

@interface ViewController : UIViewController

@property(nonatomic,retain)AppDelegate* myAppDelegate;
@property(strong,nonatomic)UIImageView *imageView;

@property(strong,nonatomic)UITextField *name;

@property (retain,nonatomic) id <locationDelegate> delegate;
- (BOOL) connectedToNetwork;

@property(strong,nonatomic)NSArray *array;

@end

