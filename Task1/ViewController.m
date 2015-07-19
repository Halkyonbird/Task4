//
//  ViewController.m
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "ViewController.h"
//#import "PlayingCardDesk.h"
//ash #import "CardMatchingGame.h"

@interface ViewController ()

//ash @property (nonatomic, strong) CardMatchingGame *game;
//ash @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberOfMatchesLabel;
- (NSAttributedString *)titleForCard:(Card *) card;
- (UIImage *)backgroundImageForCard:(Card *) card;

@property (weak, nonatomic) IBOutlet UIStepper *numberOfMatchesStepper; 

@end

@implementation ViewController

- (IBAction)matchedCardsNumberChanged:(UIStepper *)sender {
    self.game.numberOfMatches = (NSUInteger) sender.value;
    self.numberOfMatchesLabel.text = [NSString stringWithFormat:@"Number of matches: %d", self.game.numberOfMatches];
    
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDesk:[self createDesk]];
        _game.numberOfMatches = (NSUInteger) self.numberOfMatchesStepper.value;
    }
    return _game;
}

- (IBAction)newGame:(id)sender {
    self.game = nil;
    self.numberOfMatchesStepper.enabled = YES; // enable stepper before new game
    [self updateUI];
}

- (Desk *)createDesk
{
    return nil; // absract method
}

- (IBAction)touchButton:(UIButton *)sender {
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    self.numberOfMatchesStepper.enabled = NO; // disable stepper after game starting
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]  forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]  forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %d",self.game.score];
    } 
}

- (NSAttributedString *)titleForCard: (Card *) card
{
    return [[NSMutableAttributedString alloc] initWithString:card.isChosen ? card.contents : @""];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.numberOfMatchesLabel.text = [NSString stringWithFormat:@"Number of matches: %d", (NSUInteger) self.numberOfMatchesStepper.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
