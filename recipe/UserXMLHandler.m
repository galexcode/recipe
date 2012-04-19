//
//  UserXMLHandler.m
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "UserXMLHandler.h"

@implementation UserXMLHandler

-(id) initWithUser:(User*)user
{
    if (self = [super init]) {
        _user = user;
    }
    return self;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict
{
    
}

-(void) afterElementEnding:(NSString *)elementName
{
    
}

-(NSString*) getWrappedRootNode
{
    return nil;
}

@end
