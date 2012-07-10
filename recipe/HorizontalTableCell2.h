//
//  HorizontalTableCell2.h
//  recipe
//
//  Created by Vu Tran on 7/10/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableCell2 : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_horizontalTableView;
    NSMutableArray *_recipes;
}

@property (nonatomic, retain) UITableView *horizontalTableView;
@property (nonatomic, retain) NSMutableArray *recipes;
@property (nonatomic, weak) UIViewController* navController;

@end
