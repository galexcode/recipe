//
//  UserXMLHandler.h
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseXMLHandler.h"
#import "User.h"

@interface UserXMLHandler : BaseXMLHandler{
    __weak User* _user;
}

-(id) initWithUser:(User*)user;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
