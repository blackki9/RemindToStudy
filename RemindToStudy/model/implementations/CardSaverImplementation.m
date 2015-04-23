//
//  CardSaverImplementation.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardSaverImplementation.h"
#import "DBManager.h"

@implementation CardSaverImplementation

- (void)saveCard:(Card *)card
{
    [[DBManager sharedManager] saveContext];
}

@end
