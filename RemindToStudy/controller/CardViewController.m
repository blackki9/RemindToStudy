//
//  CardViewController.m
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardViewController.h"
#import <MZFormSheetController.h>
#import "ModelConstants.h"
#import "EditorsNotifications.h"
#import "CardViewerFactory.h"

#define FORM_PORTRAIT_FROM_TOP_INSET_MARGIN 20.0f

@interface CardViewController ()

@property (nonatomic, strong) CardView* currentCardView;

@end

@implementation CardViewController

+ (void)showCardPopupWithCardView:(CardView*)cardView
{
    CardViewController * viewController = (CardViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CardViewController"];
    
    [viewController setupUIWithCardView:cardView];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:[self popupSize]
                                                                    viewController:viewController];
    formSheet.portraitTopInset = FORM_PORTRAIT_FROM_TOP_INSET_MARGIN;
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
    [formSheet presentAnimated:YES completionHandler:nil];
}
+ (CGSize)popupSize
{
    return CGSizeMake(360,
                      600);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUpSwipeRecognizer];
}
- (void)setupUpSwipeRecognizer
{
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
}
- (void)tapRecognized:(UITapGestureRecognizer*)swipeRecognizer
{
    [self hidePopup];
}
- (void)hidePopup
{
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerToNotifications];
}
- (void)registerToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardWasRemoved:) name:CARD_WAS_REMOVED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardWasEdited:) name:CARD_WAS_EDITED_NOTIFICATION object:nil];
}
- (void)cardWasRemoved:(NSNotification*)notification
{
    [self hidePopup];
}
- (void)cardWasEdited:(NSNotification*)notification
{
    Card* card = [self cardFromNotification:notification];
    [self updateCardViewWithCard:card];
}
- (Card*)cardFromNotification:(NSNotification*)notification
{
    return notification.userInfo[CARD_KEY_IN_USER_INFO];
}
- (void)updateCardViewWithCard:(Card*)card
{
    [self.currentCardView setupViewAndClearWithCardViewer:[CardViewerFactory viewerForCard:card]];
    self.currentCardView.cardNameLabel.text = card.cardName;
    self.currentCardView.typeLabel.text = [card cardType];
    self.currentCardView.dateLabel.text = [card formattedFireDate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterToNotifications];
}
- (void)deregisterToNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUIWithCardView:(CardView*)cardView
{
    self.currentCardView = cardView;
    self.currentCardView.frame = self.view.bounds;
    [self.currentCardView showCloseButton];
    
    __weak CardViewController* weakSelf = self;
    [self.currentCardView setCloseButtonAction:^{
        [weakSelf hidePopup];
    }];
    [self.view addSubview:cardView];
}

@end
