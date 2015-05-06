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

@interface EditCardPopup : BaseCardPopup

+ (EditCardPopup*)showEditPopupWithFinishHandler:(CardPopupResultAction)finishBlock passBlock:(CardPopupPassDataBlock)passBlock;

- (void)setupUIWithEditor:(id<CardEditor>)editor;

@end
