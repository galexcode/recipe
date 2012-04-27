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
@synthesize avatarId = _avatarId;
@synthesize recipeCount = _recipeCount;
@synthesize followingCount = _followingCount;
@synthesize followerCount = _followerCount;
@synthesize recipes = _recipes;

- (id)init
{
    self = [super init];
    if (self) {
        _userId = nil;
        _name = nil;
        _password = nil;
        _avatarId = [[NSString alloc] initWithString:@"-1"];
        _recipeCount = 0;
        _followingCount = 0;
        _followerCount = 0;
        _recipes = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
