//
//  CardEditorFactory.m
//  RemindToStudy
//
//  Created by black9 on 10/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardEditorFactory.h"
#import "TextCardEditor.h"
#import "TextCard.h"
#import "CardRemoverImpl.h"

@implementation CardEditorFactory

+ (id<CardEditor>)cardEditorForCard:(Card*)card
{
    id<CardEditor> result = nil;
    
    if([card isKindOfClass:[TextCard class]]) {
        result = [[TextCardEditor alloc] initWithCard:card];
    }
    
    [result setCardRemover:[[CardRemoverImpl alloc] init]];
    
    return result;
}

@end
