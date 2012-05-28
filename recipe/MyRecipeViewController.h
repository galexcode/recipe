//
//  MyRecipeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecipeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* _recipes;
}

@property (nonatomic) NSMutableArray* recipes;

@end
