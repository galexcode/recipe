//
//  HomeViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/25/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UISearchBarDelegate>
{
    NSMutableArray *_recipes;
}

@property (nonatomic) NSMutableArray *recipes;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) UIViewController* navController;
- (void)didParsedSearchRecipes;
@end
