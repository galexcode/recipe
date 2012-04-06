//
//  FruitViewController.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFruitsDiaryGlobal.h"
#import "BaseViewController.h"

@interface FruitViewController : BaseViewController {
	Entry*		_entry;
	FruitBag*	_fruitBag;
	BOOL		_isEdit;
	
	IBOutlet UIImageView*	_fruitImg;
	//IBOutlet UISlider*		_scrollBar;
	IBOutlet UITextView*	_txtFruitDetail;
	IBOutlet UITextField*	_txtAmount;
	IBOutlet UITextField*	_txtVitamins;

}

-(id) initWithEntry:(Entry*)entry andFruitBag:(FruitBag*)fruit editMode:(BOOL)editMode;
-(IBAction) amountChanged: (UISlider*) sender;

@end
