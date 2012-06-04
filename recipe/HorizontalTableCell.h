//
//  HorizontalTableCell.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_horizontalTableView;
    NSMutableArray *_recipes;
}

@property (nonatomic, retain) UITableView *horizontalTableView;
@property (nonatomic, retain) NSMutableArray *recipes;
@property (nonatomic, weak) UIViewController* navController;

@end
