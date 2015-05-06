//
//  TextCardEditor.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "TextCardEditor.h"
#import "TextCard.h"

@import UIKit;

@interface TextCardEditor ()

@property (nonatomic, strong) TextCard* currentCard;
@property (nonatomic, strong) UITextView* cardTextView;
@end

@implementation TextCardEditor

- (instancetype)initWithCard:(Card*)card
{
    if(self = [super init]) {
        _currentCard = (TextCard*)card;
    }
    
    return self;
}

- (void)setupUIWithContentView:(UIView*)contentView
{
    
}


- (void)saveChanges
{
    
}

- (void)setCard:(Card*)card
{
    
}

- (void)setDelegate:(id<CardEditorDelegate>)delegate
{

}

@end
