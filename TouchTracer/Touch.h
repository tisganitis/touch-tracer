//
//  Touch.h
//  TouchTracer
//
//  Created by Tim Isganitis on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Apple's UITouch class documentation explicitly discourages retaining UITouch objects when handling events. As such, this class is a simple store for persisting information copied from a UITouch object during event processing.
 
 Note, however, that the "Handling a Complex Multitouch Sequence" section of the "Event Handling Guide for iOS" suggests that the UITouch memory address may be used as a key to reliably identify UITouch objects throughout the touch sequence. So, |Touch| objects store the corresponding UITouch's address to use in |isEqual:| and |hash|. 
 */
@interface Touch : NSObject <NSCopying>

@property (assign, nonatomic) CGPoint locationInView;
@property (assign, nonatomic, readonly) NSUInteger touchAddress;
@property (weak, nonatomic) UIView *view;

- (id)initWithUITouch:(UITouch *)touch;

@end
