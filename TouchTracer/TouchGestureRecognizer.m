//
//  TouchGestureRecognizer.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>


@interface TouchGestureRecognizer () {
  
  NSMutableSet *_currentTouches;
}

@end


@implementation TouchGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action
{
  self = [super initWithTarget:target action:action];
  if( self )
  {
    _currentTouches = [NSMutableSet set];
  }
  return self;
}

- (NSSet *)currentTouches 
{
  return _currentTouches;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UIGestureRecognizerState nextState = ([_currentTouches count] == 0) ? UIGestureRecognizerStateBegan : UIGestureRecognizerStateChanged;
  [_currentTouches addObjectsFromArray:[touches allObjects]];
  [self setState:nextState];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self setState:UIGestureRecognizerStateChanged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  for( NSObject *touch in touches ) {
    [_currentTouches removeObject:touch];
  }
  [self setState:([_currentTouches count] == 0) ? UIGestureRecognizerStateEnded : UIGestureRecognizerStateChanged];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self setState:UIGestureRecognizerStateCancelled];
}

@end
