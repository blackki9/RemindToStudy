//
//  Notification.h
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Notification : NSManagedObject

@property (nonatomic, retain) NSDate * fireDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * notificationId;
@property (nonatomic, retain) Card *card;

@end
