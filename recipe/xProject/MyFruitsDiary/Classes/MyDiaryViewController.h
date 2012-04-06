//
//  MyDiaryViewController.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyFruitsDiaryGlobal.h"
#import "AddEntryViewController.h"
#import "BaseViewController.h"

@interface MyDiaryViewController : BaseViewController<UITableViewDelegate, 
													UITableViewDataSource, 
													AddEntryViewDelegate> {
	IBOutlet UITableView*		_table;
@protected
	BOOL						_isEditMode;
	UISegmentedControl*			_rightBarButtonItems;
	AddEntryViewController*		_addEntryViewController;
}

-(void) toggleEditingMode;
-(void) displayAddEntryView: (BOOL)toShow;
@end
