//
//  ritGifteeViewController.m
//  ritioschallenge
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritGifteeViewController.h"
#import "ritNewContactViewController.h"
#import "ritShopScreenViewController.h"
#import "ritProfileViewController.h"
#import "ritRemoteDataManager.h"

@interface ritGifteeViewController ()

@end

@implementation ritGifteeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    _selectedContact = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self performSegueWithIdentifier:@"ShopScreenSegue" sender:(self)];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"ShopScreenSegue"])
    {
        ritShopScreenViewController *sequeView = segue.destinationViewController;
        sequeView.contact = _selectedContact;
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath != nil)
    {
        //NSLog(@"long press on table view but not on a row");
        ritProfileViewController* profileView = [[ritProfileViewController alloc] init];
        profileView.modalPresentationStyle =  UIModalTransitionStyleCrossDissolve;
        [self presentViewController:profileView animated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add long press recognizer
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    //Add database manager
    _dbManager = [[ritDatabaseManager alloc] init];
    
    
    ritRemoteDataManager* dataManager = [[ritRemoteDataManager alloc] init];
    [dataManager postContact:@"Mohsin" withAttributes:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dbManager.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier ];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cell.textLabel.text = [_dbManager.contacts objectAtIndex:(indexPath.row)];
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_dbManager deleteContact:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
        //NSLog(@"%@", indexPath);
        //NSLog(@"%@", [tableView cellForRowAtIndexPath:indexPath].textLabel.text);
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)addGiftee:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Contact Option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Contact List",
                            @"New Contact",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //Bring up address book
            break;
        case 1:
            //New contact
            [self performSegueWithIdentifier:@"NewContactSegue" sender:(self)];
        default:
            break;
    }
}


- (IBAction)unwindToGifteeViewController:(UIStoryboardSegue *)unwindSegue
{
    //updateList();
}
- (IBAction)unwindToGifteeViewControllerWithInfo:(UIStoryboardSegue *)unwindSegue
{
    ritNewContactViewController* sourceController = unwindSegue.sourceViewController;
    NSString* newName = sourceController.contactName.text;
    if([newName length] > 0 && ([_dbManager hasContact:newName] == NO))
    {
        [_dbManager addContact:sourceController.contactName.text];
    }
    [self.tableView reloadData];
}
@end
