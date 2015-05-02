//
//  CardViewerFactory.m
//  RemindToStudy
//
//  Created by black9 on 02/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import "CardViewerFactory.h"
#import "TextCardViewer.h"
#import "TextCard.h"

@implementation CardViewerFactory

+ (id<CardViewer>)viewerForCard:(Card*)card
{
    if([card class] == [TextCard class]) {
        return [self textViewerForCard:card];
    }
    
    return nil;
}

+ (TextCardViewer*)textViewerForCard:(Card*)card
{
    return [[TextCardViewer alloc] initWithCard:card];
}

@end
