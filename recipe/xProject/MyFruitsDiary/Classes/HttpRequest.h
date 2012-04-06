//
//  BaseRequest.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol HttpRequestDelegate

@optional
-(void) didFinishQuerying;

@end

@interface HttpRequest : NSObject {
	NSDictionary*			_params;
	NSURLConnection*		_connection;
	NSMutableData*			_responseText;
	id						_transientObject;
	id						_target;
	SEL						_action;
	id<HttpRequestDelegate> _delegate;
}

@property (nonatomic,assign) id<HttpRequestDelegate> delegate;
@property (nonatomic, assign) id transientObject;

-(void) call:(NSString*)url params:(NSDictionary*)params;
-(id) initWithFinishTarget: (id)target andAction:(SEL)action;
-(NSData*) responseText;
@end
