//
//  User.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 OngSoft. All rights reserved.
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


@end
