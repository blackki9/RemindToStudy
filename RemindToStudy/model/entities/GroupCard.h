//
//  GroupCard.h
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Card.h"

@class Card;

@interface GroupCard : Card

@property (nonatomic, retain) NSNumber * levelIndex;
@property (nonatomic, retain) NSSet *cards;

+ (GroupCard*)newCard;

@end

@interface GroupCard (CoreDataGeneratedAccessors)

- (void)addCardsObject:(Card *)value;
- (void)removeCardsObject:(Card *)value;
- (void)addCards:(NSSet *)values;
- (void)removeCards:(NSSet *)values;

@end
