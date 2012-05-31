//
//  ApplicationService.m
//
//  Created by Vu Tran on 4/12/12.
//  Copyright 2011 Perselab. All rights reserved.
//

#import "ApplicationService.h"

@implementation ApplicationService
@synthesize delegate = _delegate;

-(id) init
{
	if (self = [super init]) {
        _categories = [[NSMutableArray alloc] init];
	} 
	return self;	
}

-(NSMutableArray*) categories
{
    return _categories;
}

-(NSMutableArray*) recipes
{
    return _recipes;
}

#pragma mark -

#pragma mark Register User
-(void) registerUser:(__weak User*)registerUser
{
    _user = registerUser;
    
    NSLog(@"Register user name %@", [registerUser name]);
    
//    NSURL *url = [NSURL URLWithString:@"http://www.domain.com/register"];
    
//    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
//    [request setPostValue:[registerUser name] forKey:@"u"];
//    [request setPostValue:[registerUser email] forKey:@"e"];
//    [request setPostValue:[registerUser password] forKey:@"p"];
//    
//    [request setTarget:self andAction:@selector(gotRegisteredUserByRequest:)];
    
//    [request startAsynchronous]
    
    [self gotRegisteredUserByRequest:nil];
}

-(void) gotRegisteredUserByRequest:(ASI2HTTPRequest *)request
{
    //    if (request.responseStatusCode == 200) {
    //        UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
    //        [handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser:)];
    //        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
    //        parser.delegate = handler;
    //        [parser parse];
    //    }else if(request.responseStatusCode == 404){
    //        [_delegate didFinishVerifyUser:nil];
    //    } else {
    //        [_delegate didFinishVerifyUser:nil];
    //    }
    [self didParsedRegisteredUser];
}

-(void) didParsedRegisteredUser
{
    [_delegate didFinishRegisterUser:_user];
}

#pragma mark Check User
-(void) verifyUser:(__weak User *)loggingUser
{
    _user = loggingUser;
    
//    [_user setUserId:@"1"];
//    [_user setName:@"my name"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/login.xml"];
    
    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
//    [request setPostValue:[loggingUser name] forKey:@"u"];
//    [request setPostValue:[loggingUser password] forKey:@"p"];
    
    [request setTarget:self andAction:@selector(gotLoggingUserByRequest:)];
    
    [request startAsynchronous];
    //[self gotLoggingUserByRequest:nil];
}

-(void) gotLoggingUserByRequest:(ASI2HTTPRequest *)request
{
    NSLog(@"%d", request.responseStatusCode);
    if (request.responseStatusCode == 200) {
        UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
        [handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser)];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
        parser.delegate = handler;
        [parser parse];
    }else if(request.responseStatusCode == 404){
        [_delegate didFinishVerifyUser:nil];
    } else {
        [_delegate didFinishVerifyUser:nil];
    }
    
    //[self didParsedLoggingUser];
}

-(void) didParsedLoggingUser
{
    [_delegate didFinishVerifyUser:_user];
    //_user = nil;
}

#pragma mark Loading User Profile
-(void) loadUser:(User *)user
{
    _user = user;
    
    NSURL *url = [NSURL URLWithString:@"http://www.checkuser.com/profile/"];
    
    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    [request setPostValue:[user userId] forKey:@"id"];
    
    [request setTarget:self andAction:@selector(gotUserByRequest:)];
    
    [request startAsynchronous];
}

-(void) gotUserByRequest:(ASI2HTTPRequest *)request
{
    if (request.responseStatusCode == 200) {
        UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
        [handler setEndDocumentTarget:self andAction:@selector(didParsedUser:)];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
        parser.delegate = handler;
        [parser parse];
    }else if(request.responseStatusCode == 404){
        [_delegate didFinishVerifyUser:nil];
    } else {
        [_delegate didFinishVerifyUser:nil];
    }
}

-(void) didParsedUser
{
    [_delegate didFinishParsedUser:_user];
}

#pragma mark load Categories
-(void) loadCategories:(__weak NSMutableDictionary*)categoryDictionary
{
    _categoryDictionary = categoryDictionary;
    
    NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/categories.xml"];
    
    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
//    [request setPostValue:@"1" forKey:@"rw_app_id"];
//    [request setPostValue:@"test" forKey:@"code"];
//    [request setPostValue:@"test" forKey:@"device_id"];

    [request setTarget:self andAction:@selector(gotCategoriesByRequest:)];
    
    [request startAsynchronous];
}

