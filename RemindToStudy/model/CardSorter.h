//
//  CardSorter.h
//  RemindToStudy
//
//  Created by black9 on 16/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef RemindToStudy_CardSorter_h
#define RemindToStudy_CardSorter_h

@class GroupCard;

@protocol CardSorter <NSObject>

- (NSArray*)sortedCardsByNotificationDateForGroupCard:(GroupCard*)groupCard;

@end

#endif
