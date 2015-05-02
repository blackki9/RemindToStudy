//
//  NotificationHandler.h
//  RemindToStudy
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class Notification;
@interface NotificationHandler : NSObject

- (void)setNavigationController:(UINavigationController*)navController;

- (void)handleNotificationWithId:(NSString*)notificationId;

@end
