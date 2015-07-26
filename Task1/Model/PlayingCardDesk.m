//
//  PlayingCardDesk.m
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "PlayingCardDesk.h"
#import "PlayingCard.h"


@implementation PlayingCardDesk

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank =1; rank<[PlayingCard maxRank]; rank++) {
                PlayingCard  *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    return  self;
}

@end
