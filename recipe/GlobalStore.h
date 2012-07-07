//
//  GlobalStore.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJObjManager.h"
#import "recipeGlobal.h"

@interface GlobalStore : NSObject
{
    User* _loggedUser;
    HJObjManager* _objMan;
    NSMutableDictionary *_categories;
}

@property (nonatomic) User *loggedUser;

+ (NSString*)encryptionKey;
+ (GlobalStore *) sharedStore;

+ (NSString*) imageLinkWithImageId:(NSString*)imageId forWidth:(NSInteger)width andHeight:(NSInteger)height;
+ (NSString*) loginLink;
+ (NSString*) registerLink;
+ (NSString*) categoriesLink;
+ (NSString*) recipesLink;
+ (NSString*) addRecipeLink;
+ (NSString*) updateRecipeLink;
+ (NSString*) deleteRecipeLink;
+ (NSString*) addIngredientLink;
+ (NSString*) addStepLink;

+ (NSString*) searchLink;


- (void)setLoggedUser:(User *)loggedUser;
- (User*)loggedUser;

- (HJObjManager*)objectManager;

- (void)setCategories:(NSMutableDictionary *)categories;
- (NSMutableDictionary *)categories;

@end
