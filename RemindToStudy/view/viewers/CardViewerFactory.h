//
//  CardViewerFactory.h
//  RemindToStudy
//
//  Created by black9 on 02/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardViewer.h"
#import "Card.h"

@interface CardViewerFactory : NSObject

+ (id<CardViewer>)viewerForCard:(Card*)card;
+ (id<CardViewer>)viewerWithDisabledTouchesForCard:(Card*)card;

@end
