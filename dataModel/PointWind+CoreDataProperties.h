//
//  PointWind+CoreDataProperties.h
//  OFei
//
//  Created by admin on 15/11/19.
//  Copyright © 2015年 xukun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PointWind.h"

NS_ASSUME_NONNULL_BEGIN

@interface PointWind (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *winddirection;
@property (nullable, nonatomic, retain) NSString *windpoint;
@property (nullable, nonatomic, retain) NSString *windpower;
@property (nullable, nonatomic, retain) NSString *windspeed;

@end

NS_ASSUME_NONNULL_END
