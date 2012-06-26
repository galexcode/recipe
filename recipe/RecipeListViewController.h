//
//  RecipeListViewController.h
//  recipe
//
//  Created by Vu Tran on on 4/3/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>{
    NSMutableArray* _recipes;
    NSString* _pageTitleText;
}


@property (weak, nonatomic) IBOutlet UITableView *recipeTable;
@property (weak, nonatomic) IBOutlet UILabel *pageTitle;
@property (nonatomic) NSMutableArray* recipes;
@property (nonatomic) NSString* pageTitleText;

@end
