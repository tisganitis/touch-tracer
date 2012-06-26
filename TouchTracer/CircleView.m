//
//  CircleView.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircleView.h"

#import "Circle.h"


@implementation CircleView

@synthesize circles = _circles;

- (void)drawRect:(CGRect)rect
{
  if( _circles && [_circles count] > 0 )
  {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for( Circle *circle in _circles )
    {
      [[circle color] setStroke];
      CGContextSetLineWidth(context, [circle strokeWidth]);
      CGPoint circleCenter = [circle center];
      CGFloat radius = [circle radius];
      CGFloat diameter = 2 * radius;
      CGRect circleFrame = CGRectZero;
      circleFrame.origin.x = circleCenter.x - radius;
      circleFrame.origin.y = circleCenter.y - radius;
      circleFrame.size = CGSizeMake(diameter, diameter);
      CGContextStrokeEllipseInRect(context, circleFrame);
    }
  }
}

- (void)setCircles:(NSArray *)circles
{
  if( _circles != circles )
  {
    _circles = circles;
    [self setNeedsDisplay];
  }
}

@end
