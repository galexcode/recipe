//
//  Step.m
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Step.h"

@implementation Step
@synthesize stepId = _stepId;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize note = _note;
@synthesize imagePath = _imagePath;
@synthesize order = _order;

- (id)init
{
    self = [super init];
    if (self) {
        _stepId = nil;
        _name = nil;
        _desc = nil;
        _note = nil;
        _imagePath = nil;
        _order = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [_stepId release];
    [_name release];
    [_desc release];
    [_note release];
    [_imagePath release];
    [super dealloc];
}

@end
