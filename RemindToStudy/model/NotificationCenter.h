//
//  NotificationCenter.h
//  RemindToStudy
//
//  Created by black9 on 27/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"
@import UIKit;

@class NotificationHandler;

//handle saving notifications and scheduling local notifications

@interface NotificationCenter : NSObject

+ (instancetype)sharedCenter;

- (Notification*)newNotification;
- (void)setNotificationHandler:(NotificationHandler*)handler;

- (void)initializeWithApplication:(UIApplication*)application;

- (void)didReceiveLocalNotification:(UILocalNotification*)localNotification;

- (void)scheduleNotification:(Notification*)notification;

- (void)cancelNotification:(Notification*)notification;
- (void)cancelAll;

- (void)save;

@end
