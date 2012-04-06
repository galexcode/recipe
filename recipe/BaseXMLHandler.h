//
//  XMLHandler.h
//
//  Created by Khoi Pham on 3/11/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseXMLHandler : NSObject<NSXMLParserDelegate> {
	NSError*		_parseError;
	id				_target;
	SEL				_action;
	NSMutableString* _chars;
@protected
	// Workaround to prevent trash xml data
	BOOL                _stop;
}


-(id) initObjectAfterElementStarting:(NSString*)elementName;
-(void) afterElementStarting:(NSString*)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString*)elementName;
-(void) setEndDocumentTarget:(id)target andAction: (SEL)action;
-(NSString*) getWrappedRootNode;
@end
