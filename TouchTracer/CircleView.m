//
//  CircleView.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircleView.h"

#import "Circle.h"


#define FPS_FRAME (CGRect){{20.f,20.f},{200.f, 30.f}}
#define FPS_UPDATE_INTERVAL 0.5
#define TARGET_FPS 40


@interface CircleView () {
  
  NSInteger _drawRectCount;
  double _fps;
  UIFont *_fpsFont;
  NSDate *_lastFPSSampleTime;
  dispatch_source_t _timer;
}

@end


@implementation CircleView

@synthesize circles = _circles;
@synthesize showFPS = _showFPS;

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if( self )
  {
    _fpsFont = [UIFont systemFontOfSize:17.f];
    _lastFPSSampleTime = [NSDate date];
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    uint64_t nanoSecondInterval = 1000000000/TARGET_FPS;
    uint64_t nanoSecondLeeway = nanoSecondInterval / 2;
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), nanoSecondInterval, nanoSecondLeeway);
    dispatch_source_set_event_handler(_timer, ^{
      [self setNeedsDisplay];
    });
    dispatch_resume(_timer);
  }
  return self;
}

- (void)dealloc
{
  dispatch_source_cancel(_timer);
}

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
  
  if( _showFPS )
  {
    _drawRectCount++;
    NSString *fpsString = [NSString stringWithFormat:@"%.1f", _fps];
    [fpsString drawInRect:FPS_FRAME withFont:_fpsFont];
        
    NSTimeInterval secondsSinceLastSample = fabs([_lastFPSSampleTime timeIntervalSinceNow]);
    if( secondsSinceLastSample > FPS_UPDATE_INTERVAL )
    {
      _fps = _drawRectCount / secondsSinceLastSample;
      
      _lastFPSSampleTime = [NSDate date];
      _drawRectCount = 0;
    }
  }
}

- (void)setCircles:(NSArray *)circles
{
  if( _circles != circles )
  {
    _circles = circles;
  }
}

- (void)setShowFPS:(BOOL)showFPS
{
  if( _showFPS != showFPS )
  {
    _showFPS = showFPS;
    if( _showFPS ) 
    {
      _lastFPSSampleTime = [NSDate date];
      _drawRectCount = 0;
    }
  }
}

@end
