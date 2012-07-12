//
//  HomeViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/25/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryListViewController.h"
#import "CategoryList2ViewController.h"

@interface HomeViewController : UIViewController <UISearchBarDelegate>
{
    NSMutableArray *_recipes;
    UIImageView *bigBgView;
    UIImageView *upperSmallBgView;
    UIImageView *lowerSmallBgView;
    CategoryListViewController *tableViewController;
    CategoryList2ViewController *tableView2Controller;
    Boolean isSwitch;
}

@property (nonatomic) NSMutableArray *recipes;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic, weak) UIViewController* navController;
- (void)didParsedSearchRecipes;
@end
