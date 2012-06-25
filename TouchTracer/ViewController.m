//
//  ViewController.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "CircleView.h"
#import "TouchGestureRecognizer.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize circleView = _circleView;

- (void)viewDidLoad
{
  [super viewDidLoad];

  [_circleView setCircleColor:[UIColor greenColor]];
  [_circleView setCircleRadius:50.f];
  [_circleView setMultipleTouchEnabled:YES];
  [_circleView setStrokeWidth:20.f];
  
  TouchGestureRecognizer *gestureRecognizer = [[TouchGestureRecognizer alloc] initWithTarget:self action:@selector(updateTouches:)];
  [_circleView addGestureRecognizer:gestureRecognizer];
}

- (void)updateTouches:(TouchGestureRecognizer *)gestureRecognizer
{
  NSMutableArray *touchPoints = [NSMutableArray array];
  UIGestureRecognizerState state = [gestureRecognizer state];
  if( state == UIGestureRecognizerStateBegan ||
      state == UIGestureRecognizerStateChanged ) 
  { 
    for( UITouch *touch in [gestureRecognizer currentTouches] )
    {
      CGPoint touchPoint = [touch locationInView:_circleView];
      [touchPoints addObject:[NSValue valueWithCGPoint:touchPoint]];
    }
    
  }
  [_circleView setCircleCenters:touchPoints];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

@end
