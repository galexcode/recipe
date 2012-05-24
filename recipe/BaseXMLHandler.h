//
//  BaseXMLHandler.h
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseXMLHandler : NSObject<NSXMLParserDelegate>{
    NSError*        _parseError;
    id              _target;
    SEL             _action;
    NSMutableString* _chars;
@protected
    BOOL            _stop;
}

-(id) initObjectAfterElementStarting:(NSString*)elementName;
-(void) afterElementStarting:(NSString*)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString*)elementName;
-(void) setEndDocumentTarget:(id)target andAction: (SEL)action;
-(NSString*) getWrappedRootNode;

@end