-(void) gotCategoriesByRequest:(ASI2HTTPRequest *)request
{
    if (request.responseStatusCode == 200) {
        CategoriesXMLHandler* handler = [[CategoriesXMLHandler alloc] initWithCategoryDictionary:_categoryDictionary];
        [handler setEndDocumentTarget:self andAction:@selector(didParsedCategories)];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
        parser.delegate = handler;
        [parser parse];
    }
    else {
        [_delegate didFinishParsedCategories:nil];
    }
    
    
}

-(void) didParsedCategories{
    [_delegate didFinishParsedCategories:_categoryDictionary];
}


#pragma mark Load Recipes
-(void) loadRecipesForCategory: (NSString*)categoryId
{
    
}

-(void) loadRecipesForUser:(NSString *)userId
{
    
}

-(void) loadRecipesByKeywords:(NSString *)keywords
{
    
}


-(void) gotRecipesByRequest: (ASI2HTTPRequest*)request
{
    
}

-(void) didParsedRecipes
{

}

//- (void)requestFinished:(ASIHTTPRequest *)request
//{    
//    //[MBProgressHUD hideHUDForView:self.view animated:YES];
//    if (request.responseStatusCode == 400) {
//        NSLog(@"Invalid code");        
//    } else if (request.responseStatusCode == 403) {
//        NSLog(@"Code already used");
//    } else if (request.responseStatusCode == 200) {
//        NSString *responseString = [request responseString];
//        NSLog(@"%@", responseString);
//        NSLog(@"DATA: %s", [request responseData].bytes);
////        NSDictionary *responseDict = [responseString JSONValue];
////        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
////        
////        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
////            NSLog(@"The cake is a lie!");
////        } else {        
////            NSLog(@"%@", [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode]);
////        }
//        
//    } else {
//        NSLog(@"Unexpected error");
//    }
//    
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{    
//    //[MBProgressHUD hideHUDForView:self.view animated:YES];
//    //NSError *error = [request error];
//    //NSLog(error.localizedDescription);
//    NSLog(@"Error");
//}

#pragma mark Errors Handler
- (void) gotErrorByRequest:(ASI2HTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error.localizedDescription);
}

- (void) requestStatusHandler:(ASI2HTTPRequest *)request{
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog(@"Invalid code");        
    } else if (request.responseStatusCode == 403) {
        NSLog(@"Code already used");
    } else {
        NSLog(@"Unexpected error");
    }
}


