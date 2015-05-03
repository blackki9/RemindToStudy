//
//  TextCardViewer.m
//  RemindToStudy
//
//  Created by black9 on 02/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "TextCardViewer.h"
#import "TextCard.h"
#import <PureLayout.h>

@import UIKit;

@interface TextCardViewer()

@property (nonatomic, strong) TextCard* card;
@property (nonatomic, strong) UITextView* cardTextView;

@end

@implementation TextCardViewer

- (instancetype)initWithCard:(Card*)card
{
    if(self = [super init]) {
        _card = (TextCard*)card;
    }
    
    return self;
}

- (void)addUIToContentView:(UIView*)contentView
{
    [self addTextViewToContentView:contentView];
    [self pinTextViewToSuperview];
    [self fillTextViewWithCardContent];
}

- (void)addTextViewToContentView:(UIView*)contentView
{
    self.cardTextView = [[UITextView alloc] init];
    self.cardTextView.backgroundColor = [UIColor clearColor];
    self.cardTextView.font = [UIFont systemFontOfSize:20.0f];
    
    self.cardTextView.editable = NO;
    self.cardTextView.userInteractionEnabled = YES;
    
    [contentView addSubview:self.cardTextView];
}

- (void)clearContentView
{
    [self.cardTextView removeFromSuperview];
}

- (void)pinTextViewToSuperview
{
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.cardTextView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)fillTextViewWithCardContent
{
    self.cardTextView.text = [self.card mainText];
}

- (void)disableTouches
{
    self.cardTextView.userInteractionEnabled = NO;
}

@end
