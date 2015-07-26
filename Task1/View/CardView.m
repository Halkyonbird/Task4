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

@interface CardView()
//- (void)tap:(UITapGestureRecognizer *)gesture fromCard:(id<PlayingCardView>) sender;
@end

@implementation CardView
@synthesize rank;
@synthesize suit;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self setOpaque];
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:	3.0];
    [roundedRect addClip];
    UIColor *backColor, *strokeColor;
    //UIColor *backColor = self.isDisabled ? [UIColor lightGrayColor] : [UIColor whiteColor];
    if (self.isDisabled) {
        backColor = [UIColor lightGrayColor];
        strokeColor = [UIColor grayColor];
    } else {
        backColor = [UIColor whiteColor];
        strokeColor = [UIColor blackColor];
    }
        
    [backColor setFill];
    [roundedRect fill];
    NSMutableAttributedString * attrStringSuit = [[NSMutableAttributedString alloc] initWithAttributedString:self.suit];
    NSMutableAttributedString * attrCardText = [[NSMutableAttributedString alloc] initWithString:[[PlayingCard rankStrings] objectAtIndex:self.rank]];
    [attrCardText appendAttributedString:attrStringSuit];
    if (self.isOpen) {
        BOOL isRedCard = [[self.suit string] containsString:@"♦︎"] || [[self.suit string] containsString:@"♥︎"]; // || [card.contents containsString:@"♥︎"];
        UIColor *fontColor = isRedCard ? [UIColor redColor] : [UIColor blackColor];
        [attrCardText addAttributes:@{NSForegroundColorAttributeName:fontColor} range:NSMakeRange(0, [attrCardText length])];

        CGSize textSize = [attrCardText size];
        [attrCardText drawAtPoint:CGPointMake(self.bounds.size.width/2 - textSize.width/2, self.bounds.size.height/2 - textSize.height/2)];
        [self setOpaque];
    } else {
        //CGRect imageRect = CGRectInset(self.bounds,                                       self.bounds.size.width * 0.1,                                       self.bounds.size.height * 0.1);
        //[[UIImage imageNamed:@"cardBack"] drawInRect:imageRect];
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
    [strokeColor setStroke];
    [roundedRect stroke];
}

#pragma mark - Initialization

- (void)setOpaque
{
    //self.backgroundColor = nil;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    //self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setOpaque];  
}

@end
