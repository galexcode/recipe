//
//  BaseRequest.mm
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
@synthesize delegate = _delegate;
@synthesize transientObject = _transientObject;

#pragma mark private
- (NSString*)generateGetURL:(NSString*) url {
	NSURL* parsedURL = [NSURL URLWithString:url];
	NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
	
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [_params keyEnumerator]) {
		NSString* value = [_params objectForKey:key];
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
	}
	NSString* params = [pairs componentsJoinedByString:@"&"];
	
	return [NSString stringWithFormat:@"%@%@%@", url, queryPrefix, params];
}
/*
- (void)handleResponseData:(NSData*)data {
	NSLog(@"DATA: %s", data.bytes);
	XMLHandler* handler = [[[XMLHandler alloc] init] autorelease];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
}
*/
#pragma mark public

-(id) initWithFinishTarget: (id)target andAction:(SEL)action
{
	if (self = [super init]) {
		_target = target;
		_action = action;
		_connection = nil;
		_responseText = nil;
		
	}
	return self;
}

-(NSData*) responseText
{
	return _responseText;
}

-(void) call:(NSString*)url params:(NSDictionary*)params
{
	_params = params;
	
	// build params
	NSString* finalURL = [self generateGetURL:url];
	
	// make request
	//NSString* url = _method ? _url : [self generateGetURL];
	NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]];
	
	//_timestamp = [[NSDate date] retain];
	_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
	_responseText = [[NSMutableData alloc] init];
	
	//NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
	
	// TODO: work around, sometime delegate is NULL.
	
	//if (_delegate != nil && [_delegate respondsToSelector:@selector(request:didReceiveResponse:)]) {    
	//	[_delegate request:self didReceiveResponse:httpResponse];
	//}
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
	[_responseText appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (_target != nil) {
		[_target performSelector:_action withObject:_responseText withObject:self];
	}
	
	_responseText = nil;
	_connection = nil;
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	_responseText = nil;
	_connection = nil;
}
@end
