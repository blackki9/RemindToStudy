//
//  AddCardPopup.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "AddCardPopup.h"
#import "CardAdder.h"
#import "CardSaver.h"
#import "CardsFactory.h"
#import "GroupCard.h"
#import "SetNotificationDatePopup.h"
#import <NSDate+DateTools.h>
#import "NotificationCenter.h"
#import "BKTextFieldKeyboardHider.h"

NSString* const addPopupIdentifier = @"AddCardPopup";
const CGFloat addPopupWidth = 300.0f;
const CGFloat addPopupHeight = 400.0f;

@interface AddCardPopup ()

@property (strong, nonatomic) IBOutlet UITextField *cardNameField;
@property (strong,nonatomic) NSDate* selectedDate;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) BKTextFieldKeyboardHider* keyboardHider;

@end

@implementation AddCardPopup

+ (AddCardPopup*)showAddPopupWithFinishHandler:(CardAddFinishHandler)finishHandler passBlock:(PassBlock)passBlock
{
    AddCardPopup * viewController = (AddCardPopup*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:addPopupIdentifier];
    viewController.finishHandler = finishHandler;
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:CGSizeMake(addPopupWidth,
                                                                                              addPopupHeight)
                                                                    viewController:viewController];
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        passBlock(presentedFSViewController);
    };
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    [formSheet presentAnimated:YES completionHandler:nil];
    
    return viewController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupKeyboardHider];
    [self updateDateButtonToCurrentDate];
}

- (void)setupKeyboardHider
{
    self.keyboardHider = [[BKTextFieldKeyboardHider alloc] init];
    
    self.cardNameField = [self.keyboardHider addHidingKeyboardOnReturnAndSetDelegateForTextField:self.cardNameField];
}

- (void)updateDateButtonToCurrentDate
{
    self.selectedDate = [NSDate date];
    [self updateDateButton];
}

- (void)updateDateButton
{
    NSString* dateString = [NSString stringWithFormat:@"Remind date: %@",[self.selectedDate formattedDateWithFormat:@"dd/MM/yyyy hh:mm"]];
    [self.dateButton setTitle:dateString forState:UIControlStateNormal];
}

- (IBAction)setNotificationDate:(id)sender
{
    __weak AddCardPopup* weakSelf = self;
    [SetNotificationDatePopup showPopupWithCompletion:^(NSDate *selectedDate) {
        NSLog(@"");
        weakSelf.selectedDate = selectedDate;
        [weakSelf updateDateButton];
    }];
}

#pragma mark - setup UI

- (void)updateUIWithCurrentAdder
{
    [self.adder showAddUIInView:self.contentView];
}

#pragma mark - adding
- (IBAction)addCard:(id)sender
{
    NSDictionary* cardInfo = [self.adder collectInfoWithDelegate:self];
    [self.adder addCardWithInfo:cardInfo delegate:self];
    if(self.finishHandler) {
        self.finishHandler(YES);
    }
    [self hidePopup];
}

#pragma mark - hiding
- (IBAction)cancel:(id)sender
{
    if(self.finishHandler) {
        self.finishHandler(NO);
    }

    [self hidePopup];
}

- (void)hidePopup
{
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

#pragma mark - CardAdderDelegate

- (void)cardSubmitted:(Card*)card
{
    card = [self setupNotificationForCard:card];
    [self.saver saveCard:card];
    [self.groupCard addCardsObject:card];
}

- (Card*)setupNotificationForCard:(Card*)card
{
    Card* result = card;
    
    Notification* notification = [[NotificationCenter sharedCenter] newNotification];
    
    notification.fireDate = self.selectedDate;
    notification.text = [self notificationTextFromCard:result];
    
    result.notification = notification;
    
    [[NotificationCenter sharedCenter] scheduleNotification:notification];
    
    return result;
}

- (NSString*)notificationTextFromCard:(Card*)card
{
    return [NSString stringWithFormat:@"Please repeat card %@",card.cardName];
}

- (NSString*)cardName
{
    return self.cardNameField.text;
}

@end
