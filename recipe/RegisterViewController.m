//
//  RegisterViewController.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSStringUtil.h"

@implementation RegisterViewController
@synthesize userName;
@synthesize email;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithParentRef:(UIViewController*)parentViewController{
    self = [super init];
    if (self) {
        _parentController = parentViewController;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Register feature
- (IBAction)onRegisterTap{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
    if ([trimSpaces([userName text]) length] != 0
        && [trimSpaces([email text]) length] != 0
        && [NSStringUtil stringIsValidEmail:[email text]]
        && [[password text] length] != 0)
    {
        _user = [[User alloc] init];
        [_user setName:[userName text]];
        [_user setPassword:[password text]];
        [_user setEmail:[email text]];
        //        APP_SERVICE(appSrv);
        //        NSLog(@"%@", appSrv);
        //        [appSrv setRegisterDelegate:self];
        //        [appSrv registerUser:_user];
    }else {
        if ([trimSpaces([userName text]) length] == 0)
            [userName setText:@""];
        [userName setText:trimSpaces([userName text])];
        [userName setPlaceholder:@"User name is blank"];
        if ([trimSpaces([email text]) length] == 0) {
            [email setText:@""];
            [email setPlaceholder:@"Email is blank"];
        }else if(![NSStringUtil stringIsValidEmail:[email text]]){
            [email setText:@""];
            [email setPlaceholder:@"Email is not valid"];
        }
        if ([[password text] length] == 0)
            [password setPlaceholder:@"Password is blank"];
    }
}

- (IBAction)dismissKeyboard{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    activeTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Application Service Delegate Methods
-(void) didFinishRegisterUser:(User *__weak)registerUser{
    //    if (registerUser != nil) {
    ////        NSLog(@"username on weak: %@", [registerUser name]);
    ////        NSLog(@"username on strong: %@", [currentUser name]);
    ////        NSLog(@"username on nil: %@", [_user name]);
    //        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Successful Register"
    //                                                                   message:[NSString stringWithFormat:@"Welcome to Recipe, %@",]
    //                                                                  delegate:nil
    //                                                         cancelButtonTitle:@"OK"
    //                                                         otherButtonTitles:nil];
    //        [successAlertView show];
    //        [_parentController.view setHidden:YES];
    //    }
}

@end
