//
//  BKNotificationUtilities.m
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BKNotificationUtilities.h"

NSString * const kNotificationAlertKey = @"kNotificationAlertKey";
NSString * const kFirstLaunchKey = @"kFirstLaunchKey";

@implementation BKNotificationUtilities

- (NSString*)notificationIdKey
{
    return kNotificationAlertKey;
}

- (NSString*)firstLaunchKey
{
    return kFirstLaunchKey;
}

- (NSString*)appName
{
    return [[[NSBundle mainBundle] localizedInfoDictionary]
            objectForKey:@"CFBundleDisplayName"];
}

@end
