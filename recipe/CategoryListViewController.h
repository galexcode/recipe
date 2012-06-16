//
//  CategoryListViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/21/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface CategoryListViewController : UITableViewController
{
    NSMutableDictionary *_categoryDictionary;
}

@property (nonatomic) NSMutableDictionary *categoryDictionary;

-(void)tapOnHeader:(id)sender;
-(void)reload;
-(void) didParsedCategories;

@end
