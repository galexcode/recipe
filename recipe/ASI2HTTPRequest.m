//
//  ASI2HTTPRequest.m
//  recipe
//
//  Created by SaRy on 4/12/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "ASI2HTTPRequest.h"

@implementation ASI2HTTPRequest

-(void) dealloc
{
    [_target release];
    [super dealloc];
}

-(void) setTarget:(id)target andAction:(SEL)action
{
    _target = target;
    _action = action;
}

/* ALWAYS CALLED ON MAIN THREAD! */
- (void)reportFinished
{
    if (_target && [_target respondsToSelector:_action])
        [_target performSelector:_action withObject:self];
    [super reportFinished];
}

/* ALWAYS CALLED ON MAIN THREAD! */
- (void)reportFailure
{
    if (_target && [_target respondsToSelector:_action])
        [_target performSelector:_action withObject:self];
    [super reportFailure];
}

@end
