		//
//  ViewController.h
//  Task1
//
//  Created by Alexey Sheverdin on 7/3/15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desk.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// !!! ask Rost more about public-private-protected in objective-c
// protected
// for subclasses

- (Desk *)createDesk; // absract method

@end

