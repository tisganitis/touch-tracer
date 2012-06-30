//
//  CircleView.h
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Draws the specified set of circles with customizable radius, color and stroke width.
 */
@interface CircleView : UIView

@property (nonatomic) NSArray *circles;
@property (assign, nonatomic) BOOL showFPS;

@end
