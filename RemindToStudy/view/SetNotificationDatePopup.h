//
//  SetNotificationDatePopup.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NotificationSetCompletion) (NSDate* selectedDate);

@interface SetNotificationDatePopup : UIViewController

+ (SetNotificationDatePopup*)showPopupWithCompletion:(NotificationSetCompletion)finishBlock;
- (void)setCompletionBlock:(NotificationSetCompletion)finishBlock;
- (void)hidePopup;
@end
