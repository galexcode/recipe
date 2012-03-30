//
//  User.m
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize userId = _userId;
@synthesize name = _name;
@synthesize password = _password;

- (id)init
{
    self = [super init];
    if (self) {
        _userId = nil;
        _name = nil;
        _password = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_userId release];
    [_name release];
    [_password release];
    [super dealloc];
}

@end
