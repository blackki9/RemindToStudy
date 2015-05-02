//
//  NotificationCenter.m
//  RemindToStudy
//
//  Created by black9 on 27/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "NotificationCenter.h"
#import "BKNotificationCenter.h"
#import "DBManager.h"
#import "NotificationHandler.h"

@interface NotificationCenter()

@property (nonatomic,strong) NotificationHandler* currentNotificationHandler;

@end

@implementation NotificationCenter

+ (instancetype)sharedCenter
{
    static dispatch_once_t onceToken;
    static id sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)setNotificationHandler:(NotificationHandler*)handler
{
    self.currentNotificationHandler = handler;
}

- (void)scheduleNotification:(Notification*)notification
{
    notification.notificationId = [self notificationIdForNotification:notification];
    [[BKNotificationCenterImp sharedCenter] cancelNotificationByKey:notification.notificationId];
    [[BKNotificationCenterImp sharedCenter] scheduleSingleNotificationOnDate:notification.fireDate message:notification.text key:notification.notificationId];
}

- (Notification*)newNotification
{
    return [Notification MR_createEntity];
}

- (NSString*)notificationIdForNotification:(Notification*)notification
{
    return [NSString stringWithFormat:@"%f_%@",notification.fireDate.timeIntervalSince1970,notification.text];
}

- (void)cancelNotification:(Notification*)notification
{
    [[BKNotificationCenterImp sharedCenter] cancelNotificationByKey:notification.notificationId];
}

- (void)cancelAll
{
    [[BKNotificationCenterImp sharedCenter] cancelAllNotifications];
}

- (void)save
{
    [[DBManager sharedManager] saveContext];
}

- (void)initializeWithApplication:(UIApplication*)application
{
    [[BKNotificationCenterImp sharedCenter] initializeCenterWithApplication:application];
    
    [self initButtonsForActions];
    [self initDefaultHandlerForAlertAction];
    [self initDefaultHandlerForOpenAppFromNotification];
}

- (void)initButtonsForActions
{
    [[BKNotificationCenterImp sharedCenter] setButtonTitles:@[@"Show card"]];
}

- (void)initDefaultHandlerForAlertAction
{
    __weak NotificationCenter* weakSelf = self;
    [[BKNotificationCenterImp sharedCenter] setCompletitionHandler:^(NSInteger buttonIndex, NSString *notificationId) {
        [weakSelf.currentNotificationHandler handleNotificationWithId:notificationId];
    }];
}

- (void)initDefaultHandlerForOpenAppFromNotification
{
    __weak NotificationCenter* weakSelf = self;
    [[BKNotificationCenterImp sharedCenter] setActionAfterOpenApp:^(NSString *notificationId) {
        [weakSelf.currentNotificationHandler handleNotificationWithId:notificationId];
    }];
}

- (void)didReceiveLocalNotification:(UILocalNotification*)localNotification
{
    [[BKNotificationCenterImp sharedCenter] didReceiveLocalNotification:localNotification];
}


@end
