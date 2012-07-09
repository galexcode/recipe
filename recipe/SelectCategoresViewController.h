//
//  SelectCategoresViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface SelectCategoresViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    __weak NSMutableArray* _selectedCategories;
    Recipe* _recipe;
    NSArray* sortedCategories;
    NSMutableArray *markedCategoryList;
}

@property (nonatomic, weak) NSMutableArray *selectedCategories;
@property (nonatomic) Recipe *recipe;

@end
