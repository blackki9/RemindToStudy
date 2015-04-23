//
//  AddGoalPopup.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MZFormSheetController.h>

@protocol CardAdder;
@protocol CardAdderDelegate;
@protocol CardSaver;
@class GroupCard;

typedef void (^CardAddFinishHandler) (BOOL result);

@interface AddCardPopup : MZFormSheetController <CardAdderDelegate>

@property (nonatomic,strong) id<CardAdder> adder;
@property (nonatomic, strong) id<CardSaver> saver; // should be passed here
@property (nonatomic, strong) GroupCard* groupCard;
@property (nonatomic, strong) CardAddFinishHandler finishHandler;
- (void)updateUIWithCurrentAdder;

@end
