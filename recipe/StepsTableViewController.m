//
//  StepsTableViewController.m
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#define COMMENT_LABEL_WIDTH 280
#define COMMENT_LABEL_MIN_HEIGHT 44
#define COMMENT_LABEL_PADDING 10

#import "StepsTableViewController.h"
#import "recipeGlobal.h"
#import "StepCell.h"
#import "Step.h"
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"
#import "RecipeXMLHandler.h"
#import "GlobalStore.h"
#import "MBProgressHUD.h"

@interface StepsTableViewController ()

@end

@implementation StepsTableViewController
@synthesize recipe = _recipe;
@synthesize steps = _steps;
@synthesize stepForm;
@synthesize txtStepName;
@synthesize txtStepDescription;

- (id)initWithEditableTable
{
    self = [super initWithNibName:@"StepsTableViewController" bundle:nil];
    if (self) {
        ediable = YES;
    }
    return self;
}

- (IBAction)dismissKeyboard:(id)sender {
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
    if (activeTextView != nil) {
        [activeTextView resignFirstResponder];
    }
}

- (IBAction)insertStep:(id)sender {
    if ([self validateInputInformation]) {
        NSURL *url = [NSURL URLWithString:[GlobalStore addStepLink]];
        __weak __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[self recipe] recipeId] forKey:@"rid"];
        [request setPostValue:[txtStepName text] forKey:@"sname"];
        [request setPostValue:[txtStepDescription text] forKey:@"sdesc"];
        
        [request setCompletionBlock:^{
            if (request.responseStatusCode == 200) {
                [[self recipe] setIngredientList:nil];
                [[self recipe] setIngredientList:[NSMutableArray array]];
                RecipeXMLHandler* handler = [[RecipeXMLHandler alloc] initWithRecipe:_recipe];
                
                [handler setEndDocumentTarget:self andAction:@selector(didParsedInsertStep)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
                
                [self cancelAddStep:self];
                //}else if(request.responseStatusCode == 404){
            } else {
                //_user = nil;
                [self didParsedInsertStep];
            }
        }];
        [request setFailedBlock:^{
            //            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
    }
}

- (BOOL)validateInputInformation
{
    Boolean flag = YES;
    
    if ([trimSpaces([txtStepName text]) length] == 0){
        [txtStepName setText:@""];
        [txtStepName setPlaceholder:@"Name is blank"];
        flag = NO;
    }
    return flag;
}

- (void)didParsedInsertStep
{
    selectedIndex = [[[self recipe] stepList] count] - 1;
    if ([[[self recipe] stepList] count] == 1 || [[[self recipe] stepList] count] == 0)
        [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Step", [[[self recipe] stepList] count]]];
    else
        [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Steps", [[[self recipe] stepList] count]]];
    [[self tableView] reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedIndex = 0;
    if (ediable || [[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:[[[self recipe] owner] userId]]) {
        barButton = [[UIBarButtonItem alloc] 
                     initWithTitle:@"Add"                                            
                     style:UIBarButtonItemStyleBordered 
                     target:self 
                     action:@selector(addStep:)];
        self.navigationItem.rightBarButtonItem = barButton;
        [self.view addSubview:stepForm];
        [stepForm setHidden:YES];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addStep:(id)sender
{
    [barButton setTitle:@"Cancel"];
    [barButton setAction:@selector(cancelAddStep:)];
    [stepForm setHidden:NO];
    [[self tableView] setScrollEnabled:NO];
}

- (void)cancelAddStep:(id)sender
{
    [barButton setTitle:@"Add"];
    [barButton setAction:@selector(addStep:)];
    [stepForm setHidden:YES];
    
    [self dismissKeyboard:self];
    [self formReset];
    [[self tableView] setScrollEnabled:YES];
}

- (void)formReset
{
    txtStepName.text = @"";
    txtStepDescription.text = @"Simple description";
}
- (void)viewDidUnload
{
    [self setStepForm:nil];
    [self setTxtStepName:nil];
    [self setTxtStepDescription:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//This just a convenience function to get the height of the label based on the comment text
-(CGFloat)getLabelHeightForIndex:(NSInteger)index
{
    if ([[[self recipe] stepList] count] > 0) {
        CGSize maximumSize = CGSizeMake(COMMENT_LABEL_WIDTH, 10000);
        
        NSString *oneLine = @"1 line";
        
        CGSize heighOfOneLine = [oneLine sizeWithFont: [UIFont fontWithName:@"Helvetica" size:17.0f]
                                    constrainedToSize:maximumSize
                                        lineBreakMode:UILineBreakModeWordWrap];
        
        Step *currentStep = [[[self recipe] stepList] objectAtIndex:index];
        
        CGSize labelHeighSize = [[currentStep desc] sizeWithFont: [UIFont fontWithName:@"Helvetica" size:17.0f]
                                               constrainedToSize:maximumSize
                                                   lineBreakMode:UILineBreakModeWordWrap];
        return labelHeighSize.height + heighOfOneLine.height*2;
    }
    return 0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[self recipe] stepList] count] > 0)
        return [[[self recipe] stepList] count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self recipe] stepList] count] > 0) {
        static NSString *CellIdentifier = @"StepCell";
        
        StepCell *cell = (StepCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        Step *currentStep = [[[self recipe] stepList] objectAtIndex:indexPath.row];
        
        if (cell == nil) 
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StepCell" owner:self options:nil];
            
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[StepCell class]]) {
                    cell = (StepCell*)currentObject;
                    break;
                }
            }
        }
        
        if(selectedIndex == indexPath.row)
        {
            cell.accessoryArrow.center = CGPointMake(278, 22);
            cell.accessoryArrow.transform = CGAffineTransformMakeRotation(3.14159265358979323846264338327950288/2);
        }
        else 
        {
            [cell.stepDescription setHidden:YES];
        }
        CGFloat labelHeight = [self getLabelHeightForIndex:indexPath.row];
        
        cell.stepDescription.frame = CGRectMake(cell.stepDescription.frame.origin.x, 
                                                cell.stepDescription.frame.origin.y, 
                                                cell.stepDescription.frame.size.width, 
                                                labelHeight);
        
        cell.stepIndentifier.text = [NSString stringWithFormat:@"Step %d: %@", indexPath.row+1, [[[[self recipe] stepList] objectAtIndex:indexPath.row] name]];
        cell.stepDescription.text  = [currentStep desc];
        
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [[cell textLabel] setText:@"No steps. Tap here or \"Add\" to add step"];
        [[cell textLabel] setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
        [[cell textLabel] setFont:[UIFont systemFontOfSize:15.00f]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    if ([[[self recipe] stepList] count] > 0) {
        if(selectedIndex == indexPath.row)
        {
            return [self getLabelHeightForIndex:indexPath.row] + COMMENT_LABEL_MIN_HEIGHT;
        }
        else {
            return COMMENT_LABEL_MIN_HEIGHT;
        }
    }
    return COMMENT_LABEL_MIN_HEIGHT;
}



-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //We only don't want to allow selection on any cells which cannot be expanded
    if ([[[self recipe] stepList] count] > 0) {
        if([self getLabelHeightForIndex:indexPath.row] > COMMENT_LABEL_MIN_HEIGHT)
        {
            return indexPath;
        }
        else {
            return nil;
        }
    }
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self recipe] stepList] count] > 0) {
        //The user is selecting the cell which is currently expanded
        //we want to minimize it back
        if(selectedIndex == indexPath.row)
        {
            selectedIndex = -1;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            return;
        }
        
        //First we check if a cell is already expanded.
        //If it is we want to minimize make sure it is reloaded to minimize it back
        if(selectedIndex >= 0)
        {
            NSIndexPath *previousPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            selectedIndex = indexPath.row;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];        
        }
        
        //Finally set the selected index to the new selection and reload it to expand
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self addStep:nil];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ediable || [[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:[[[self recipe] owner] userId]])
        return YES;
    return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        deleteConfirmAlert = [[UIAlertView alloc] initWithTitle:@"Delete Step" message:@"Do you really want to delete step. Delete step could not be reversed." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Delete", nil];
        [deleteConfirmAlert show];
        indexToDelete = indexPath;
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)deleteStepAtIndexPath:(NSIndexPath*)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Deleting Ingredient..."];
    
    Step *currentStep = (Step*)[[[self recipe] stepList] objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[GlobalStore deleteStepLink]];
    __weak __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
    [request setPostValue:[[self recipe] recipeId] forKey:@"rid"];
    [request setPostValue:[currentStep stepId] forKey:@"sid"];
    
    [request setCompletionBlock:^{
        if (request.responseStatusCode == 200) {
            if ([request.responseString isEqualToString:@"1"]) {
                [self didDeleteSteptAtIndex:indexPath];
            } else {
                [self didDeleteSteptAtIndex:nil];
            }
        } else {
            [self didDeleteSteptAtIndex:nil];
        }
    }];
    [request setFailedBlock:^{
        //            [self handleError:request.error];
    }];
    
    [request startAsynchronous];
}

- (void)didDeleteSteptAtIndex:(NSIndexPath*)indexPath
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (indexPath != nil) {
        selectedIndex = -1;
        [[[self recipe] stepList] removeObjectAtIndex:indexPath.row];
        [[self tableView] reloadData];
        if ([[[self recipe] ingredientList] count] == 1 || [[[self recipe] stepList] count] == 0)
            [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Step", [[[self recipe] stepList] count]]];
        else
            [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Steps", [[[self recipe] stepList] count]]];
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Could not delete step, please try again" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alertView show];
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    activeTextView = textView;
    return YES;
}

#pragma mark - UI Alert View Deletgate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self deleteStepAtIndexPath:indexToDelete];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
