//
//  Card.m
//  RemindToStudy
//
//  Created by black9 on 22/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "Card.h"
#import "GroupCard.h"
#import "Notification.h"
#import <MagicalRecord.h>
#import "TextCard.h"
#import <NSDate+DateTools.h>

@implementation Card

@dynamic cardDescription;
@dynamic cardName;
@dynamic notification;
@dynamic groupCards;

+ (Card*)newCard
{
    return nil;
}

- (NSString*)cardType
{
    return nil;
}

- (NSDate*)fireDate
{
    return self.notification.fireDate;
}

- (NSString*)formattedFireDate
{
    return [[self fireDate] formattedDateWithFormat:@"dd/MM/yyyy hh:mm"];
}

- (void)setFireDate:(NSDate*)fireDate
{
    self.notification.fireDate = fireDate;
}


@end
