//
//  SelectCategoresViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCategoresViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    __weak NSMutableArray* _selectedCategories;
}

@property (nonatomic, weak) NSMutableArray *selectedCategories;

@end
