//
//  dataAnaly.h
//  OFei
//
//  Created by admin on 15/12/8.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface dataAnaly : NSObject

-(NSString *)judgeWindPower:(NSNumber *)number;
-(NSString *)judgeDirectionPower:(NSNumber *)str;
-(NSString *)stringForAnaly:(NSString *)string;
-(NSString *)directionOfTu:(NSArray *)array recordIndex:(NSUInteger)index;

@end
