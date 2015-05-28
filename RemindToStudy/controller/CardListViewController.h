//
//  CardListViewController.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <MZFormSheetController.h>
#import "CardSorter.h"
#import "CardLoader.h"
#import "CardSaver.h"

@interface CardListViewController : MZFormSheetController <iCarouselDelegate>

@property (nonatomic, strong) id<CardSorter> sorter;
@property (nonatomic, strong) id<CardLoader> loader;
@property (nonatomic, strong) id<CardSaver> saver;

@end
