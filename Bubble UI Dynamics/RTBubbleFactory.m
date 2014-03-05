//
//  RTBubbleFactory.m
//  Bubble UI Dynamics
//
//  Created by Ryo Tulman on 3/3/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTBubbleFactory.h"
#import "RTBubbleView.h"

@implementation RTBubbleFactory

+ (RTBubbleView *)generateBubble {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSInteger size = arc4random_uniform(100);
    while (size < 40) {
        size = arc4random_uniform(100);
    }
    NSInteger x = screenRect.size.width/2;
    NSInteger y = size;
    RTBubbleView *newBubble = [[RTBubbleView alloc] initWithFrame:CGRectMake(x, y, size, size)];
    //spawn inner bubbles
    for (int i = 0; i < 3; i++) {
        size = newBubble.frame.size.width/4;
        RTBubbleView *tinyBubble;
        if (i == 0) {
            tinyBubble = [[RTBubbleView alloc] initWithFrame:CGRectMake(size, size, size, size)];
        } else if (i == 1) {
            tinyBubble = [[RTBubbleView alloc] initWithFrame:CGRectMake(size*2.5, size, size, size)];
        } else if (i == 2) {
            tinyBubble = [[RTBubbleView alloc] initWithFrame:CGRectMake(size*1.25, size*2.5, size, size)];
        }
        [newBubble addSubview:tinyBubble];
    }
    return newBubble;
}

@end
