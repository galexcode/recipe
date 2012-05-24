//
//  LoginViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface LoginViewController : UIViewController<ApplicationServiceDelegate>{
    __weak UITextField *activeTextField;
    __weak UIViewController* _parentController;
    User* _user;
}

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)dismissKeyboard;
- (IBAction)onLoginTap;

- (id)initWithParentRef:(UIViewController*)parentViewController;

@end
