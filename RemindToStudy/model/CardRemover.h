//
//  CardRemover.h
//  RemindToStudy
//
//  Created by black9 on 10/05/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef RemindToStudy_CardRemover_h
#define RemindToStudy_CardRemover_h

@class Card;

@protocol CardRemover <NSObject>

- (void)removeCard:(Card*)card;

@end

#endif
