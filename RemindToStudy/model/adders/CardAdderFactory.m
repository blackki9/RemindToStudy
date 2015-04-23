//
//  CardAdderFactory.m
//  RemindToStudy
//
//  Created by black9 on 23/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardAdderFactory.h"
#import "TextCardAdder.h"
#import "Card.h"

@implementation CardAdderFactory

+ (id<CardAdder>)adderForType:(AdderType)adderType
{
    id<CardAdder> result = nil;
    switch(adderType) {
        case kTextAdder: {
            result = [[TextCardAdder alloc] init];
            break;
        }
        default:
            break;

    }
    
    return result;
}

@end
