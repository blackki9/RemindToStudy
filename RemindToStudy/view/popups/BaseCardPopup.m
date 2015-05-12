//
//  BaseCardPopup.m
//  RemindToStudy
//
//  Created by black9 on 05/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "BaseCardPopup.h"
#import <MZFormSheetController.h>
#import "BKTextFieldKeyboardHider.h"
#import <NSDate+DateTools.h>
#import "SetNotificationDatePopup.h"

@interface BaseCardPopup ()

@property (nonatomic, strong) CardPopupResultAction currentFinishBlock;
@property (nonatomic, strong) BKTextFieldKeyboardHider* keyboardHider;
@property (nonatomic, strong) UIButton* currentDateButton;
@property (nonatomic, strong) CardNotificationScheduler* scheduler;
@property (nonatomic, strong) SetNotificationDatePopup* datePopup;

@end

@implementation BaseCardPopup

+ (UIViewController*)showPopupWithId:(NSString*)storyboardId size:(CGSize)popupSize finishBlock:(CardPopupResultAction)finishBlock passDataBlock:(CardPopupPassDataBlock)passBlock
{
    BaseCardPopup * viewController = (BaseCardPopup*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:storyboardId];
    [viewController setFinishBlock:finishBlock];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:popupSize
                                                                    viewController:viewController];
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        passBlock(presentedFSViewController);
    };
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    [formSheet presentAnimated:YES completionHandler:nil];
    
    return viewController;
}
- (void)setFinishBlock:(CardPopupResultAction)finishBlock
{
    _currentFinishBlock = finishBlock;
}
- (void)performFinishBlockWithResult:(BOOL)result
{
    self.currentFinishBlock(result);
}

- (void)hidePopup
{
    [self.datePopup hidePopup];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

- (void)setNotificationScheduler:(CardNotificationScheduler*)scheduler
{
    self.scheduler = scheduler;
}
- (Card*)scheduleNotificationForCard:(Card*)card notificationDate:(NSDate *)date
{
    return [self.scheduler scheduleNotificationForCard:card notificationDate:date];
}
- (void)showDateScreen
{
    __weak BaseCardPopup* weakSelf = self;
    self.datePopup = [SetNotificationDatePopup showPopupWithCompletion:^(NSDate *selectedDate) {
        [weakSelf setSelectedDate:selectedDate];
        [weakSelf updateDateButton];
    }];
}

- (void)setDateButton:(UIButton*)dateButton
{
    self.currentDateButton = dateButton;
}

- (UITextField*)setupKeyboardHiderForTextField:(UITextField*)textField
{
    self.keyboardHider = [[BKTextFieldKeyboardHider alloc] init];
    
    textField = [self.keyboardHider addHidingKeyboardOnReturnAndSetDelegateForTextField:textField];

    return textField;
}

- (void)updateDateButtonToCurrentDate
{
    self.selectedDate = [NSDate date];
    [self updateDateButton];
}

- (void)updateDateButton
{
    NSString* dateString = [NSString stringWithFormat:@"Remind date: %@",[self.selectedDate formattedDateWithFormat:@"dd/MM/yyyy hh:mm"]];
    [self.currentDateButton setTitle:dateString forState:UIControlStateNormal];
}

@end
