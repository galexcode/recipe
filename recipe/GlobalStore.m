//
//  GlobalStore.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "GlobalStore.h"

static GlobalStore *sharedStore = nil;

@implementation GlobalStore

+ (GlobalStore *)sharedStore
{
    @synchronized (self) {
        if (sharedStore == nil) {
            [[self alloc] init];
        }
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedStore == nil) {
            sharedStore = [super allocWithZone:zone];
            return sharedStore;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)init
{
    @synchronized(self) {
        self = [super init];
        _loggedUser = [[User alloc] init];
        _categories = [[NSMutableDictionary alloc] init];
        return self;
    }
}

#pragma mark Global Logged User
- (void)setLoggedUser:(User *)loggedUser
{
    @synchronized(self) {
        if (_loggedUser != loggedUser) {
            _loggedUser = nil;
            _loggedUser = loggedUser;
        }
    }
}

- (User *)loggedUser
{
    @synchronized(self) {
        return _loggedUser;
    }
}

#pragma mark Global category list
- (void)setCategories:(NSMutableDictionary *)categories
{
    @synchronized(self) {
        if (_categories != categories) {
            _categories = nil;
            _categories = categories;
        }
    }
}

- (NSMutableDictionary *)categories
{
    @synchronized(self) {
        return _categories;
    }
}


@end
