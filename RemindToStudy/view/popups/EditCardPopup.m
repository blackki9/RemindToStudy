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

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setDateButton:self.dateButton];
    [self updateDateButtonToCurrentDate];
    
    [self setupKeyboardHiderForTextField:self.cardName];
}

- (void)setupUIWithEditor:(id<CardEditor>)editor
{
    self.editor = editor;
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

@end
