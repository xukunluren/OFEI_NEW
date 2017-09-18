//
//  warmOfeiViewController.h
//  OFei
//
//  Created by admin on 15/12/1.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol SendUrlDelegate <NSObject>

- (void)sendTitle:(NSURL *)title andName:(NSString *)name;

@end

@interface warmOfeiViewController : UIViewController
{
  AppDelegate *mydelegate;
}

@property(nonatomic,strong)AppDelegate *mydelegate;

@property(nonatomic,strong)UITableView *warmTable;
@property(nonatomic,retain) id <SendUrlDelegate> delegate;
@property(nonatomic,retain) NSString *lableText;
@property(nonatomic,assign) NSInteger *cellIndex;
@property(strong,nonatomic) __block NSMutableArray *nameArray;
@property (strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)  NSMutableArray *dateArray;


@end
