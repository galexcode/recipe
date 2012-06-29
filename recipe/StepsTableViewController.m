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
#import "RecipeNavigationLabel.h"
#import "StepCell.h"
#import "Step.h"

@interface StepsTableViewController ()

@end

@implementation StepsTableViewController
@synthesize recipe = _recipe;
@synthesize steps = _steps;
@synthesize stepForm;

- (id)initWithEditableTable
{
    self = [super initWithNibName:@"StepsTableViewController" bundle:nil];
    if (self) {
        ediable = YES;
    }
    return self;
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
    
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    
    selectedIndex = 0;
    
    if (ediable) {
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
}

- (void)cancelAddStep:(id)sender
{
    [barButton setTitle:@"Add"];
    [barButton setAction:@selector(addStep:)];
    [stepForm setHidden:YES];
}

- (void)viewDidUnload
{
    [self setStepForm:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//This just a convenience function to get the height of the label based on the comment text
-(CGFloat)getLabelHeightForIndex:(NSInteger)index
{
    if ([[self steps] count] > 0) {
        CGSize maximumSize = CGSizeMake(COMMENT_LABEL_WIDTH, 10000);
        
        NSString *oneLine = [NSString stringWithString:@"1 line"];
        
        CGSize heighOfOneLine = [oneLine sizeWithFont: [UIFont fontWithName:@"Helvetica" size:17.0f]
                                    constrainedToSize:maximumSize
                                        lineBreakMode:UILineBreakModeWordWrap];
        
        Step *currentStep = [[self steps] objectAtIndex:index];
        
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
    if ([[self steps] count] > 0)
        return [self.steps count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self steps] count] > 0) {
        static NSString *CellIdentifier = @"StepCell";
        
        StepCell *cell = (StepCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        Step *currentStep = [[self steps] objectAtIndex:indexPath.row];
        
        if (cell == nil) 
        {
            //NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:nil options:nil];
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
        
        cell.stepIndentifier.text = [NSString stringWithFormat:@"Step %d", indexPath.row+1];
        cell.stepDescription.text  = [currentStep desc];
        
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [[cell textLabel] setText:@"No steps. Tap \"Add\" to add step"];
        [[cell textLabel] setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
        [[cell textLabel] setFont:[UIFont systemFontOfSize:15.00f]];
//        [[cell textLabel] setLineBreakMode:UILineBreakModeWordWrap];
//        [[cell textLabel] setNumberOfLines:2];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    if ([[self steps] count] > 0) {
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
    if ([[self steps] count] > 0) {
        if([self getLabelHeightForIndex:indexPath.row] > COMMENT_LABEL_MIN_HEIGHT)
        {
            return indexPath;
        }
        else {
            return nil;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self steps] count] > 0) {
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
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
