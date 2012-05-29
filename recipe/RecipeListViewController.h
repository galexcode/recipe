//
//  RecipeListViewController.h
//  recipe
//
//  Created by Vu Tran on on 4/3/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>{
    NSArray* _recipes;
}

@property (weak, nonatomic) IBOutlet UITableView *recipeTable;
@property (nonatomic) NSArray* recipes;

@end
