//
//  BookingTableViewController.m
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BookingTableViewController.h"


@implementation BookingTableViewController
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    
    
    details = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDate date], @"Date", nil];
    
    store = [[EKEventStore alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) settingsPressed;
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 2;
    }	
    else if (section == 2) {
        return 1;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Customer";
        cell.detailTextLabel.text = [details objectForKey:@"Customer"];
    }
    if (indexPath.section ==1) {
        
        if (indexPath.row ==0) {
            cell.textLabel.text = @"By:";
            cell.detailTextLabel.text = [details objectForKey:@"Hairdressor Name"];   
        }
        
        
        if (indexPath.row ==1) { 
            cell.textLabel.text = @"Require:";    
            cell.detailTextLabel.text = [details objectForKey:@"Service"];
            
        }}
    if (indexPath.section ==2) {
        cell.textLabel.text = @"Date";
        
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MMM yyyy hh:mma"];
        NSString *dateString = [dateFormat stringFromDate:[details objectForKey:@"Date"]];
        NSLog(@"date: %@", dateString);
        [dateFormat release];
        
        cell.detailTextLabel.text = dateString;
    }
    
    return cell;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    if (section == 0) {
        return @"Customer";
    }
    else if (section ==1) {
        return @"Details";
    }
    else
        return @"Date";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            SelectHairDresser *hairDresser = [[SelectHairDresser alloc] initWithStyle:UITableViewStylePlain];
            [hairDresser setDelegate:self];
            UINavigationController *cont = [[UINavigationController alloc] initWithRootViewController:hairDresser];
            
            popover = [[UIPopoverController alloc] initWithContentViewController:cont];
            
            [popover presentPopoverFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else if (indexPath.row ==1) {
            SelectServices *Service = [[SelectServices alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *cont = [[UINavigationController alloc] initWithRootViewController:Service];
            [Service setDelegate:self];
            
            popover = [[UIPopoverController alloc] initWithContentViewController:cont];
            
            [popover presentPopoverFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        
    }   
    else if (indexPath.section ==2)
    {
       
        SelectDate *Date = [[SelectDate alloc] initWithNibName:@"SelectDate" bundle:nil];
        [Date setDelegate:self];
        UINavigationController *cont = [[UINavigationController alloc] initWithRootViewController:Date];
//        [cont.view setFrame:CGRectMake(0, 0, 320, 216)];
        
        popover = [[UIPopoverController alloc] initWithContentViewController:cont];
        [popover setPopoverContentSize:CGSizeMake(320, 260)];
        
        [popover presentPopoverFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)SelectHairDressorScreen:(SelectHairDresser *)screen didSelectHairDressor:(NSString *)name;    
{
    [details setObject:name forKey:@"Hairdressor Name"];
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}

-(void)SelectServiceScreen:(SelectServices *)screen didSelectService:(NSString *)name;    
{
    [details setObject:name forKey:@"Service"];
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}

-(void)SelectDateScreen:(SelectDate *)screen didSelectDate:(NSDate *)date; 
{
    [details setObject:date forKey:@"Date"];
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
    [self.delegate bookingTable:self didChangeDate:date];
}

-(void)SelectCustomerScreen:(CustomerTableViewController   *)screen didSelectCustomer:(NSString *)name;    
{
    [details setObject:name forKey:@"Customer"];
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}

-(void)SelectDateScreenDismissPopover:(SelectDate *)screen; 
{
    [popover dismissPopoverAnimated:YES];
}


#pragma mark - Interface buttons

-(IBAction)createPressed:(id)sender;
{
    if ([[details objectForKey:@"Customer"] length] > 0 && [[details objectForKey:@"Hairdressor Name"] length] > 0 && [[details objectForKey:@"Service"] length] > 0) {
        
        
        EKEvent *booking = [EKEvent eventWithEventStore:store];
        booking.title = [NSString stringWithFormat:@"%@: %@",[details objectForKey:@"Customer"],[details objectForKey:@"Service"]];
        booking.startDate = [details objectForKey:@"Date"];
        booking.endDate   = [[NSDate alloc] initWithTimeInterval:(60*45) sinceDate:booking.startDate];
        
        for (EKCalendar *cal in [store calendars]) {
            if ([[cal title] isEqualToString:[details objectForKey:@"Hairdressor Name"]]) {
                booking.calendar = cal;
                break;
            }
        }
        NSError *error;
        if (![store saveEvent:booking span:EKSpanThisEvent error:&error]) {
            [[[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Unable to create this booking: %@",error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
        }
        else {
            [[[[UIAlertView alloc] initWithTitle:@"Success" message:@"Booking successfully added!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
            [self clearPressed:nil];
        }
    }
    else {
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Not all fields are filled in" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
    }
}

-(IBAction)clearPressed:(id)sender;
{
    [details setObject:@"" forKey:@"Customer"];
    [details setObject:@"" forKey:@"Service"];
    [details setObject:@"" forKey:@"Hairdressor Name"];
    [details setObject:[NSDate date] forKey:@"Date"];
    [self.tableView reloadData];
}



@end
