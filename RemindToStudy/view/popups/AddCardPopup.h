//
//  AddCardPopup.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MZFormSheetController.h>
#import "BaseCardPopup.h"
#import "CardAdder.h"

@protocol CardSaver;
@class GroupCard;

@interface AddCardPopup : BaseCardPopup <CardAdderDelegate>

@property (nonatomic,strong) id<CardAdder> adder;
@property (nonatomic, strong) id<CardSaver> saver; // should be passed here
@property (nonatomic, strong) GroupCard* groupCard;

- (void)updateUIWithCurrentAdder;

+ (AddCardPopup*)showAddPopupWithFinishHandler:(CardPopupResultAction)finishHandler passBlock:(CardPopupPassDataBlock)passBlock;

@end
