//
//  BKNotificationRefresher.h
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKNotificationRefresher : NSObject

- (void)refreshNotifications;
- (void)checkForOverdueNotifications;

@end
