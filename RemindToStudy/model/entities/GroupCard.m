//
//  GroupCard.m
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "GroupCard.h"
#import "Card.h"
#import <MagicalRecord.h>

@implementation GroupCard

@dynamic levelIndex;
@dynamic cards;

+ (GroupCard*)newCard
{
    GroupCard* result = [GroupCard MR_createEntity];
    
    return result;
}

@end
