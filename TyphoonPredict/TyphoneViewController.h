//
//  TyphoneViewController.h
//  OFei
//
//  Created by admin on 15/12/21.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TyphoneViewController : UIViewController<UIWebViewDelegate>
{
UIWebView *typhoneWeb;
}
@property(strong,nonatomic) UIWebView *typhoneWeb;
@end
