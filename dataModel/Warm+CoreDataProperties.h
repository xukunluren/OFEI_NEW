//
//  Warm+CoreDataProperties.h
//  OFei
//
//  Created by zey on 16/1/12.
//  Copyright © 2016年 xukun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Warm.h"

NS_ASSUME_NONNULL_BEGIN

@interface Warm (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
