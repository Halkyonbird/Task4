	//
//  CardView.m
//  Task1
//
//  Created by User on 25.07.15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "CardView.h"
#import "ViewController.h"
#import "PlayingCard.h"

@implementation CardView
@synthesize rank;
@synthesize suit;

static float HORIZONT_OFFSET = 0.03;
static float VERTICAL_OFFSET = 0.08;
static float FONT_SIZE = 10.0;

- (void)drawRect:(CGRect)rect {
    [self setOpaque];
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3.0];
    [roundedRect addClip];
    UIColor *backColor, *strokeColor;
    if (self.isDisabled) {
        backColor = [UIColor lightGrayColor];
        strokeColor = [UIColor grayColor];
    } else {
        backColor = [UIColor whiteColor];
        strokeColor = [UIColor blackColor];
    }
    [backColor setFill];
    [roundedRect fill];
    
    
    if (self.isOpen) { // draw front of the card

        NSMutableAttributedString * attrSuitText = [[NSMutableAttributedString alloc] initWithAttributedString:self.suit];
        NSMutableAttributedString * attrCornerText = [[NSMutableAttributedString alloc] initWithString:[[PlayingCard rankStrings] objectAtIndex:self.rank]];
        [attrCornerText appendAttributedString:attrSuitText];
        
        BOOL isRedCard = [[self.suit string] containsString:@"♦︎"] || [[self.suit string] containsString:@"♥︎"];
        UIColor *fontColor = isRedCard ? [UIColor redColor] : [UIColor blackColor];
        
        // draw attrSuitText at the central position of our view
        [attrSuitText addAttributes:@{NSForegroundColorAttributeName:fontColor, NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]} range:NSMakeRange(0, [attrSuitText length])];
        
        
        CGSize textSize = [attrSuitText size];
        [attrSuitText drawAtPoint:CGPointMake(self.bounds.size.width/2 - textSize.width/2, self.bounds.size.height/2 - textSize.height/2)];

        // draw attrCornerText at the corner positions of our view
        [attrCornerText addAttributes:@{NSForegroundColorAttributeName:fontColor, NSFontAttributeName:[UIFont fontWithName:@"Arial" size:FONT_SIZE]} range:NSMakeRange(0, [attrCornerText length])];
        textSize = [attrCornerText size];
        [attrCornerText drawAtPoint:CGPointMake(self.bounds.size.width * VERTICAL_OFFSET, self.bounds.size.height * HORIZONT_OFFSET)];
        [attrCornerText drawAtPoint:CGPointMake(self.bounds.size.width - textSize.width - self.bounds.size.width * VERTICAL_OFFSET, self.bounds.size.height - textSize.height - self.bounds.size.height * HORIZONT_OFFSET)];
        
        
    } else { // draw back of the card
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
//        [UIView transitionWithView:self duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds]; } completion:^(BOOL finished) {            NSLog(@"Completed qqq!");        }];
    }
    [strokeColor setStroke];
    [roundedRect stroke];
}

#pragma mark - Initialization

- (void)setOpaque
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}

- (void)awakeFromNib
{
    [self setOpaque];  
}

@end
