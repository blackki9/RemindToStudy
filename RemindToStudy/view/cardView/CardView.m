//
//  CardView.m
//  RemindToStudy
//
//  Created by black9 on 23/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardView.h"
#import "CardViewer.h"

@interface CardView ()

@property (nonatomic, strong) id<CardViewer> currentViewer;
@property (nonatomic, strong) EditButtonAction currentEditAction;

@end

@implementation CardView

- (void)setEditButtonAction:(EditButtonAction)action
{
    self.currentEditAction = action;
}

- (void)setupViewWithCardViewer:(id<CardViewer>)viewer
{
    [self clearContent];
    self.currentViewer = viewer;
    [viewer addUIToContentView:self.contentView];
}

- (void)clearContent
{
    if(self.currentViewer) {
        [self.currentViewer clearContentView];
    }
}

- (IBAction)edit:(id)sender {
    if(self.currentEditAction) {
        self.currentEditAction(self.cardIndex);
    }
}

@end
