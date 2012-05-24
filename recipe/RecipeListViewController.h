//
//  RecipeListViewController.h
//  recipe
//
//  Created by Vu Tran on on 4/3/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>{
    NSMutableArray *recipeList;
}

@property (weak, nonatomic) IBOutlet UITableView *recipeTable;

@end
