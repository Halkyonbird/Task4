//
//  ViewController.m
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "ViewController.h"
//ash #import "CardView.h"

@interface ViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cardViews;

@property (weak, nonatomic) IBOutlet UILabel *cardsNumberForCompareLabel;
@property (weak, nonatomic) IBOutlet UIStepper *cardsNumberForCompareStepper;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *resultHistory;
@property NSUInteger currentStageNumber;

- (void)tapCard:(UITapGestureRecognizer *)gesture;

@end

@implementation ViewController

#pragma mark - Game control

- (IBAction)cardsNumberForCompareChanged:(UIStepper *)sender {
    self.game.cardsNumberForCompare = (NSUInteger) sender.value;
    self.cardsNumberForCompareLabel.text = [NSString stringWithFormat:@"Number of matches: %d", self.game.cardsNumberForCompare];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                                  usingDesk:[self createDesk]];
        _game.cardsNumberForCompare = (NSUInteger) self.cardsNumberForCompareStepper.value;
    }
    return _game;
}

- (IBAction)newGame:(id)sender {
    self.game = nil;
    self.cardsNumberForCompareStepper.enabled = YES; // enable stepper before new game
    self.historyLabel.text = @"Waiting for the first matching...";
    self.currentStageNumber = self.game.stageNumber;
    self.historySlider.maximumValue = self.currentStageNumber;
    self.resultHistory = nil;
    [self updateUI];
}

- (Desk *)createDesk
{
    return nil; // absract method
}

- (void)tapCard:(UITapGestureRecognizer *)gesture {
    int chosenButtonIndex = [self.cardViews indexOfObject:gesture.view];
    //NSLog(@"Hello from View with Index: %d", chosenButtonIndex);
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.cardsNumberForCompareStepper.enabled = NO; // disable stepper after game starting
    [self updateUI];
}

- (void)updateUI {
    
    for (CardView *cardView in self.cardViews) {
        NSUInteger cardButtonIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        cardView.isOpen = card.isChosen;
        cardView.isDisabled = card.isMatched;        
        [self setContentForCardView:cardView withCard:card]; // call method of child for adding playing card properties (rank, suit) to the cardView
        [cardView setNeedsDisplay];
        self.scoreLabel.text = [NSString stringWithFormat: @"Current score: %d",self.game.score];
    }
    if (self.game.stageNumber > self.currentStageNumber) { // Catch increasing of stageNumber (after every matching)
        self.currentStageNumber = self.game.stageNumber;
        NSString *resultString = [NSString stringWithFormat:@"For matching %@ the score is %d", @(self.game.stageNumber), self.game.score];
        self.historyLabel.text = resultString;
        [self.resultHistory addObject:resultString]; // add result to history array
        self.historySlider.maximumValue = self.currentStageNumber;
        [self.historySlider setValue:(float)self.currentStageNumber animated:YES];
    }
}

- (void) setContentForCardView: (CardView *) cardView withCard: (Card *) card { //abstract
//abstract
}

#pragma mark - Preferred fonts

- (void)preferredFontSizeWasChanged:(NSNotification *)notification {
    for (CardView *cardView in self.cardViews) {
        [cardView setNeedsDisplay];
    }
}

#pragma mark - History

- (NSMutableArray *)resultHistory {
    if (!_resultHistory)_resultHistory = [[NSMutableArray alloc] init];
    return _resultHistory;
}

- (IBAction)getHistory:(UISlider *)sender {
    int selectedIndex = (int) sender.value;
    if (selectedIndex >=0 && (selectedIndex <= self.currentStageNumber-1) && [self.resultHistory count]) {
        self.historyLabel.text = self.resultHistory[selectedIndex];
    }
}

#pragma mark - System

- (void)viewWillAppear:(BOOL)animated {
    //[self setPreferredFonts];
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontSizeWasChanged:)                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cardsNumberForCompareLabel.text = [NSString stringWithFormat:@"Number of matches: %d", (NSUInteger) self.cardsNumberForCompareStepper.value];
    for (CardView *cardView in self.cardViews) { // add GestureRecognizer to every cardView with target in this controller
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
