//
//  Desk.m
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "Desk.h"

@interface Desk ()

@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation Desk

- (NSMutableArray *)cards {
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(Card *)card {
    [self.cards addObject:card];
}

- (Card *)drawRandomCard {
    Card * drawnCard = nil;
    if ([self.cards count]) {
        unsigned int index = arc4random() % [self.cards count];
        drawnCard = self.cards[index];
        [self.cards removeObject:self.cards[index]];
    }
    return drawnCard;
}

@end
