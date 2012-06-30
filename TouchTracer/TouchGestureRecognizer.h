//
//  TouchGestureRecognizer.h
//  TouchTracer
//
//  Created by Tim Isganitis on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 A gesture recognizer that persists touch information over time. The standard gesture recognizers expose a set of touch locations at any given instant, but do not provide a means of associating any particular touch with any previous or future locations. This recognizer associates each individual touch with a unique, persistent |Touch| object that is updated as the touch moves.
 */
@interface TouchGestureRecognizer : UIGestureRecognizer

/**
 A set of |Touch| objects representing all currently active touches received by this gesture recognizer. Each |Touch| object corresponds to a single on-screen touch from beginning to end.
 */
@property (nonatomic, readonly) NSSet *currentTouches;

@end
