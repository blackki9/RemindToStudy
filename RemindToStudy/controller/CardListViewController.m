//
//  CardListViewController.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardListViewController.h"
#import "GroupCard.h"
#import "CardView.h"
#import "CardLoader.h"
#import "CardLoaderImplementation.h"
#import "AddCardPopup.h"
#import "CardSaverImplementation.h"
#import "CardAdderFactory.h"
#import <NSDate+DateTools.h>
#import "NotificationCenter.h"
#import "Constants.h"
#import "CardViewerFactory.h"
#import "CardViewController.h"
#import "CardNotificationScheduler.h"
#import "EditCardPopup.h"

const CGFloat carouselItemWidth = 320.0f;
const CGFloat carouselItemXMargin = 20.0f;

NSString* const cardViewControllerSegueKey = @"CardViewSegue";
NSString* const cardViewNibName = @"CardView";

@interface CardListViewController ()

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) GroupCard* baseGroupCard;
@property (nonatomic, strong) id<CardLoader> loader;
@property (nonatomic, strong) NSMutableArray* currentCards;
@property (nonatomic, strong) id<CardSaver> saver;
@property (nonatomic, strong) Card* currentCardToShow;
@property (nonatomic, strong) EditButtonAction cardViewEditAction;

@end


@implementation CardListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _loader = [[CardLoaderImplementation alloc] init];
        _saver = [[CardSaverImplementation alloc] init];
        _currentCards = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carousel.pagingEnabled = YES;
    
    [self setupEditAction];
}
- (void)setupEditAction
{
    __weak CardListViewController* weakSelf = self;
    self.cardViewEditAction = ^(NSInteger cardIndex) {
        [weakSelf showEditViewForIndex:cardIndex];
    };
}
- (void)showEditViewForIndex:(NSInteger)index
{
    [EditCardPopup showEditPopupWithFinishHandler:^(BOOL result) {
        
    } passBlock:^(UIViewController *controller) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerToNotifications];

    [self loadCards];
}
- (void)registerToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kCardHandlerNotification object:nil];
}
- (void)loadCards
{
    if(!self.baseGroupCard) {
        self.baseGroupCard = [self.loader loadBaseList];
    }
    
    self.currentCards = [NSMutableArray arrayWithArray:[self.baseGroupCard.cards allObjects]];
    
    [self.carousel reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterToNotifications];
}
- (void)unregisterToNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - icarousel data source

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.currentCards count];
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return carouselItemWidth;
    
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView* result = [self setupCarouselView:view index:index];
    
    return result;
}

- (UIView*)setupCarouselView:(UIView*)view index:(NSInteger)index
{
    CardView* result = (CardView*)view;
    if (result== nil)
    {
        result = [self newCardView];
        [result setEditButtonAction:self.cardViewEditAction];
    }
    
    Card* card = self.currentCards[index];
    result = [self setupCardView:result card:card];
 
    return result;
}

- (CardView*)newCardView
{
    CardView* result = [[[NSBundle mainBundle] loadNibNamed:cardViewNibName owner:self options:nil] objectAtIndex:0];
    
    result.frame = [self cardViewFrame];

    return result;
}

- (CGRect)cardViewFrame
{
    //TODO implement handling size for different screens
    return  CGRectMake(0,
                       0,
                       carouselItemWidth - carouselItemXMargin,
                       500);
}

- (CardView*)setupCardView:(CardView*)cardView card:(Card*)card
{
    cardView.cardNameLabel.text = card.cardName;
    cardView.typeLabel.text = [card cardType];
    cardView.dateLabel.text = [card.notification.fireDate formattedDateWithFormat:@"dd/MM/yyyy hh:mm"];

    id<CardViewer> viewer = [CardViewerFactory viewerWithDisabledTouchesForCard:card];
    [cardView setupViewWithCardViewer:viewer];
    
    return cardView;
}


#pragma mark - icarousel delegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    Card* cardToShow = self.currentCards[index];
    [self showCard:cardToShow];
}

- (void)showCard:(Card*)card
{
    self.currentCardToShow = card;
    CardView * cardView = [self newCardView];
    
    cardView = [self setupCardView:cardView card:card];
    
    [CardViewController showCardPopupWithCardView:cardView];
}

#pragma mark - add

- (IBAction)addCard:(id)sender {
    [self showAddController];
}

#pragma mark - show add popup
- (void)showAddController
{
    __weak CardListViewController* weakSelf = self;
   [AddCardPopup showAddPopupWithFinishHandler:^(BOOL result) {
       if(result) {
           [weakSelf loadCards];
       }
   } passBlock:^(UIViewController* controller) {
       [weakSelf setupAddCardPopup:(AddCardPopup*)controller];
   }];

}

- (AddCardPopup*)setupAddCardPopup:(AddCardPopup*)addPopup
{
    addPopup.saver = self.saver;
    addPopup.groupCard = self.baseGroupCard;
    addPopup.adder = [CardAdderFactory adderForType:kTextAdder]; // TODO add chooser for types
    [addPopup setNotificationScheduler:[CardNotificationScheduler new]];
    [addPopup updateUIWithCurrentAdder];
    
    return addPopup;
}

#pragma mark - notification handling

- (void)handleNotification:(NSNotification*)notification
{
    [self hidePopups];
    [self showCard:[self.loader cardForNotificationId:notification.userInfo[kCardHandlerNotificationIdKey]]];
}

- (void)hidePopups
{
    //TODO
}

@end
