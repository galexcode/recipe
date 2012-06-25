//
//  LoginViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface LoginViewController : UIViewController{
    __weak UITextField *activeTextField;
    __weak UIViewController* _parentController;
    User* _user;
}

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *formBackgound;

- (IBAction)dismissKeyboard;
- (IBAction)onLoginTap:(id)sender;

- (id)initWithParentRef:(UIViewController*)parentViewController;
- (void)didParsedLoggingUser;

@end
