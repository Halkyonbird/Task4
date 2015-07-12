//
//  CardMatchingGame.h
//  Task1
//
//  Created by Alexey Sheverdin on 7/9/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Desk.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDesk: (Desk *)desk;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger numberOfMatches;

@end
