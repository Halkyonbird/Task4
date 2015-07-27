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
#import "CardView.h"

@interface ViewController : UIViewController

// protected
// for subclasses

- (Desk *)createDesk; // absract method

@end

