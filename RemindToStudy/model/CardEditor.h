//
//  CardEditor.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef RemindToStudy_CardEditor_h
#define RemindToStudy_CardEditor_h

@class Card;
@class UIView;
@protocol CardRemover;
@protocol CardEditorDelegate <NSObject>

- (NSDictionary*)collectedInfoForCard;
- (void)saveCard:(Card*)card;
- (void)setUpWithName:(NSString*)cardName fireDate:(NSDate*)fireDate;
- (void)cardRemoved;

@end

@protocol CardEditor <NSObject>

- (void)saveChanges;
- (void)setCard:(Card*)card;
- (void)setDelegate:(id<CardEditorDelegate>)delegate;
- (void)removeCard;
- (void)setCardRemover:(id<CardRemover>)remover;

- (void)setupUIWithContentView:(UIView*)contentView;

@end

#endif
