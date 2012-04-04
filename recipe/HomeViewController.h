//
//  HomeViewController.h
//  recipe
//
//  Created by ongsoft on 3/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTable;

@end
