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
#import "ritAttributes.h"
#import "ritProduct.h"

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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray* cells = [[NSMutableArray alloc] initWithArray:[self.tableView visibleCells]];
    for(int i = 0; i < [cells count]; ++i)
    {
        [cells[i] setUserInteractionEnabled:YES];
    }
    [self.tableView reloadData];
    _globalAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedContact = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    //Point to snap to
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGPoint point = CGPointMake(screenRect.size.width/2, screenRect.size.height/3);
    
    //Cell to snap to point
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //Set the cell to snap to the point
    _snapBehavior = [[UISnapBehavior alloc] initWithItem:cell snapToPoint:point];
    
    //Add gravity to all other cells
    NSMutableArray* cells = [[NSMutableArray alloc] initWithArray:[tableView visibleCells]];
    for(int i = 0; i < [cells count]; ++i)
    {
        [cells[i] setUserInteractionEnabled:NO];
    }
    [cells removeObject:cell];
    _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:cells];
    _gravityBehavior.magnitude = 1;
    
    //Add behaviors to the animator (this causes them to run)
    [_globalAnimator addBehavior:_snapBehavior];
    [_globalAnimator addBehavior:_gravityBehavior];
    
    //ritShopScreenViewController* shopView = [[ritShopScreenViewController alloc] initWithCell:cell];
    double delayInSeconds = 0.74;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        [self performSegueWithIdentifier:@"ShopScreenSegue" sender:(self)];
    });
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"ShopScreenSegue"])
    {
        ritShopScreenViewController *sequeView = segue.destinationViewController;
        sequeView.contact = _selectedContact;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add database manager
    _dbManager = [[ritDatabaseManager alloc] init];
    
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

- (IBAction)addGiftee:(id)sender {
    [self performSegueWithIdentifier:@"NewContactSegue" sender:(self)];
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
    [self.view setNeedsDisplay];
}

- (IBAction)unwindToGifteeViewControllerWithInfo:(UIStoryboardSegue *)unwindSegue
{
    ritNewContactViewController* sourceController = unwindSegue.sourceViewController;
    NSString* contactName = sourceController.contactName.text;
    ritAttributes* contactAttr = sourceController.contactAttr;
    if([contactName length] > 0 && ([_dbManager hasContact:contactName] == NO))
    {
        [_dbManager addContact:contactName];
        [[ritRemoteDataManager getInstance] postContact:contactName withAttributes:contactAttr];
    }
    [self.tableView reloadData];
}
@end
