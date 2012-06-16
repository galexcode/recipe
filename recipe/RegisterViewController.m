//
//  RegisterViewController.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"
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
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Registering..."];
        _user = [[User alloc] init];
        [_user setName:[userName text]];
        [_user setPassword:[password text]];
        [_user setEmail:[email text]];
        
        //NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/register.xml"];
        NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/register"];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[userName text] forKey:@"un"];
        [request setPostValue:[password text] forKey:@"pw"];
        [request setPostValue:[email text] forKey:@"em"];
        
        [request setCompletionBlock:^{
            NSLog(@"Register xml loaded.");
            if (request.responseStatusCode == 200) {
                NSLog(@"%d", request.responseStatusCode);
                UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
                [handler setEndDocumentTarget:self andAction:@selector(didFinishRegisterUser)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
                //            }else if(request.responseStatusCode == 404){
            } else {
                _user = nil;
                [self didFinishRegisterUser];
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

- (void)handleError:(NSError*)error
{
    NSLog(@"Error receiving respone for login request: %@", error.localizedDescription);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *errorTitle;
    NSString *errorMessage;
    if ([error code] == 1) {
        errorTitle = [[NSString alloc] initWithString:@"Internet Access Problem"];
        errorMessage = [[NSString alloc] initWithString:@"Please check your internet access!"];
    } else {
        errorTitle = [[NSString alloc] initWithString:@"Error Ocurring"];
        errorMessage = [[NSString alloc] initWithString:@"Unknown error"];
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
-(void) didFinishRegisterUser{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (_user != nil) {
        if (![_user.userId isEqualToString:@"-1"] && ![_user.userId isEqualToString:@"-2"]) {
            UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"Register Success"
                                                                       message:[NSString stringWithFormat:@"Welcome to Recipe"]
                                                                      delegate:nil
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
            [successAlertView show];
            [_parentController.view setHidden:YES];
        } else if ([_user.userId isEqualToString:@"-1"]) {
            UIAlertView *failsAlertView = [[UIAlertView alloc] initWithTitle:@"Register Failed"
                                                                     message:[NSString stringWithFormat:@"Username is not available"]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
            [failsAlertView show];
        } else if ([_user.userId isEqualToString:@"-2"]) {
            UIAlertView *failsAlertView = [[UIAlertView alloc] initWithTitle:@"Register Failed"
                                                                     message:[NSString stringWithFormat:@"Email is not available"]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
            [failsAlertView show];
        }
    }
}

@end
