//
//  RecipeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *recipeDetailsTable;

@end
