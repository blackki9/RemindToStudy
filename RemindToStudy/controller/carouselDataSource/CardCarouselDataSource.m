//
//  CardCarouselDataSource.m
//  RemindToStudy
//
//  Created by black9 on 17/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardCarouselDataSource.h"
#import "Card.h"
#import "CardViewerFactory.h"
#import <NSDate+DateTools.h>

CGFloat carouselItemWidth = 320.0f;
const CGFloat carouselItemXMargin = 20.0f;
NSString* const cardViewNibName = @"CardView";

@interface CardCarouselDataSource ()

@property (nonatomic, strong) NSArray* currentCards;
@property (nonatomic, strong) iCarousel* currendCarousel;

@end

@implementation CardCarouselDataSource

- (instancetype)initWithCards:(NSArray *)cards
{
    if(self = [super init]) {
        _currentCards = cards;
    }
    return self;
}

- (void)setCardsAndReload:(NSArray*)cards
{
    self.currentCards = cards;
    
    [self.currendCarousel reloadData];
}

- (float)cardItemWidth
{
    return carouselItemWidth;
}

#pragma mark - icarousel data source

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    if(!self.currendCarousel) {
        self.currendCarousel = carousel;
    }
    return [self.currentCards count];
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView* result = [self setupCarouselView:view index:index];
    return result;
}
- (UIView*)setupCarouselView:(UIView*)view index:(NSInteger)index
{
    CardView* result = (CardView*)view;
    if (result == nil)
    {
        result = [self newCardView];
    }
    
    Card* card = self.currentCards[index];
    result = [self setupCardView:result card:card];
    result.cardIndex = index;
    
    return result;
}
- (CardView*)newCardView
{
    CardView* result = [[[NSBundle mainBundle] loadNibNamed:cardViewNibName owner:self options:nil] objectAtIndex:0];
    [result setEditButtonAction:self.cardViewEditAction];
    result.frame = [self cardViewFrame];
    
    return result;
}
- (CGRect)cardViewFrame
{
    //TODO implement handling size for different screens
    return  CGRectMake(0,
                       0,
                       [self cardItemWidth] - carouselItemXMargin,
                       500);
}

- (CardView*)setupCardView:(CardView*)cardView card:(Card*)card
{
    cardView.cardNameLabel.text = card.cardName;
    cardView.typeLabel.text = [card cardType];
    cardView.dateLabel.text = [[card fireDate] formattedDateWithFormat:@"dd/MM/yyyy hh:mm"];
    [cardView setEditButtonAction:self.cardViewEditAction];
    
    id<CardViewer> viewer = [CardViewerFactory viewerWithDisabledTouchesForCard:card];
    [cardView setupViewWithCardViewer:viewer];
    
    return cardView;
}

@end
