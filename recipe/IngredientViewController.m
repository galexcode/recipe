//
//  IngredientViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "IngredientViewController.h"
#import "ASI2HTTPRequest.h"

@interface IngredientViewController ()

@end

@implementation IngredientViewController
@synthesize pageTitle;
@synthesize pageTitleText = _pageTitleText;
@synthesize imageIngredient = _imageIngredient;
@synthesize ingredientDesc = _ingredientDesc;
@synthesize ingredient = _ingredient;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pageTitle.text = self.ingredient.name;
    self.ingredientDesc.text = self.ingredient.desc;
    NSLog(@"iid: %@", [[self ingredient] ingredientId]);
    
    NSString *link = [NSString stringWithFormat:@"http://www.perselab.com/recipe/image/%@/306", self.ingredient.imagePath];
    NSURL *url = [[NSURL alloc] initWithString:link];
    
    __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSData *data = request.responseData;
        [self.imageIngredient setImage:[[UIImage alloc] initWithData:data]];
    }];
    [request setFailedBlock:^{
        NSError *error = request.error;
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    [request startAsynchronous];

}

- (void)viewDidUnload
{
    [self setPageTitle:nil];
    [self setImageIngredient:nil];
    [self setIngredientDesc:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
