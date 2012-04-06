//
//  EntryTitleViewController.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyFruitsDiaryGlobal.h"

@interface EntryTitleViewController : UIViewController {
	IBOutlet UILabel*	_entryTitle;
	IBOutlet UILabel*	_entryTitleDetail;
	
	NSString*			_sTitle;
	NSString*			_sTitleDetail;
}

-(id) initWithTitle:(NSString*)title andDetaill:(NSString*)detail;
-(void) updateTitle:(NSString*)title andDetaill:(NSString*)detail;
@end
