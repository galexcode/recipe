//
//  CategoryListViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/21/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryListViewController : UITableViewController
{
    NSDictionary *_categoryDictionary;
}

@property (nonatomic) NSDictionary *categoryDictionary;

@end
