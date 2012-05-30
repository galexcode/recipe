//
//  IngredientListViewController.h
//  recipe
//
//  Created by SaRy on 4/5/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _ingredients;
}

@property (weak, nonatomic) IBOutlet UITableView *ingredientListTable;
@property (nonatomic) NSArray *ingredients;

@end
