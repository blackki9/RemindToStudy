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

@end

@implementation CardView

- (void)setupViewWithCardViewer:(id<CardViewer>)viewer
{
    if(self.currentViewer) {
        [self.currentViewer clearContentView];
    }
    
    self.currentViewer = viewer;
    [viewer addUIToContentView:self.contentView];
}



@end
