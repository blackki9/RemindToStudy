//
//  CardCarouselDataSource.h
//  RemindToStudy
//
//  Created by black9 on 17/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCarousel.h"
#import "CardView.h"

@interface CardCarouselDataSource : NSObject <iCarouselDataSource>

@property (nonatomic, strong) EditButtonAction cardViewEditAction;

- (instancetype)initWithCards:(NSArray*)cards;

- (void)setCardsAndReload:(NSArray*)cards;
- (CardView*)newCardView;
- (CardView*)setupCardView:(CardView*)cardView card:(Card*)card;
- (float)cardItemWidth;

@end
