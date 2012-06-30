//
//  ViewController.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "Circle.h"
#import "CircleView.h"
#import "Touch.h"
#import "TouchGestureRecognizer.h"


#define CIRCLE_RADIUS 50.f
#define CIRCLE_STROKE_WIDTH 15.f


@interface ViewController () {

  NSMutableDictionary *_circlesForTouches;
  NSInteger _index;
  TouchGestureRecognizer *_touchGestureRecognizer;
}

@end


@implementation ViewController

@synthesize circleView = _circleView;

#pragma mark - Object Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if( self )
  {
    _circlesForTouches = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)dealloc
{
  [_touchGestureRecognizer removeObserver:self forKeyPath:@"currentTouches"];
}

#pragma mark - UIView

- (void)viewDidLoad
{
  [super viewDidLoad];

  [_circleView setMultipleTouchEnabled:YES];
  [_circleView setShowFPS:YES];
  
  _touchGestureRecognizer = [[TouchGestureRecognizer alloc] initWithTarget:self action:@selector(updateTouches:)];
  [_touchGestureRecognizer addObserver:self 
                            forKeyPath:@"currentTouches" 
                               options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) 
                               context:nil];
  [_circleView addGestureRecognizer:_touchGestureRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

#pragma mark -

// KVO is used to determine when individual touches begin and end via the |currentTouches| set.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if( object == _touchGestureRecognizer && [keyPath isEqualToString:@"currentTouches"] )
  {
    NSSet *newTouches = [change objectForKey:@"new"];
    for( Touch *touch in newTouches )
    {
      Circle *circle = [[Circle alloc] init];
      [circle setCenter:[touch locationInView]];
      [circle setColor:[self colorForIndex:_index++]];
      [circle setRadius:CIRCLE_RADIUS];
      [circle setStrokeWidth:CIRCLE_STROKE_WIDTH];
      
      [_circlesForTouches setObject:circle forKey:touch];
    }
    
    NSSet *endedTouches = [change objectForKey:@"old"];
    for( UITouch *touch in endedTouches )
    {
      [_circlesForTouches removeObjectForKey:touch];
    }
    
    if( [_circlesForTouches count] == 0 ) {
      _index = 0;
    }
  }
}

// The GR target is used to monitor changes to the locations of the touches.
- (void)updateTouches:(TouchGestureRecognizer *)gestureRecognizer
{
  UIGestureRecognizerState state = [gestureRecognizer state];
  
  if( state == UIGestureRecognizerStateBegan ||
      state == UIGestureRecognizerStateChanged ) 
  { 
    for( Touch *touch in [gestureRecognizer currentTouches] )
    {
      Circle *circle = [_circlesForTouches objectForKey:touch];
      if( circle ) {
        [circle setCenter:[touch locationInView]];
      }
    }
  }
  [_circleView setCircles:[_circlesForTouches allValues]];
}

- (UIColor *)colorForIndex:(NSInteger)index
{
  switch( index )
  {
    case 0:
      return [UIColor greenColor];
    case 1:
      return [UIColor yellowColor];
    case 2:
      return [UIColor orangeColor];
    case 3:
      return [UIColor cyanColor];
    case 4:
      return [UIColor redColor];
    case 5: 
      return [UIColor blueColor];
    case 6:
      return [UIColor magentaColor];
    case 7:
      return [UIColor blackColor];
    case 8:
      return [UIColor purpleColor];
    case 9:
      return [UIColor grayColor];
    default:
      return [UIColor colorWithRed:(arc4random() % 256) / 256.f 
                             green:(arc4random() % 256) / 256.f 
                              blue:(arc4random() % 256) / 256.f
                             alpha:1.f];
  }
}

@end
