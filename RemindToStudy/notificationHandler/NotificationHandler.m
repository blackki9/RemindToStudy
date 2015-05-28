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

<<<<<<< HEAD
@property (nonatomic, strong) UINavigationController* navigationController;
=======
@property (nonatomic, strong) UINavigationController* currentNavigationController;
>>>>>>> developer
@property (nonatomic, copy) NSString* currentNotificationId;
@end

@implementation NotificationHandler

- (void)setNavigationController:(UINavigationController*)navController
{
<<<<<<< HEAD
    self.navigationController = navController;
=======
    self.currentNavigationController = navController;
>>>>>>> developer
}

- (void)handleNotificationWithId:(NSString*)notificationId
{
<<<<<<< HEAD
    NSAssert(notificationId != nil, @"notification should be not nil");
=======
    NSAssert(notificationId != nil, @"notificationid should be not nil");
    
    [self.currentNavigationController popToRootViewControllerAnimated:YES];
    
>>>>>>> developer
    self.currentNotificationId = notificationId;
    [self sendNotificationToShowCardContent];
}

- (void)sendNotificationToShowCardContent
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCardHandlerNotification object:self userInfo:@{kCardHandlerNotificationIdKey:self.currentNotificationId}];
}

@end
