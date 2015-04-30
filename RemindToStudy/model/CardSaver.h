//
// CardSaver.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef RemindToStudy_CardSaver_h
#define RemindToStudy_CardSaver_h

@class Card;

@protocol CardSaver <NSObject>

- (void)saveCard:(Card*)card;

@end

#endif
