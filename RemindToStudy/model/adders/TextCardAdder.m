//
//  TextCardAdder.m
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "TextCardAdder.h"
#import "CardSaverImplementation.h"
#import "TextCard.h"
#import "CardsFactory.h"
#import <PureLayout.h>
#import "BKTextViewKeyboardHider.h"
#import "CardsFactory.h"

CGFloat kTopMargin = 5.0f;
CGFloat kBottomMargin = 5.0f;
CGFloat kLeftMargin = 5.0f;
CGFloat kRightMargin = 5.0f;

@interface TextCardAdder ()

@property (nonatomic,strong) UITextView* cardTextView;
@property (nonatomic,strong) BKTextViewKeyboardHider* hider;
<<<<<<< HEAD
=======

>>>>>>> developer
@end

@implementation TextCardAdder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hider = [[BKTextViewKeyboardHider alloc] init];
    }
    return self;
}

- (void)showAddUIInView:(UIView*)parentView
{
    [self addTextViewToContentView:parentView];
    [self pinMainViewToParent];
}

- (void)addTextViewToContentView:(UIView*)parentView
{
    CGRect frame = CGRectMake(kLeftMargin,
                              kTopMargin,
                              parentView.bounds.size.width - kRightMargin * 2, parentView.bounds.size.height - kBottomMargin * 2);
    
    self.cardTextView = [[UITextView alloc] initWithFrame:frame];
    self.cardTextView.layer.borderWidth = 1.0f;
    self.cardTextView.font = [UIFont systemFontOfSize:20.0f];
    self.cardTextView.backgroundColor = [UIColor clearColor];
    self.cardTextView = [self.hider addToolbarToTextView:self.cardTextView];
    
<<<<<<< HEAD
    self.cardTextView = [self.hider addToolbarToTextView:self.cardTextView];
    
=======
>>>>>>> developer
    [parentView addSubview:self.cardTextView];
}

- (void)pinMainViewToParent
{
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (NSDictionary*)collectInfoWithDelegate:(id<CardAdderDelegate>)delegate
{
    NSMutableDictionary* cardInfo = [NSMutableDictionary dictionary];
    
    cardInfo[kCardNameKey] = [delegate cardName];
    cardInfo[kTextCardMainTextKey] = self.cardTextView.text;
    cardInfo[kCardDescriptionKey] = @"";
    
    return cardInfo;
}


- (void)addCardWithInfo:(NSDictionary*)cardInfo delegate:(id<CardAdderDelegate>)delegate
{
    Card* card = [CardsFactory cardForClass:[TextCard class] info:cardInfo];

    [delegate cardSubmitted:card];
}


@end
