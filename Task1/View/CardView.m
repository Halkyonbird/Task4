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
@synthesize rank = _rank;
@synthesize suit = _suit;

static float HORIZONT_OFFSET = 0.08;
static float VERTICAL_OFFSET = 0.03;
static float FONT_SIZE = 10.0;

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSAttributedString *)suit {
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context); // save context
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
    CGContextRestoreGState(context); // restore context
    
    if (self.isOpen) { // draw front of the card
        NSMutableAttributedString * attrSuitText = [[NSMutableAttributedString alloc] initWithAttributedString:self.suit];
        NSMutableAttributedString * attrCornerText = [[NSMutableAttributedString alloc] initWithString:[[PlayingCard rankStrings] objectAtIndex:self.rank]];
        [attrCornerText appendAttributedString:attrSuitText];
        BOOL isRedCard = [[self.suit string] containsString:@"♦︎"] || [[self.suit string] containsString:@"♥︎"];
        UIColor *fontColor = isRedCard ? [UIColor redColor] : [UIColor blackColor];
        [attrSuitText addAttributes:@{NSForegroundColorAttributeName:fontColor, NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}
                              range:NSMakeRange(0, [attrSuitText length])];
        // draw attrCornerText at the corner positions of our view
        [attrCornerText addAttributes:@{NSForegroundColorAttributeName:fontColor, NSFontAttributeName:[UIFont fontWithName:@"Arial" size:FONT_SIZE]}
                                range:NSMakeRange(0, [attrCornerText length])];
        CGSize textSize = [attrCornerText size];
        CGContextSaveGState(context); // save context
        // translate and rotate coordinate space before drawing right bottom corner text
        CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
        CGContextRotateCTM (context, M_PI);
        // draw right bottom corner text
        [attrCornerText drawAtPoint:CGPointMake(self.bounds.size.width * HORIZONT_OFFSET, self.bounds.size.height * VERTICAL_OFFSET)];
        CGContextRestoreGState(context); // restore context
        // draw left up corner text
        [attrCornerText drawAtPoint:CGPointMake(self.bounds.size.width * HORIZONT_OFFSET, self.bounds.size.height * VERTICAL_OFFSET)];
        // draw attrSuitText (suit) at the central position of our view
        textSize = [attrSuitText size];
        [attrSuitText drawAtPoint:CGPointMake(self.bounds.size.width/2 - textSize.width/2, self.bounds.size.height/2 - textSize.height/2)];
        
    } else { // draw back of the card
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
    CGContextSaveGState(context); // save context
    [strokeColor setStroke];
    [roundedRect stroke];
    CGContextRestoreGState(context); // restore context
}

#pragma mark - Initialization

- (void)setOpaque {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}

- (void)awakeFromNib {
    [self setOpaque];
    self.startFrame = self.frame;
}

@end
