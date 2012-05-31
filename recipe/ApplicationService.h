//
//  ApplicationService.h
//
//  Created by Vu Tran on 4/12/12.
//  Copyright 2011 Perselab. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"
#import "UserXMLHandler.h"
#import "CategoriesXMLHandler.h"

@protocol ApplicationServiceDelegate

@optional
//Register
-(void) didFinishRegisterUser:(__weak User *)registerUser;
//Login
-(void) didFinishVerifyUser:(__weak User *)loggedUser;
//Profile
-(void) didFinishParsedUser:(__weak User *)user;
//Categories
-(void) didFinishParsedCategories:(__weak NSMutableDictionary *)categoryDictionary;

@end

@interface ApplicationService : NSObject{
    __weak User* _user;
    NSMutableArray* _categories;
    NSMutableArray* _recipes;
    __weak NSMutableDictionary* _categoryDictionary;
    __weak id<ApplicationServiceDelegate> _delegate;
}

@property (nonatomic, weak) id<ApplicationServiceDelegate> delegate;

#pragma mark Register User
-(void) registerUser:(__weak User*)registerUser;
-(void) gotRegisteredUserByRequest:(ASI2HTTPRequest *)request;
-(void) didParsedRegisteredUser;

#pragma mark Check Logging User
-(void) verifyUser: (__weak User*)loggingUser;
-(void) gotLoggingUserByRequest:(ASI2HTTPRequest *)request;
-(void) didParsedLoggingUser;

#pragma mark Load User Profile
-(void) loadUser:(__weak User*)user;
-(void) gotUserByRequest: (ASI2HTTPRequest*)request;
-(void) didParsedUser;

#pragma mark Load Categories
-(NSMutableArray*) categories;

-(void) loadCategories:(__weak NSMutableDictionary*)categoryDictionary;
-(void) gotCategoriesByRequest: (ASI2HTTPRequest*)request;
-(void) didParsedCategories;

#pragma mark Load Recipes
-(NSMutableArray*) recipes;

-(void) loadRecipesForCategory: (NSString*)categoryId;
-(void) loadRecipesForUser: (NSString*)userId;
-(void) loadRecipesByKeywords: (NSString*)keywords;

-(void) gotRecipesByRequest: (ASI2HTTPRequest*)request;
-(void) didParsedRecipes;


//other loading function go here

-(void) gotErrorByRequest: (ASI2HTTPRequest*)request;
-(void) requestStatusHandler: (ASI2HTTPRequest*)request;


//-(NSMutableArray*) fruitList;
//-(NSMutableArray*) entries;
//
//-(void) loadEntries;
//-(void) gotEntries: (NSData*)data byRequest:(HttpRequest*)req;
//-(void) didParsedEntries;
//
//-(void) addEntry: (Entry*)entry;
//-(void) finishAddingEntry:(NSData*)data byRequest:(HttpRequest*)req;
//
//-(void) removeEntry: (Entry*)entry;
//-(void) finishRemovingEntry:(NSData*)data byRequest:(HttpRequest*)req;
//
//-(void) loadAllData;
//-(void) gotFruits: (NSData*)data byRequest:(HttpRequest*)req;
//-(void) didParsedFruits;
//
//-(void) addOrEditFruitBag:(FruitBag*)fruitbag toEntry:(Entry*)entry;
//-(void) finishAddingFruitBag:(NSData*)data byRequest:(HttpRequest*)req;
//
//-(void) removeFruitBag:(FruitBag*)fruitBag fromEntry:(Entry*)entry;
//-(void) finishRemovingFruitBag:(NSData*)data byRequest:(HttpRequest*)req;
//
//-(void) loadFruitImage: (Fruit*) fruit;
//-(void) finishLoadingFruiImage:(NSData*)data byRequest:(HttpRequest*)req;
@end
