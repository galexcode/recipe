//
//  IngredientViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "IngredientViewController.h"
#import "GlobalStore.h"
#import "RecipeNavigationLabel.h"
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
    
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    [[self pageTitle] setText:[self pageTitleText]];
    
    self.pageTitle.text = self.ingredient.name;
    self.ingredientDesc.text = self.ingredient.desc;
    
    NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[[self ingredient] imagePath] forWidth:600 andHeight:0]];
    
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
