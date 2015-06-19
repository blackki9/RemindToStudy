//
//  BKNotificationScheduler.h
//  RemindToStudy
//
//  Created by black9 on 30/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BKNotificationUtilities;

@interface BKNotificationScheduler : NSObject

- (instancetype)initWithNotificationUtilities:(BKNotificationUtilities*)utilities;

- (void)scheduleSingleNotificationOnDate:(NSDate*)fireDate message:(NSString*)message key:(NSString*)key userInfo:(NSDictionary*)userInfo;

@end
