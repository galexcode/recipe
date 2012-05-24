//
//  Store.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "Store.h"

@implementation Store
@synthesize storeId = _storeId;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize location = _location;

- (id)init
{
    self = [super init];
    if (self) {
        _storeId = nil;
        _name = nil;
        _desc = nil;
        _location.latitude = 0;
        _location.longitude = 0;
    }
    
    return self;
}


@end
