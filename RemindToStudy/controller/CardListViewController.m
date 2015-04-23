//
//  CardListViewController.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardListViewController.h"
#import "GroupCard.h"
#import "CardLoader.h"
#import "CardLoaderImplementation.h"
#import "CardView.h"
#import <MZFormSheetController.h>
#import "AddCardPopup.h"
#import "CardSaverImplementation.h"
#import "CardAdderFactory.h"

const CGFloat carouselItemWidth = 220.0f;
NSString* const cardViewControllerSegueKey = @"CardViewSegue";
NSString* const cardViewNibName = @"CardView";
NSString* const addPopupIdentifier = @"AddCardPopup";
const CGFloat addPopupWidth = 300.0f;
const CGFloat addPopupHeight = 400.0f;

@interface CardListViewController ()

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) GroupCard* baseGroupCard;
@property (nonatomic, strong) id<CardLoader> loader;
@property (nonatomic, strong) NSMutableArray* currentCards;
@property (nonatomic, strong) id<CardSaver> saver;

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadCards];
}

- (void)loadCards
{
    if(!self.baseGroupCard) {
        self.baseGroupCard = [self.loader loadBaseList];
    }
    
    self.currentCards = [NSMutableArray arrayWithArray:[self.baseGroupCard.cards allObjects]];
    
    [self.carousel reloadData];
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
    [self setupCarouselView:view];
    
    return view;
}

- (void)setupCarouselView:(UIView*)view
{
    if (view == nil)
    {
        view = [[[NSBundle mainBundle] loadNibNamed:cardViewNibName owner:self options:nil] objectAtIndex:0];
    }
    
}

#pragma mark - icarousel delegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    [self performSegueWithIdentifier:cardViewControllerSegueKey sender:self];
}

#pragma mark - add

- (IBAction)addCard:(id)sender {
    [self showAddController];
}

#pragma mark - show add popup
- (void)showAddController
{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:addPopupIdentifier];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:CGSizeMake(addPopupWidth,
                                                                                              addPopupHeight)
                                                                    viewController:viewController];
    
    __weak CardListViewController* weakSelf = self;
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
        AddCardPopup* popup = (AddCardPopup*)presentedFSViewController;
        [weakSelf setupAddCardPopup:popup];
        popup.finishHandler = ^(BOOL result) {
            [weakSelf loadCards];
        };
    };
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    [formSheet presentAnimated:YES completionHandler:nil];
}

- (void)setupAddCardPopup:(AddCardPopup*)addPopup
{
    addPopup.saver = self.saver;
    addPopup.groupCard = self.baseGroupCard;
    addPopup.adder = [CardAdderFactory adderForType:kTextAdder]; // TODO add chooser for types
    [addPopup updateUI];
}

@end
