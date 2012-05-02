//
//  RegisterViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface RegisterViewController : UIViewController<ApplicationServiceDelegate>{
    __weak UITextField *activeTextField;
    __weak UIViewController *_parentController;
    User* _user;
}

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;


- (IBAction)dismissKeyboard;
- (IBAction)onRegisterTap;

- (id)initWithParentRef:(UIViewController*)parentViewController;

@end
