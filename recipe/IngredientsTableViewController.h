//
//  IngredientsTableViewController.h
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientsTableViewController : UITableViewController{
    NSArray* _ingredients;
}

@property (nonatomic) NSArray *ingredients;
@property (nonatomic, weak) UIViewController* navController;

@end
