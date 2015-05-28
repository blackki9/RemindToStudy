//
//  CardRemoverImpl.m
//  RemindToStudy
//
//  Created by black9 on 10/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardRemoverImpl.h"
#import "Card.h"
#import <NSManagedObject+MagicalRecord.h>
#import "ModelConstants.h"

@implementation CardRemoverImpl

- (void)removeCard:(Card*)card
{
    [card MR_deleteEntity];
    [self sendNotificationThatCardWasDeleted];
}
- (void)sendNotificationThatCardWasDeleted
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CARD_WAS_REMOVED_NOTIFICATION object:nil];
}
@end
