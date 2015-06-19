//
//  TextCard.m
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "TextCard.h"
#import <MagicalRecord.h>

@implementation TextCard

@dynamic mainText;

+ (Card*)newCard
{
    return [TextCard MR_createEntity];
}

- (NSString*)cardType
{
    return @"Text";
}

@end
