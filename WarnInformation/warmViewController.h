//
//  warmViewController.h
//  OFei
//
//  Created by admin on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface everycell : NSObject


@end

@protocol PassTitleDelegate <NSObject>

-(void)sendTitle:(NSString *)title;

@end


@interface warmViewController : UITableViewController
@property(nonatomic,retain) id <PassTitleDelegate> delegate;

@end