//#pragma mark addEntry
//-(void) addEntry: (Entry*)entry
//{
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
//														object:nil];
//	
//	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
//													   andAction:@selector(finishAddingEntry: byRequest:)];
//	req.transientObject = [entry retain];
//	[req call:ADD_ENTRY_URL params:[NSDictionary dictionaryWithObject:[entry dateByStringWithFormat:@"yyyyMMdd"]
//															   forKey:@"date"]];
//	[req release];
//}
//-(void) finishAddingEntry:(NSData*)data byRequest:(HttpRequest*)req
//{
//	NSLog(@"DATA: %s", data.bytes);
//	// Check if returned id existed
//	NSString* entryId = [NSString stringWithCharacters:[data bytes] length:[data length]];
//	BOOL notExisted = YES;
//	for (Entry* e in _entries) {
//		if ([entryId isEqualToString:e.entryId]) {
//			notExisted = NO;
//		}
//	}
//	
//	if (notExisted) {
//		Entry* entry = (Entry*)req.transientObject;
//		entry.entryId = entryId;
//		[_entries addObject:entry];
//		[req.transientObject release];
//		req.transientObject = nil;
//	}	
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION
//														object:nil];
//	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
//														object:nil];
//}
//#pragma mark -
//#pragma mark removeEntry
//-(void) removeEntry: (Entry*)entry
//{
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
//														object:nil];
//	
//	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
//													   andAction:@selector(finishRemovingEntry: byRequest:)];
//	req.transientObject = entry;
//	[req call:REMOVE_ENTRY_URL params:[NSDictionary dictionaryWithObject:[entry entryId]
//																  forKey:@"id"]];
//	[req release];
//		
//}
//-(void) finishRemovingEntry:(NSData*)data byRequest:(HttpRequest*)req
//{
//	NSLog(@"DATA: %s", data.bytes);
//	[_entries removeObject:req.transientObject];
//	req.transientObject = nil;
//	
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION
//														object:nil];
//	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
//														object:nil];
//}
//#pragma mark -
//#pragma mark addFruitBag
//-(void) addOrEditFruitBag:(FruitBag*)fruitbag toEntry:(Entry*)entry
//{
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
//														object:nil];
//	if (![entry.fruitBags containsObject:fruitbag]) {
//		[entry.fruitBags addObject:fruitbag];
//	}
//	
//	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
//													   andAction:@selector(finishAddingFruitBag: byRequest:)];
//	//req.transientObject = [NSArray arrayWithObjects:fruitbag, entry];
//	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObject:entry.entryId forKey:@"entryid"];
//	[dict setValue:fruitbag.fruit.type forKey:@"type"];
//	[dict setValue:[NSString stringWithFormat:@"%d",fruitbag.count] forKey:@"count"];
//	[req call:SET_FRUIT_URL params:dict];
//	
//	[req release];
//}
//-(void) finishAddingFruitBag:(NSData*)data byRequest:(HttpRequest*)req
//{
//	NSLog(@"DATA: %s", data.bytes);
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION
//														object:nil];
//	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
//														object:nil];
//}
//#pragma mark -
//#pragma mark removeFruitBag
//-(void) removeFruitBag:(FruitBag*)fruitBag fromEntry:(Entry*)entry
//{
//	[entry.fruitBags removeObject:fruitBag];
//	
//	// No backend
//	[self finishRemovingEntry:nil byRequest:nil];
//}
//-(void) finishRemovingFruitBag:(NSData*)data byRequest:(HttpRequest*)req
//{
//	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION
//														object:nil];
//
//}
//#pragma mark -
//#pragma mark loadEntries
//-(void) loadEntries
//{
//	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
//													   andAction:@selector(gotEntries: byRequest:)];
//	[req call:ENTRIES_URL params:[NSDictionary dictionary]];
//	[req release];
//}
//-(void)gotEntries: (NSData*)data byRequest:(HttpRequest*)req
//{
//	NSLog(@"entries: %s", data.bytes);
//	EntriesXMLHandler* handler = [[EntriesXMLHandler alloc] initWithEntriesList:_entries andFruitList:_fruitList];
//	[handler setEndDocumentTarget:self andAction:@selector(didParsedEntries)];
//	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
//	parser.delegate = handler;
//	[parser parse];
//	[handler release];
//}
//-(void) didParsedEntries
//{
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_FINISHING_NOTIFICATION 
//														object:nil];
//}
//#pragma mark -
//#pragma mark loadAllData
//-(void) loadAllData
//{
//	[[NSNotificationCenter defaultCenter] postNotificationName: HTTP_REQUEST_STARTING_NOTIFICATION 
//														object:nil];
//	
//	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
//													   andAction:@selector(gotFruits: byRequest:)];
//	[req call:FRUITS_URL params:[NSDictionary dictionary]];
//	[req release];
//}
//
//-(void)gotFruits: (NSData*)data byRequest:(HttpRequest*)req
//{
//	NSLog(@"fruits: %s", data.bytes);
//	FruitsXMLHandler* handler = [[FruitsXMLHandler alloc] initWithFruitList:_fruitList];
//	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
//	[handler setEndDocumentTarget:self andAction:@selector(didParsedFruits)];
//	parser.delegate = handler;
//	[parser parse];
//	[handler release];
//}	
//
//-(void) didParsedFruits
//{
//	[self loadEntries];
//	for (Fruit* fr in _fruitList) {
//		[self loadFruitImage:fr];
//	}
//}
//#pragma mark -
//#pragma mark loadFruitImage
//-(void) loadFruitImage: (Fruit*) fruit
//{
//	// TODO Cache, store & load file 
//	HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
//													   andAction:@selector(finishLoadingFruiImage: byRequest:)];
//	req.transientObject = fruit;
//	NSString* fullUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, fruit.imageURL];
//	[req call:fullUrl params:[NSDictionary dictionary]];
//	[req release];
//}
//-(void) finishLoadingFruiImage:(NSData*)data byRequest:(HttpRequest*)req
//{
//	Fruit* fr = (Fruit*)req.transientObject;
//	fr.image = data;
//	
//	req.transientObject = nil;
//	[[NSNotificationCenter defaultCenter] postNotificationName: RELOAD_DATA_NOTIFICATION 
//														object:nil];
//}
@end
