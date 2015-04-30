//
//  CardsFactory.h
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

extern NSString* const kTextCardMainTextKey;
extern NSString* const kCardDescriptionKey;
extern NSString* const kCardNameKey;

@interface CardsFactory : NSObject

+ (Card*)cardForClass:(Class)cardClass info:(NSDictionary*)info;
+ (Card*)textCardWithInfo:(NSDictionary*)info;
//TODO add other types of cards

@end
