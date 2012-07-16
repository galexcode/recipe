//
//  LoginViewController.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "ASIForm2DataRequest.h"
#import "UserXMLHandler.h"
#import "NSStringUtil.h"
#import "GlobalStore.h"

@implementation LoginViewController
@synthesize userName;
@synthesize password;
@synthesize formBackgound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
//        login.frame = CGRectMake(20, 98, 280, 35);
//        [login setBackgroundImage:[[UIImage imageNamed:@"btn-red.png"] stretchableImageWithLeftCapWidth:20.0 topCapHeight:0.0] forState:UIControlStateNormal];
//        [login addTarget:self action:@selector(onLoginTap:) forControlEvents:UIControlEventTouchUpInside];
//        [login setTitle:@"Login" forState:UIControlStateNormal];
//        //[buy.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
//        //[buy.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
//        [self.view addSubview:login];
    }
    return self;
}

- (id)initWithParentRef:(AuthViewController*)parentViewController{
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
    UIImage *imageFromBackground = [[UIImage imageNamed:@"form_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(11, 0, 11, 0)];
    [[self formBackgound] setImage:imageFromBackground];
    
    if ([self autoLogin]) {
        [[[self parentViewController] view] setHidden:YES];
    }
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setFormBackgound:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Login feature
- (Boolean)autoLogin
{
    Boolean flag = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *username = [defaults objectForKey:@"recipe.username"];
    
    NSData *passWord = [defaults objectForKey:@"recipe.password"];
    
    //NSString *passkey = [defaults objectForKey:@"recipe.passkey"];
    
    if (![username isEqualToString:@""] && passWord != nil) {
        [[self userName] setText:username];
        [[self password] setText:[NSStringUtil decryptData:passWord withKey:[GlobalStore encryptionKey]]];
        
        [self onLoginTap:nil];
    }
    return flag;
}

- (IBAction)onLoginTap:(id)sender{
    [self dismissKeyboard];
    if ([trimSpaces([userName text]) length] != 0 && [[password text] length] != 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Checking..."];
        _user = [[GlobalStore sharedStore] loggedUser];
        
        NSURL *url = [NSURL URLWithString:[GlobalStore loginLink]];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[userName text] forKey:@"un"];
        [request setPostValue:[password text] forKey:@"pw"];
        
        [request setCompletionBlock:^{
            if (request.responseStatusCode == 200) {
                UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
                [handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
//            }else if(request.responseStatusCode == 404){
            } else {
                _user = nil;
                [self didParsedLoggingUser];
            }
        }];
        [request setFailedBlock:^{
            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
        
    }else {
        if ([trimSpaces([userName text]) length] == 0)
            [userName setText:@""];
        [userName setText:trimSpaces([userName text])];
        [userName setPlaceholder:@"User name is blank"];
        if ([[password text] length] == 0)
            [password setPlaceholder:@"Password is blank"];
    }
}

-(void) didParsedLoggingUser
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (_user != nil) {
        if (![[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:@"-1"]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[[[GlobalStore sharedStore] loggedUser] name] forKey:@"recipe.username"];
            [defaults setObject:[NSStringUtil encryptString:[password text] withKey:[GlobalStore encryptionKey]] forKey:@"recipe.password"];
            //[defaults setObject:passkey forKey:@"passkey"];
            [defaults synchronize];
            [_parentController.view setHidden:YES];
        } else if ([[[[GlobalStore sharedStore] loggedUser] userId]  isEqualToString:@"-1"]) {
            UIAlertView *failsAlertView = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                                     message:[NSString stringWithFormat:@"Username or Password is not correct"]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
            [failsAlertView show];
        }
    }
}

- (void)handleError:(NSError*)error
{
    NSLog(@"Error receiving respone for login request: %@", error.localizedDescription);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"error code: %d", [error code]);
    NSString *errorTitle;
    NSString *errorMessage;
    if ([error code] == 1) {
        errorTitle = @"Internet Access Problem";
        errorMessage = @"Please check your internet access!";
    } else {
        errorTitle = @"Error Ocurring";
        errorMessage = @"Unknown error";
    }
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:errorTitle
                                                                    message:errorMessage
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
    [errorAlertView show];
}

- (IBAction)dismissKeyboard{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
        //[_parentController needToScroll:0];
    }
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    activeTextField = textField;
    //[_parentController needToScroll:360];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //[_parentController needToScroll:0];
    return YES;
}
    
//-(void) didFinishVerifyUser:(__weak User *)loggedUser{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    if (loggedUser != nil) {
//        USER(currentUser);
//        currentUser = _user;
////        [currentUser copy:_user];
////        APP_SERVICE(appSrv);
//        NSLog(@"%@", currentUser);
////        [appSrv setDelegate:nil];
//        NSLog(@"username on weak: %@", [loggedUser name]);
//        NSLog(@"username on strong: %@", [currentUser name]);
//        NSLog(@"username on nil: %@", [_user name]);
//        NSLog(@"username on shared: %@", [currentUser name]);
//        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Successful Login"
//                                                                   message:[NSString stringWithFormat:@"Welcome back %@",[currentUser name]]
//                                                                  delegate:nil
//                                                         cancelButtonTitle:@"OK"
//                                                         otherButtonTitles:nil];
//        [successAlertView show];
//        [_parentController.view setHidden:YES];
//    }
//}

@end
