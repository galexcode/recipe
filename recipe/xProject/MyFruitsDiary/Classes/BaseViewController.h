//
//  BaseViewController.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController {
@private
	id		_backupRightButtonItem;
}

-(void) startReq:(NSNotification*)notif;
-(void) finishReq:(NSNotification*)notif;
-(void) setRightBarButtonItem:(id)bbi;
-(void) reloadData:(NSNotification*)notif;
@end
