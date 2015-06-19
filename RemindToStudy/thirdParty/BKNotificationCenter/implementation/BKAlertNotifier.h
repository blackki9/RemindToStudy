//
//  BKAlertNotifier.h
//  BKNotificationCenter
//
//  Created by black9 on 01/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"
@import UIKit;
@class BKNotificationUtilities;

@interface BKAlertNotifier : NSObject <UIAlertViewDelegate>

- (instancetype)initWithUtilities:(BKNotificationUtilities*)utilities;

- (void)showAlertIfSharedAppIsActiveForLocalNotification:(UILocalNotification*)localNotification;

- (void)setCompletitionHandler:(CompletionAlertBlock)finishBlock;
- (void)setButtonTitles:(NSArray*)titles;

@end
