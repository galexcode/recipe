//
//  HomeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface HomeViewController : UIViewController<UITableViewDataSource, UITabBarDelegate>{
    NSMutableArray* _categoryArray;
}

@property (weak, nonatomic) IBOutlet UITableView *categoryTable;

- (void)showRecipeView;

@end
