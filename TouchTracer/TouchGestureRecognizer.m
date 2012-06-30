//
//  TouchGestureRecognizer.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "Touch.h"


@interface TouchGestureRecognizer () {
  
  NSMutableSet *_currentTouches;
  NSMutableDictionary *_touchesForUITouches;
}

@end


@implementation TouchGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action
{
  self = [super initWithTarget:target action:action];
  if( self )
  {
    _currentTouches = [NSMutableSet set];
    _touchesForUITouches = [NSMutableDictionary dictionary];
  }
  return self;
}

- (NSSet *)currentTouches 
{
  return _currentTouches;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UIGestureRecognizerState nextState = ([_touchesForUITouches count] == 0) ? UIGestureRecognizerStateBegan : UIGestureRecognizerStateChanged;
  NSMutableDictionary *newTouchesForUITouches = [NSMutableDictionary dictionaryWithCapacity:[touches count]];
  NSMutableSet *newTouches = [NSMutableSet setWithCapacity:[touches count]];
  for( UITouch *uiTouch in touches )
  {
    Touch *newTouch = [[Touch alloc] initWithUITouch:uiTouch];
    [newTouches addObject:newTouch];
    [newTouchesForUITouches setObject:newTouch forKey:[self keyForUITouch:uiTouch]];
  }
  [self willChangeValueForKey:@"currentTouches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:newTouches];
  [_currentTouches unionSet:newTouches];
  [_touchesForUITouches addEntriesFromDictionary:newTouchesForUITouches];
  [self didChangeValueForKey:@"currentTouches" withSetMutation:NSKeyValueUnionSetMutation usingObjects:newTouches];
  [self setState:nextState];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  for( UITouch *uiTouch in touches )
  {
    Touch *touch = [_touchesForUITouches objectForKey:[self keyForUITouch:uiTouch]];
    [touch setLocationInView:[uiTouch locationInView:[touch view]]];
  }
  [self setState:UIGestureRecognizerStateChanged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSMutableSet *touchesToRemove = [NSMutableSet setWithCapacity:[touches count]];
  for( UITouch *uiTouch in touches ) 
  {
    Touch *touchForUITouch = [_touchesForUITouches objectForKey:[self keyForUITouch:uiTouch]];
    [touchesToRemove addObject:touchForUITouch];
  }
  [self willChangeValueForKey:@"currentTouches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:touchesToRemove];
  [_currentTouches minusSet:touchesToRemove];
  for( UITouch *uiTouch in touches ) 
  {
    [_touchesForUITouches removeObjectForKey:[self keyForUITouch:uiTouch]];
  }
  [self didChangeValueForKey:@"currentTouches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:touchesToRemove];
  [self setState:([_currentTouches count] == 0) ? UIGestureRecognizerStateEnded : UIGestureRecognizerStateChanged];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSSet *touchesToRemove = [_currentTouches copy];
  [self willChangeValueForKey:@"currentTouches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:touchesToRemove];
  [_currentTouches removeAllObjects];
  [_touchesForUITouches removeAllObjects];
  [self didChangeValueForKey:@"currentTouches" withSetMutation:NSKeyValueMinusSetMutation usingObjects:touchesToRemove];
  [self setState:UIGestureRecognizerStateCancelled];
}

/**
 The |UITouch| documentation forbids retaining UITouch objects during processing. However, the "Handling a Complex Multitouch Sequence" section of the "Event Handling Guide for iOS" suggests that the UITouch memory address may be used as a key to reliably identify UITouch objects throughout the touch sequence.
 */
- (NSString *)keyForUITouch:(UITouch *)touch
{
  return [NSString stringWithFormat:@"%p", touch];
}

@end
