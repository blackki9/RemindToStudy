//
//  CardNotificationScheduler.m
//  RemindToStudy
//
//  Created by black9 on 05/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardNotificationScheduler.h"
#import "NotificationCenter.h"
#import "Card.h"

@implementation CardNotificationScheduler

- (Card*)scheduleNotificationForCard:(Card*)card notificationDate:(NSDate*)date
{
    return [self setupNotificationForCard:card notificationDate:date];
}
- (Card*)setupNotificationForCard:(Card*)card notificationDate:(NSDate*)date
{
    Card* result = card;
    
    Notification* notification = [[NotificationCenter sharedCenter] newNotification];
    
    notification.fireDate = date;
    notification.text = [self notificationTextFromCard:result];
    
    result.notification = notification;
    
    [[NotificationCenter sharedCenter] scheduleNotification:notification];
    
    return result;
}

- (Card*)resheduleNotificationForCard:(Card*)card notificationDate:(NSDate*)date
{
    [[NotificationCenter sharedCenter] cancelNotification:card.notification];
    return [self setupNotificationForCard:card notificationDate:date];
}

- (NSString*)notificationTextFromCard:(Card*)card
{
    return [NSString stringWithFormat:@"Please repeat card %@",card.cardName];
}

@end
