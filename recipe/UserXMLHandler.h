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
#import "Recipe.h"

@interface UserXMLHandler : BaseXMLHandler{
    __weak NSObject* _currentObject;
    __weak User* _currentUser;
    Recipe* _currentRecipe;
}

-(id) initWithUser:(__weak User*)user;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
