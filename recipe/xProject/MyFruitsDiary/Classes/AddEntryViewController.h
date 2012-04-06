//
//  AddEntryController.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFruitsDiaryGlobal.h"

@protocol AddEntryViewDelegate
-(void) addViewCancel: (UIViewController*)viewController;
-(void) addView: (UIViewController*)viewController didPickADate: (NSDate*)date;
@end

@interface AddEntryViewController : UIViewController {
	IBOutlet UIDatePicker*		_datePicker;
	id<AddEntryViewDelegate>	_delegate;
}

@property (nonatomic,assign) id<AddEntryViewDelegate> delegate;

-(IBAction) ok:(UIButton*)sender;
-(IBAction) cancel:(UIButton*)sender;
@end
