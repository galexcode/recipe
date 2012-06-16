//
//  AddRecipeViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface AddRecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    Recipe *recipe;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
