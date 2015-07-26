//
//  CardMatchingGame.m
//  Task1
//
//  Created by Alexey Sheverdin on 7/9/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return  _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDesk:(Desk *)desk
{
    self = [super init];
    // ash
    self.cardsNumberForCompare = 2;
    self.stageNumber = 0;
    if (self) {
        for(int i=0; i<=count; i++) {
            Card *card = [desk drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index]: nil ;
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
// -------   version 1  begin ----------- (uncomment following code for activating version 1)
// in this version last chosen card flips back

            card.chosen = YES;
            NSMutableArray *chosenCards = [NSMutableArray array]; //array for chosen cards
            int chosenCardsNumber = 1;
            NSMutableArray *otherCards = [self.cards mutableCopy];
            [otherCards removeObjectAtIndex:index]; // all array without current chosen card

            for (Card *otherCard in otherCards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                    chosenCardsNumber++;
                    if (chosenCardsNumber == self.cardsNumberForCompare) { // achieved necessary number of chosen cards
                        int matchScore = [card match:chosenCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            //otherCard.matched = YES;
                            card.matched = YES;
                            for (Card *curCard in chosenCards)
                                curCard.matched = YES;
                            
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            card.chosen = NO;
                            for (Card *curCard in chosenCards)
                                curCard.chosen = NO;
                        }
                        self.stageNumber++;
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;

// -------   version 1  end -----------
           
         

// -------   version 2  begin ----------- (comment following code for activating version 1)
// in this version last chosen card stays open and will be first at next choose cycle
/*
            NSMutableArray *chosenCards = [NSMutableArray array]; //array for chosen cards
            int chosenCardsNumber = 1;
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                    chosenCardsNumber++;
                    if (chosenCardsNumber == self.cardsNumberForCompare) { // achieved necessary number of chosen cards
                        int matchScore = [card match:chosenCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            //otherCard.matched = YES;
                            card.matched = YES;
                            for (Card *curCard in chosenCards)
                                curCard.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            card.chosen = NO;
                            for (Card *curCard in chosenCards)
                                curCard.chosen = NO;
                        }
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
*/
// -------   version 2  end -----------
            
        }
    }
}

@end
