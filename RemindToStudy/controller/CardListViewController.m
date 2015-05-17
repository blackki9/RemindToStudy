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
#import "CardEditorFactory.h"
#import "CardSorterImplementation.h"
#import "CardCarouselDataSource.h"



@interface CardListViewController ()

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UIView *addFirstCardView;
@property (nonatomic, strong) GroupCard* baseGroupCard;
@property (nonatomic, strong) id<CardLoader> loader;
@property (nonatomic, strong) NSMutableArray* currentCards;
@property (nonatomic, strong) id<CardSaver> saver;
@property (nonatomic, strong) Card* currentCardToShow;
@property (nonatomic, strong) CardCarouselDataSource* dataSource;

@end


@implementation CardListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _loader = [[CardLoaderImplementation alloc] init];
        _saver = [[CardSaverImplementation alloc] init];
        _currentCards = [NSMutableArray array];
        _sorter = [[CardSorterImplementation alloc] init];
        _dataSource = [[CardCarouselDataSource alloc] initWithCards:_currentCards];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carousel.dataSource = self.dataSource;
    self.carousel.pagingEnabled = YES;
    
    [self setupEditAction];
}
- (void)setupEditAction
{
    __weak CardListViewController* weakSelf = self;
    [self.dataSource setCardViewEditAction:^(NSInteger cardIndex) {
        [weakSelf showEditViewForIndex:cardIndex];
    }];
}
- (void)showEditViewForIndex:(NSInteger)index
{
    Card* card = self.currentCards[index];
    __weak CardListViewController* weakSelf = self;
    [EditCardPopup showEditPopupWithFinishHandler:^(BOOL result) {
        if(result) {
            [weakSelf.carousel reloadItemAtIndex:index animated:YES];
        }
    } passBlock:^(UIViewController *controller) {
        EditCardPopup* popup = (EditCardPopup*)controller;
        popup = [weakSelf setupEditPopup:popup card:card];
    }];
}
- (EditCardPopup*)setupEditPopup:(EditCardPopup*)popup card:(Card*)card
{
    [popup setCardSaver:self.saver];
    [popup setupUIWithEditor:[CardEditorFactory cardEditorForCard:card]];
    __weak CardListViewController* weakSelf = self;
    [popup setRemoveCardHandler:^{
        [weakSelf.currentCards removeObject:card];
        [weakSelf.carousel reloadData];
        [weakSelf showAddFirstButtonIfThereNoCards];
    }];

    return popup;
}
- (void)showAddFirstButtonIfThereNoCards
{
    if(self.currentCards.count == 0) {
        self.addFirstCardView.hidden = NO;
    }
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
    
    self.currentCards = [NSMutableArray arrayWithArray:[self.sorter sortedCardsByNotificationDateForGroupCard:self.baseGroupCard]];
    [self hideAddFirstCardButtonIfThereMoreThanZeroCards];
    [self.dataSource setCardsAndReload:self.currentCards];
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

#pragma mark - icarousel delegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return [self.dataSource cardItemWidth];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    Card* cardToShow = self.currentCards[index];
    [self showCard:cardToShow];
}
- (void)showCard:(Card*)card
{
    self.currentCardToShow = card;
    CardView * cardView = [self.dataSource newCardView];
    cardView.cardIndex = [self.currentCards indexOfObject:card];
    cardView = [self.dataSource setupCardView:cardView card:card];
    
    [CardViewController showCardPopupWithCardView:cardView];
}

#pragma mark - add
- (IBAction)addFirstCard:(id)sender {
    [self addCard:sender];
}
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
           [weakSelf hideAddFirstCardButtonIfThereMoreThanZeroCards];
       }
   } passBlock:^(UIViewController* controller) {
       [weakSelf setupAddCardPopup:(AddCardPopup*)controller];
   }];
}
- (void)hideAddFirstCardButtonIfThereMoreThanZeroCards
{
    if(self.currentCards.count > 0) {
        self.addFirstCardView.hidden = YES;
    }
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
    [self showCard:[self.loader cardForNotificationId:notification.userInfo[kCardHandlerNotificationIdKey]]];
}

@end
