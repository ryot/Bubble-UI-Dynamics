//
//  RTBubbleView.m
//  Bubble UI Dynamics
//
//  Created by Ryo Tulman on 3/3/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTBubbleView.h"

@implementation RTBubbleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.114 green: 0.705 blue: 1 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.8 green: 0.933 blue: 1 alpha: 1];

    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)color.CGColor,
                               (id)[UIColor colorWithRed: 0.557 green: 0.852 blue: 1 alpha: 1].CGColor,
                               (id)[UIColor whiteColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 0.49, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    CGContextSaveGState(context);
    [ovalPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width/2, 0), CGPointMake(rect.size.width/2, rect.size.width), 0);
    CGContextRestoreGState(context);
    [color2 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}



@end
