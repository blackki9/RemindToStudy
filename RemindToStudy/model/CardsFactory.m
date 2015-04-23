//
//  CardsFactory.m
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardsFactory.h"
#import "Card.h"
#import "TextCard.h"

NSString* const kTextCardMainTextKey = @"mainText";
NSString* const kCardDescriptionKey = @"cardDescription";
NSString* const kCardNameKey = @"cardName";
//TODO add other cards keys

@implementation CardsFactory                                                                                                                                                                                                                                       

+ (Card*)cardForClass:(Class)cardClass info:(NSDictionary*)info
{
    if(cardClass == [TextCard class]) {
        return [self textCardWithInfo:info];
    }
    
    return nil;
}

+ (Card*)textCardWithInfo:(NSDictionary*)info
{
    TextCard* result = [TextCard newCard];
    
#warning TODO - add validation here
    result.mainText = info[kTextCardMainTextKey];
    result.cardDescription = info[kCardDescriptionKey];
    result.cardName = info[kCardNameKey];
    
    return result;
}

@end
