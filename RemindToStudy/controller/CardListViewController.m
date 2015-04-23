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
    
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - icarousel data source

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.currentCards count];
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 220;
    
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        view = [[[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil] objectAtIndex:0];
    }
    else {
        
    }
    
        
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    [self performSegueWithIdentifier:@"CardViewSegue" sender:self];
}

#pragma mark - add
- (IBAction)addCard:(id)sender {
    [self showAddController];
}

- (void)showAddController
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCardPopup"];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:CGSizeMake(300, 400) viewController:vc];
    
    __weak CardListViewController* weakSelf = self;
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
        AddCardPopup* popup = (AddCardPopup*)presentedFSViewController;
        popup.saver = weakSelf.saver;
        popup.groupCard = weakSelf.baseGroupCard;
        popup.adder = [CardAdderFactory adderForType:kTextAdder]; // TODO add chooser for types
        popup.finishHandler = ^(BOOL result) {
            [weakSelf loadCards];
        };
        [popup updateUI];
    };
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
    
    }];
}

@end
