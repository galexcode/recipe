//
//  GlobalStore.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#define BASE_URL @"http://www.perselab.com/recipe"

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
        _objMan = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
        NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/recipe/"];
        
        HJMOFileCache* fileCache = [[HJMOFileCache alloc] initWithRootPath:cacheDirectory];
        _objMan.fileCache = fileCache;
        
        // Have the file cache trim itself down to a size & age limit, so it doesn't grow forever
        fileCache.fileCountLimit = 100;
        fileCache.fileAgeLimit = 60*60*24*7; //1 week
        [fileCache trimCacheUsingBackgroundThread];
        
        _categories = [[NSMutableDictionary alloc] init];
        return self;
    }
}

#pragma mark Link Preconfig
+ (NSString*)imageLinkWithImageId:(NSString *)imageId forWidth:(NSInteger)width andHeight:(NSInteger)height
{
    NSString *size;
    
    if (width > 0 && height > 0) {
        size = [NSString stringWithFormat:@"%d/%d", width, height];
    } else if (height == 0 && width == 0) {
        size = @"";
    } else if (height == 0) {
        size = [NSString stringWithFormat:@"%d", width];
    } else {
        size = [NSString stringWithFormat:@"0/%d", height];
    }
    
    if ([size isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@/image/%@", BASE_URL, imageId];
    }
    return [NSString stringWithFormat:@"%@/image/%@/%@", BASE_URL, imageId, size];
}

+ (NSString*) loginLink
{
    return [NSString stringWithFormat:@"%@/login", BASE_URL];
}

+ (NSString*) registerLink
{
    return [NSString stringWithFormat:@"%@/register", BASE_URL];
}

+ (NSString*) categoriesLink
{
    return [NSString stringWithFormat:@"%@/categories", BASE_URL];
}

+ (NSString*) recipesLink
{
    return [NSString stringWithFormat:@"%@/recipes", BASE_URL];
}

+ (NSString*) searchLink
{
    return [NSString stringWithFormat:@"%@/search", BASE_URL];
}

+ (NSString*) addRecipeLink
{
    return [NSString stringWithFormat:@"%@/recipe/add", BASE_URL];
}

+ (NSString*) updateRecipeLink
{
    return [NSString stringWithFormat:@"%@/recipe/update", BASE_URL];
}

+ (NSString*) addIngredientLink
{
    return [NSString stringWithFormat:@"%@/ingredient/add", BASE_URL];
}

+ (NSString*) addStepLink
{
    return [NSString stringWithFormat:@"%@/step/add", BASE_URL];
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

- (HJObjManager*)objectManager
{
    @synchronized(self) {
        return _objMan;
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
