//
//  CardNotificationScheduler.h
//  RemindToStudy
//
//  Created by black9 on 05/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

@interface CardNotificationScheduler : NSObject

- (Card*)scheduleNotificationForCard:(Card*)card notificationDate:(NSDate*)date;

@end
