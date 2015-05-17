//
//  CardSorterImplementation.m
//  RemindToStudy
//
//  Created by black9 on 16/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardSorterImplementation.h"
#import "GroupCard.h"

@implementation CardSorterImplementation

- (NSArray*)sortedCardsByNotificationDateForGroupCard:(GroupCard*)groupCard
{
    NSSet* cards = groupCard.cards;
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"notification.fireDate" ascending:YES];
    return [cards sortedArrayUsingDescriptors:@[sortDescriptor]];
}
@end
