//
//  RegisterViewController.h
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    UITextField *activeTextField;
    UIViewController *parent;
}

- (IBAction)dismissKeyboard;
- (IBAction)onRegisterTap;

- (id)initWithParentRef:(UIViewController*)parentViewController;

@end
