//
//  TextCardEditor.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "TextCardEditor.h"
#import "TextCard.h"
#import <PureLayout.h>
#import "BKTextViewKeyboardHider.h"

@import UIKit;

@interface TextCardEditor ()

@property (nonatomic, strong) TextCard* currentCard;
@property (nonatomic, strong) UITextView* cardTextView;
@property (nonatomic, strong) BKTextViewKeyboardHider* keyboardHider;
@property (nonatomic, weak) id<CardEditorDelegate> currentDelegate;
@property (nonatomic, strong) id<CardRemover> remover;

@end

@implementation TextCardEditor

- (instancetype)initWithCard:(Card*)card
{
    if(self = [super init]) {
        _currentCard = (TextCard*)card;
    }
    
    return self;
}

- (void)setCardRemover:(id<CardRemover>)remover
{
    self.remover = remover;
}

- (void)setupUIWithContentView:(UIView*)contentView
{
    [self clearContentView];
    [self addCardTextToContentView:contentView];
    [self fillTextFromCard];
    [self setupHider];
    [self pinTextViewToSuperview];
    
    [self.currentDelegate setUpWithName:self.currentCard.cardName fireDate:[self.currentCard fireDate]];
}
- (void)addCardTextToContentView:(UIView*)contentView
{
    self.cardTextView = [[UITextView alloc] init];
    self.cardTextView.backgroundColor = [UIColor clearColor];
    self.cardTextView.font = [UIFont systemFontOfSize:20.0f];
    self.cardTextView.layer.borderWidth = 1.0f;
    
    self.cardTextView.editable = YES;
    self.cardTextView.userInteractionEnabled = YES;
    
    [contentView addSubview:self.cardTextView];
}
- (void)fillTextFromCard
{
    self.cardTextView.text = self.currentCard.mainText;
}
- (void)setupHider
{
    self.keyboardHider = [[BKTextViewKeyboardHider alloc] init];
    [self.keyboardHider addToolbarToTextView:self.cardTextView];
}
- (void)pinTextViewToSuperview
{
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)clearContentView
{
    [self.cardTextView removeFromSuperview];
}

- (void)saveChanges
{
    self.currentCard.mainText = self.cardTextView.text;
#warning TODO - move this in some base class when will add new subclasses
    NSDictionary* cardInfo = [self.currentDelegate collectedInfoForCard];
    self.currentCard.cardName = cardInfo[@"cardName"]; //TODO change magic string to constant
    [self.currentCard setFireDate:cardInfo[@"fireDate"]];
    [self.currentDelegate saveCard:self.currentCard];
}

- (void)removeCard
{
    [self.remover removeCard:self.currentCard];
    [self.currentDelegate cardRemoved];
}

- (void)setCard:(Card*)card
{
    self.currentCard = (TextCard*)card;
}

- (void)setDelegate:(id<CardEditorDelegate>)delegate
{
    self.currentDelegate = delegate;
}


@end
