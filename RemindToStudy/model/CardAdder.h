//
//  CardAdder.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef RemindToStudy_CardAdder_h
#define RemindToStudy_CardAdder_h

@import UIKit;
@class Card;

@protocol CardAdderDelegate <NSObject>

- (void)cardSubmitted:(Card*)card;
- (NSString*)cardName;

@end

@protocol CardAdder <NSObject>

- (void)showAddUIInView:(UIView*)parentView;
- (NSDictionary*)collectInfoWithDelegate:(id<CardAdderDelegate>)delegate;

- (void)addCardWithInfo:(NSDictionary*)cardInfo delegate:(id<CardAdderDelegate>)delegate;

@end

#endif
