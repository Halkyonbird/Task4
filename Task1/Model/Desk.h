//
//  Desk.h
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Desk : NSObject

- (void)addCard: (Card *)card;
- (Card *)drawRandomCard;

@end
