//
//  TouchGestureRecognizer.h
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchGestureRecognizer : UIGestureRecognizer

@property (nonatomic, readonly) NSSet *currentTouches;

@end
