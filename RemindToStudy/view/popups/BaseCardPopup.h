//
//  BaseCardPopup.h
//  RemindToStudy
//
//  Created by black9 on 05/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardNotificationScheduler.h"

@class Card;

typedef void (^CardPopupResultAction)(BOOL result);
typedef void (^CardPopupPassDataBlock) (UIViewController* controller);

@interface BaseCardPopup : UIViewController

@property (nonatomic,strong) NSDate* selectedDate;

+ (UIViewController*)showPopupWithId:(NSString*)storyboardId size:(CGSize)popupSize finishBlock:(CardPopupResultAction)finishBlock passDataBlock:(CardPopupPassDataBlock)passBlock;

- (void)setFinishBlock:(CardPopupResultAction)finishBlock;
- (void)performFinishBlockWithResult:(BOOL)result;
- (UITextField*)setupKeyboardHiderForTextField:(UITextField*)textField;

- (void)setDateButton:(UIButton*)dateButton;
- (void)updateDateButtonToCurrentDate;
- (void)updateDateButton;

- (void)setNotificationScheduler:(CardNotificationScheduler*)scheduler;
- (Card*)scheduleNotificationForCard:(Card*)card notificationDate:(NSDate *)date;
- (Card*)rescheduleNotificationForCard:(Card*)card notificationDate:(NSDate*)date;
- (void)showDateScreen;

- (void)hidePopup;

@end
