//
//  Card.h
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GroupCard, Notification;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * cardDescription;
@property (nonatomic, retain) NSString * cardName;
@property (nonatomic, retain) Notification *notification;
@property (nonatomic, retain) NSSet *groupCards;

+ (Card*)newCard;
- (NSString*)cardType;

- (NSDate*)fireDate;
- (void)setFireDate:(NSDate*)fireDate;

@end

@interface Card (CoreDataGeneratedAccessors)

- (void)addGroupCardsObject:(GroupCard *)value;
- (void)removeGroupCardsObject:(GroupCard *)value;
- (void)addGroupCards:(NSSet *)values;
- (void)removeGroupCards:(NSSet *)values;

@end
