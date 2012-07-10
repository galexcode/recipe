//
//  CategoryList2ViewController.h
//  recipe
//
//  Created by Vu Tran on 7/10/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "PullRefreshTableViewController.h"

@interface CategoryList2ViewController : PullRefreshTableViewController
{
    NSMutableDictionary *_categoryDictionary;
    NSMutableArray *_reusableCells;
    //    NSMutableArray *categoryIndex;
}

@property (nonatomic) NSMutableDictionary *categoryDictionary;
@property (nonatomic) NSMutableArray *reusableCells;
@property (nonatomic, weak) UIViewController* navController;

-(void)tapOnHeader:(id)sender;
-(void) didParsedCategories;

@end
