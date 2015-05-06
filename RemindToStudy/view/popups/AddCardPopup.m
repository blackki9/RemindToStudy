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


NSString* const addPopupIdentifier = @"AddCardPopup";
const CGFloat addPopupWidth = 300.0f;
const CGFloat addPopupHeight = 400.0f;

@interface AddCardPopup ()

@property (strong, nonatomic) IBOutlet UITextField *cardNameField;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation AddCardPopup

+ (AddCardPopup*)showAddPopupWithFinishHandler:(CardPopupResultAction)finishHandler passBlock:(CardPopupPassDataBlock)passBlock
{
    return (AddCardPopup*)[super showPopupWithId:addPopupIdentifier size:CGSizeMake(addPopupWidth,
                                                              addPopupHeight) finishBlock:finishHandler passDataBlock:passBlock];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super setDateButton:self.dateButton];
    [self updateDateButtonToCurrentDate];
    
    [self setupKeyboardHiderForTextField:self.cardNameField];
}

- (IBAction)setNotificationDate:(id)sender
{
    [self showDateScreen];
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
   
    [super performFinishBlockWithResult:YES];
    [super hidePopup];
}

#pragma mark - hiding
- (IBAction)cancel:(id)sender
{
    [super performFinishBlockWithResult:NO];

    [super hidePopup];
}

#pragma mark - CardAdderDelegate

- (void)cardSubmitted:(Card*)card
{
    card = [self scheduleNotificationForCard:card notificationDate:self.selectedDate];
    [self.saver saveCard:card];
    [self.groupCard addCardsObject:card];
}

- (NSString*)cardName
{
    return self.cardNameField.text;
}

@end
