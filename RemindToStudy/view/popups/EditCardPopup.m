//
//  EditCardPopup.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "EditCardPopup.h"
#import "BKTextFieldKeyboardHider.h"
#import <MZFormSheetController.h>

NSString* const editPopupStoryboardId = @"EditCardPopup";
const CGFloat editPopupWidth = 300;
const CGFloat editPopupHeight = 460;

@interface EditCardPopup ()

@property (strong, nonatomic) IBOutlet UITextField *cardName;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;

@property (nonatomic, strong) id<CardEditor> editor;
@property (nonatomic, strong) id<CardSaver> saver;
@property (nonatomic, strong) id<CardRemover> remover;

@property (nonatomic, strong) RemoveCardHandler currentRemoveHandler;

@end

@implementation EditCardPopup

+ (EditCardPopup*)showEditPopupWithFinishHandler:(CardPopupResultAction)finishBlock passBlock:(CardPopupPassDataBlock)passBlock
{
    return (EditCardPopup*)[super showPopupWithId:editPopupStoryboardId size:[self editPopupSize]
                                      finishBlock:finishBlock passDataBlock:passBlock];
}
+ (CGSize)editPopupSize
{
    return CGSizeMake(editPopupWidth, editPopupHeight);
}

- (void)setCardSaver:(id<CardSaver>)saver
{
    self.saver = saver;
}
- (void)setRemoveCardHandler:(RemoveCardHandler)handler
{
    self.currentRemoveHandler = handler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setDateButton:self.dateButton];
    [self updateDateButtonToCurrentDate];
    
    [self setupKeyboardHiderForTextField:self.cardName];
}

- (void)setupUIWithEditor:(id<CardEditor>)editor
{
    self.editor = editor;
    [self.editor setDelegate:self];
    [self.editor setupUIWithContentView:self.contentView];
}

- (IBAction)cancel:(id)sender {
    [self performFinishBlockWithResult:NO];
    [super hidePopup];
}

- (IBAction)save:(id)sender {
    [self.editor saveChanges];
    [self performFinishBlockWithResult:YES];
    [self hidePopup];
}

- (IBAction)deleteCard:(id)sender {
    [self.editor removeCard];
}

- (IBAction)notificationDatePopupShow:(id)sender {
    [self showDateScreen];
}
#pragma mark - card editor delegate
- (NSDictionary*)collectedInfoForCard
{
    NSDictionary* dictionary = @{@"cardName":self.cardName.text,
                                 @"fireDate:":self.selectedDate};
    
    return dictionary;
}

- (void)saveCard:(Card*)card
{
    [self.saver saveCard:card];
}

- (void)setUpWithName:(NSString*)cardName fireDate:(NSDate*)fireDate
{
    self.cardName.text = cardName;
    self.selectedDate = fireDate;
    [self updateDateButton];
}

- (void)cardRemoved
{
    self.currentRemoveHandler();
    [self.saver saveCard:nil];
    [self hidePopup];
}

@end
