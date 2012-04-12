//
//  ApplicationService.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 OngSoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"

@interface ApplicationService : NSObject{
    NSMutableArray* _categories;
}

-(NSMutableArray*) categories;
-(void) loadCategories;
-(void) gotCategoriesByRequest: (ASI2HTTPRequest*)request;
-(void) didParsedCategories;

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
