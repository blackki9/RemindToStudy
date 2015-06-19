//
//  BKNotificationCanceler.m
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKNotificationCanceler.h"
@import UIKit;

@interface BKNotificationCanceler ()

@property (nonatomic,copy) NSString* notificationKey;

@end

@implementation BKNotificationCanceler

- (instancetype)initWithNotificationKey:(NSString*)key
{
    if(self = [super init]) {
        _notificationKey = [key copy];
    }
    
    return self;
}

- (void)cancelNotificationByKey:(NSString*)key
{
    UILocalNotification* localNotification = [self localNotificationWithKey:key];
    if(localNotification) {
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    }
}

- (void)cancelAllNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


- (UILocalNotification*)localNotificationWithKey:(NSString*)key
{
    for(UILocalNotification* localNotification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([localNotification.userInfo[self.notificationKey] isEqualToString:key]) {
            return localNotification;
        }
    }
    
    return nil;
}

@end
