//
//  CircleView.h
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (nonatomic) NSArray *circleCenters;
@property (nonatomic) UIColor *circleColor;
@property (nonatomic) CGFloat circleRadius;
@property (nonatomic) CGFloat strokeWidth;

@end
