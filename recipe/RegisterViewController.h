//
//  RegisterViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>{
    __weak UITextField *activeTextField;
    __weak UIViewController *_parentController;
    User* _user;
}

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;

@property (weak, nonatomic) IBOutlet UIImageView *formBackground;

- (IBAction)dismissKeyboard;
- (IBAction)onRegisterTap;

- (id)initWithParentRef:(UIViewController*)parentViewController;
- (void) didFinishRegisterUser;

@end
