//
//  TestLoginViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/5/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface TestLoginViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    __weak UITextField *activeTextField;
    __weak UIViewController* _parentController;
    User* _user;
}

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITableViewCell *userNameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *buttonCell;

- (IBAction)dismissKeyboard;
- (IBAction)onLoginTap:(id)sender;

- (id)initWithParentRef:(UIViewController*)parentViewController;
- (void)didParsedLoggingUser;

@end
