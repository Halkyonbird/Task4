//
//  PlayingCardGameViewController.m
//  Task1
//
//  Created by User on 18.07.15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDesk.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Desk *)createDesk
{
    return [[PlayingCardDesk alloc] init];  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSAttributedString *)titleForCard: (Card *) card
{
    NSString *content = card.isChosen ? card.contents : @"";
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}] ;
    //[[NSMutableAttributedString alloc] initWithString:content]];
    
    //return card.isChosen ? card.contents : @"";
    return resultAttributedString;
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
