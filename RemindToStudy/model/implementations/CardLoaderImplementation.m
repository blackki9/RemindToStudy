//
//  CardLoaderImplementation.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardLoaderImplementation.h"
#import "GroupCard.h"
#import <MagicalRecord.h>

@implementation CardLoaderImplementation

- (GroupCard*)loadBaseList
{
    GroupCard* result = [GroupCard MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"levelIndex = 0"]];
    
    if(!result) {
        result = [GroupCard newCard];
    }
    
    return result;
}

- (Card*)cardForNotificationId:(NSString*)notificationId
{
    Card* result = [Card MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"notification.notificationId = %@",notificationId]];
    
    return result;
}

@end
