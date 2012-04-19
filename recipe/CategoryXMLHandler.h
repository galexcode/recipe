//
//  CategoryXMLHandler.h
//  recipe
//
//  Created by SaRy on 4/6/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "recipeGlobal.h"

@interface CategoryXMLHandler : BaseXMLHandler{
    NSObject* _currentObject;
    Category* _currentCategory;
    Recipe* _currentRecipe;
    NSNumber* _total;
    NSMutableArray* _categoryArray;
}

-(id) initWithCategoryArray:(NSMutableArray*)categoryArray;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
