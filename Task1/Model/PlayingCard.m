//
//  PlayingCard.m
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [NSString stringWithFormat:@"%@%@", rankStrings[self.rank], self.suit];
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"D", @"K"];
}

+(NSUInteger)maxRank {
    return [[self rankStrings] count];
}
    
+ (NSArray *)validSuits {
    return @[@"♠︎", @"♣︎", @"♦︎", @"♥︎"];
}

@synthesize suit = _suit;

- (NSString *)suit {
    return _suit ? _suit: @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit])  {
        _suit = suit;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int numOtherCards = [otherCards count];
    
    if (numOtherCards) {
        for (Card *card in otherCards) {
            if ([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *) card;
                if (otherCard.rank == self.rank) {
                    score +=4;
                } else  if ([otherCard.suit isEqualToString:self.suit]) {
                    score +=1;
                }
            }
        }
    }
    if (numOtherCards >1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards-1)]];
    }
    return score;
}

@end
