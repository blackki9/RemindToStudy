//
//  AddGoalPopup.m
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

@interface AddCardPopup ()

@property (strong, nonatomic) IBOutlet UITextField *cardNameField;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation AddCardPopup


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - setup UI

- (void)updateUI
{
    [self.adder showAddUIInView:self.contentView];
}

#pragma mark - adding
- (IBAction)addCard:(id)sender {
    NSDictionary* cardInfo = [self.adder collectInfoWithDelegate:self];
    [self.adder addCardWithInfo:cardInfo delegate:self];
    if(self.finishHandler) {
        self.finishHandler(YES);
    }
    [self hidePopup];
}

#pragma mark - hiding
- (IBAction)cancel:(id)sender {
    self.finishHandler(NO);
    [self hidePopup];
}

- (void)hidePopup
{
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

#pragma mark - CardAdderDelegate

- (void)cardSubmittedWithInfo:(NSDictionary*)info class:(Class)cardClass
{
    Card* card = [CardsFactory cardForClass:cardClass info:info];
    [self.saver saveCard:card];
    [self.groupCard addCardsObject:card];
}

- (NSString*)cardName
{
    return self.cardNameField.text;
}

@end
