//
//  CircleView.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView

@synthesize circleCenters = _circleCenters;
@synthesize circleColor = _circleColor;
@synthesize circleRadius = _circleRadius;
@synthesize strokeWidth = _strokeWidth;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) 
  {
    [self initializeDefaults];
    
  }
  return self;
}

- (void)awakeFromNib
{
  [self initializeDefaults];
}

- (void)initializeDefaults
{
  _circleColor = [UIColor blackColor];
  _circleRadius = 50.f;
  _strokeWidth = 5.f;
}

- (void)drawRect:(CGRect)rect
{
  if( _circleCenters && [_circleCenters count] > 0 )
  {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_circleColor setStroke];
    CGContextSetLineWidth(context, _strokeWidth);
    
    CGFloat frameSideLength = 2 * _circleRadius;
    CGRect circleFrame = CGRectMake(-_circleRadius, -_circleRadius, frameSideLength, frameSideLength);
    
    CGPoint previousCenter = CGPointZero;
    for( NSValue *circleCenterValue in _circleCenters )
    {
      CGPoint circleCenter = [circleCenterValue CGPointValue];
      CGContextTranslateCTM(context, (circleCenter.x - previousCenter.x), (circleCenter.y - previousCenter.y));
      CGContextStrokeEllipseInRect(context, circleFrame);
      previousCenter = circleCenter;
    }
  }
}

- (void)setCircleCenters:(NSArray *)circleCenters
{
  if( _circleCenters != circleCenters )
  {
    _circleCenters = circleCenters;
    [self setNeedsDisplay];
  }
}
@end
