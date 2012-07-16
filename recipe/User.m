//
//  User.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize userId = _userId;
@synthesize name = _name;
@synthesize email = _email;
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
        _userId = @"-1";
        _name = nil;
        _email = nil;
        _password = nil;
        _avatarId = @"-1";
        _recipeCount = 0;
        _followingCount = 0;
        _followerCount = 0;
        _recipes = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
