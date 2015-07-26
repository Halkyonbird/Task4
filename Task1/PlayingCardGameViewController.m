//
//  PlayingCardGameViewController.m
//  Task1
//
//  Created by User on 18.07.15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDesk.h"
#import "PlayingCard.h"


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Desk *)createDesk
{
    return [[PlayingCardDesk alloc] init];  
}

- (NSAttributedString *)titleForCard: (Card *) card
{
    // !!! Задать вопрос Росту - можно было бы вызвать метод суперкласса, но пришлось бы делать его public?
    NSString *content = card.isChosen ? card.contents : @"";
    BOOL isRedCard = [card.contents containsString:@"♦︎"] || [card.contents containsString:@"♥︎"];
    UIColor *cardColor = isRedCard ? [UIColor redColor] : [UIColor blackColor];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSForegroundColorAttributeName: cardColor}] ;
    return resultAttributedString;
}

- (void) setContentForCardView: (CardView *) cardView withCard: (PlayingCard *) card {
    cardView.rank = card.rank;
    cardView.suit = [[NSMutableAttributedString alloc] initWithString:card.suit];
    [cardView setNeedsDisplay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
