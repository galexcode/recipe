//
//  ApplicationService.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Entry.h"
#import "Fruit.h"
#import "FruitBag.h"
#import "HttpRequest.h"

@interface ApplicationService : NSObject {
	NSMutableArray*	_fruitList;
	NSMutableArray*	_entries;
	
}

-(NSMutableArray*) fruitList;
-(NSMutableArray*) entries;


-(void) loadEntries;
-(void) gotEntries: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedEntries;

-(void) addEntry: (Entry*)entry;
-(void) finishAddingEntry:(NSData*)data byRequest:(HttpRequest*)req;

-(void) removeEntry: (Entry*)entry;
-(void) finishRemovingEntry:(NSData*)data byRequest:(HttpRequest*)req;

-(void) loadAllData;
-(void) gotFruits: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedFruits;

-(void) addOrEditFruitBag:(FruitBag*)fruitbag toEntry:(Entry*)entry;
-(void) finishAddingFruitBag:(NSData*)data byRequest:(HttpRequest*)req;

-(void) removeFruitBag:(FruitBag*)fruitBag fromEntry:(Entry*)entry;
-(void) finishRemovingFruitBag:(NSData*)data byRequest:(HttpRequest*)req;

-(void) loadFruitImage: (Fruit*) fruit;
-(void) finishLoadingFruiImage:(NSData*)data byRequest:(HttpRequest*)req;
@end
