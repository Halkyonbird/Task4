//
//  FallBehavior.m
//  Task1
//
//  Created by User on 03.08.15.
//  Copyright (c) 2015 Alexey Sheverdin. All rights reserved.
//

#import "FallBehavior.h"

@interface FallBehavior ()

@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;

@end

@implementation FallBehavior

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collision];
        [self addChildBehavior:self.animationOptions];
    }
    return self;
}

- (UIGravityBehavior *)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.7;
    }
    return _gravity;
}

- (UICollisionBehavior *)collision {
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        UIEdgeInsets inset;
        inset.left = 20.0;
        inset.top = 70.0;
        inset.bottom = 130.;
        inset.right = 20.0;
        [_collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:inset];
        _collision.collisionMode = UICollisionBehaviorModeBoundaries;
    }
    
    return _collision;
}

- (UIDynamicItemBehavior *)animationOptions {
    if (!_animationOptions) {
        _animationOptions = [[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation = YES;
        _animationOptions.elasticity = 1.0;
    }
    return _animationOptions;
}

- (void)addItem:(id <UIDynamicItem>)item {
    [self.gravity addItem:item];
    [self.collision addItem:item];
    [self.animationOptions addItem:item];
}
- (void)removeItem:(id <UIDynamicItem>)item {
    [self.gravity removeItem:item];
    [self.collision removeItem:item];
    [self.animationOptions removeItem:item];
}

@end
