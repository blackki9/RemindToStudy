//
//  BKNotificationScheduler.m
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKNotificationScheduler.h"
@import UIKit;
#import "BKNotificationUtilities.h"

@interface BKNotificationScheduler()

@property (nonatomic,  strong) BKNotificationUtilities* utilities;

@end

@implementation BKNotificationScheduler

- (instancetype)initWithNotificationUtilities:(BKNotificationUtilities*)utilities
{
    if(self = [super init]) {
        _utilities = utilities;
    }
    
    return self;
}

- (void)scheduleSingleNotificationOnDate:(NSDate*)fireDate message:(NSString*)message key:(NSString*)key userInfo:(NSDictionary*)userInfo
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = fireDate;
    localNotification.alertBody = message;
    localNotification.alertTitle = [self.utilities appName];
    localNotification.userInfo = [self userInfoForLocalNotificationWithInfo:userInfo key:key];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (NSDictionary*)userInfoForLocalNotificationWithInfo:(NSDictionary*)info key:(NSString*)key
{
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    
    result[[self.utilities notificationIdKey]] = key;
    
    [result addEntriesFromDictionary:info];
    
    return result;
}


@end
