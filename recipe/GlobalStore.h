//
//  GlobalStore.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "recipeGlobal.h"

@interface GlobalStore : NSObject
{
    User* _loggedUser;
    NSMutableDictionary *_categories;
}

@property (nonatomic) User *loggedUser;

+ (GlobalStore *) sharedStore;

+ (NSString*) imageLinkWithImageId:(NSString*)imageId forWidth:(NSInteger)width andHeight:(NSInteger)height;
+ (NSString*) loginLink;
+ (NSString*) registerLink;
+ (NSString*) categoriesLink;
+ (NSString*) recipesLink;

+ (NSString*) searchLink;


- (void)setLoggedUser:(User *)loggedUser;
- (User*)loggedUser;

- (void)setCategories:(NSMutableDictionary *)categories;
- (NSMutableDictionary *)categories;

@end
