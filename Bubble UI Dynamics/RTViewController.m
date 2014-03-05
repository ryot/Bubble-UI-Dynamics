//
//  RTViewController.m
//  Bubble UI Dynamics
//
//  Created by Ryo Tulman on 3/3/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTViewController.h"
#import "RTBubbleView.h"
#import "RTBubbleFactory.h"

@interface RTViewController ()
{
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    UIDynamicItemBehavior *_itemBehavior;
}

@property (nonatomic, strong) NSMutableArray *bubbles;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RTViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f
                                                  target:self
                                                selector:@selector(timerUpdate)
                                                userInfo:nil
                                                 repeats:YES];
    
    RTBubbleView *newBubble = (RTBubbleView *)[RTBubbleFactory generateBubble];
    [self.view addSubview:newBubble];
    _itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:[NSArray arrayWithObject:newBubble]];
    _itemBehavior.elasticity = 0.5;
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc]initWithItems:[NSArray arrayWithObject:newBubble]];
    [_animator addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc] initWithItems:[NSArray arrayWithObject:newBubble]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    self.view.backgroundColor = [UIColor colorWithRed:0.630 green:0.908 blue:0.807 alpha:1.000];

}

-(void)timerUpdate {
    RTBubbleView *newBubble = (RTBubbleView *)[RTBubbleFactory generateBubble];
    [self.view addSubview:newBubble];
    [_gravity addItem:newBubble];
    [_collision addItem:newBubble];
    [_itemBehavior addItem:newBubble];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInView:self.view];
        for (RTBubbleView *bubble in self.view.subviews) {
            if (CGRectContainsPoint(bubble.frame, touchPoint)) {
                [self popThisBubble:bubble];
            }
        }
    }
}

-(void)popThisBubble:(RTBubbleView *)bubble {
    for (RTBubbleView *innerBubble in bubble.subviews) {
        [_collision addItem:innerBubble];
        [_gravity addItem:innerBubble];
        [_itemBehavior addItem:innerBubble];
        [self.view addSubview:innerBubble];
    }
    [_collision removeItem:bubble];
    [_gravity removeItem:bubble];
    [_itemBehavior removeItem:bubble];
    [bubble removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
