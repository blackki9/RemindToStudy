//
//  BKNotificationCenterImp.h
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"

@import UIKit;

@interface BKNotificationCenterImp : NSObject <UIAlertViewDelegate>

+ (instancetype)sharedCenter;

- (void)cancelNotificationByKey:(NSString*)key;
- (void)cancelAllNotifications;

- (void)initializeCenterWithApplication:(UIApplication*)application;
- (void)didReceiveLocalNotification:(UILocalNotification*)localNotification;

- (void)scheduleSingleNotificationOnDate:(NSDate*)fireDate message:(NSString*)message key:(NSString*)key;
- (void)scheduleSingleNotificationOnDate:(NSDate*)fireDate message:(NSString*)message key:(NSString*)key userInfo:(NSDictionary*)userInfo;

- (void)setCompletitionHandler:(CompletionAlertBlock)finishBlock;
- (void)setActionAfterOpenApp:(CompletionAfterOpenAppFromNotification)afterOpenFinishBlock;

- (void)setButtonTitles:(NSArray*)titles;

@end
