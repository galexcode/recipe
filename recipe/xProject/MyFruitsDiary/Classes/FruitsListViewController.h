//
//  FruitsListViewController.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFruitsDiaryGlobal.h"
#import "BaseViewController.h"

@interface FruitsListViewController : BaseViewController<UITableViewDataSource,
														UITableViewDelegate>{
	Entry*					_entry;
	IBOutlet UITableView	*_table;
}
-(id) initWithEntry:(Entry*)entry;

@end
