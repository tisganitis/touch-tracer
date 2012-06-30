//
//  Touch.m
//  TouchTracer
//
//  Created by Tim Isganitis on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Touch.h"


@implementation Touch

@synthesize locationInView = _locationInView;
@synthesize touchAddress = _touchAddress;
@synthesize view = _view;

- (id)initWithUITouch:(UITouch *)touch
{
  self = [super init];
  if( self )
  {
    _view = [touch view];
    _locationInView = [touch locationInView:_view];
    _touchAddress = (NSUInteger)touch;
  }
  return self;
}

- (id)initWithTouch:(Touch *)touch
{
  self = [super init];
  if( self )
  {
    _locationInView = [touch locationInView];
    _view = [touch view];
    _touchAddress = [touch touchAddress];
  }
  return self;
}

- (Touch *)copyWithZone:(NSZone *)zone
{
  Touch *copy = [[Touch allocWithZone:zone] initWithTouch:self];
  return copy;
}

- (NSUInteger)hash
{
  return _touchAddress;
}

- (BOOL)isEqual:(id)object
{
  if( ![object isKindOfClass:[Touch class]] ) { return NO; }
  return _touchAddress == [(Touch *)object touchAddress];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"Touch (touchAddress = %u)", _touchAddress];
}

@end
