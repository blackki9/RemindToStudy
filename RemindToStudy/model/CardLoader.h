//
//  CardLoader.h
//  RemindToStudy
//
//  Created by black9 on 19/04/15.
//  Copyright (c) 2015 black9. All rights reserved.
//

#ifndef RemindToStudy_CardLoader_h
#define RemindToStudy_CardLoader_h
@class GroupCard;

@protocol CardLoader <NSObject>

- (GroupCard*)loadBaseList;

@end

#endif
