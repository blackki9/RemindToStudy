//
//  EditCardPopup.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardEditor.h"
#import "BaseCardPopup.h"
#import "CardSaver.h"
#import "CardRemover.h"

typedef void (^RemoveCardHandler) ();

@interface EditCardPopup : BaseCardPopup <CardEditorDelegate>

+ (EditCardPopup*)showEditPopupWithFinishHandler:(CardPopupResultAction)finishBlock passBlock:(CardPopupPassDataBlock)passBlock;

- (void)setupUIWithEditor:(id<CardEditor>)editor;
- (void)setCardSaver:(id<CardSaver>)saver;
- (void)setRemoveCardHandler:(RemoveCardHandler)handler;

@end
