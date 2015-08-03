//
//  CardView.h
//  Task1
//
//  Created by User on 25.07.15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayingCardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSAttributedString *suit;

@end

@interface CardView : UIView <PlayingCardView>

@property (nonatomic) BOOL isOpen;
@property (nonatomic) BOOL isDisabled;
@property (nonatomic) CGRect startFrame;

@end
