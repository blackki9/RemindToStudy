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
@property (nonatomic, strong) id<CardEditor> currentEditor;
@end

@implementation CardView

- (void)setupViewWithCardViewer:(id<CardViewer>)viewer
{

    self.currentViewer = viewer;
    [viewer addUIToContentView:self.contentView];
}

- (void)setupViewWithEditor:(id<CardEditor>)editor
{
    
}

- (void)clearContent
{
    if(self.currentViewer) {
        [self.currentViewer clearContentView];
    }
    if(self.currentEditor) {
        //TODO clean editor
    }
}


@end
