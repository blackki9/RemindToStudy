//
//  NotificationHandler.m
//  RemindToStudy
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "NotificationHandler.h"
#import "Constants.h"

@interface NotificationHandler()

@property (nonatomic, strong) UINavigationController* navigationController;
@property (nonatomic, copy) NSString* currentNotificationId;
@end

@implementation NotificationHandler

- (void)setNavigationController:(UINavigationController*)navController
{
    self.navigationController = navController;
}

- (void)handleNotificationWithId:(NSString*)notificationId
{
    NSAssert(notificationId != nil, @"notification should be not nil");
    self.currentNotificationId = notificationId;
    [self sendNotificationToShowCardContent];
}

- (void)sendNotificationToShowCardContent
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCardHandlerNotification object:self userInfo:@{kCardHandlerNotificationIdKey:self.currentNotificationId}];
}

@end
