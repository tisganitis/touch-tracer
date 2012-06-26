//
//  Circle.h
//  TouchTracer
//
//  Created by Tim Isganitis on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Circle : NSObject

@property (assign, nonatomic) CGPoint center;
@property (nonatomic) UIColor *color;
@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) CGFloat strokeWidth;

@end
