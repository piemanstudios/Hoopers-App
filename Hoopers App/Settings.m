//
//  Settings.m
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"


@implementation Settings

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

    self.navigationItem.title = @"Settings";
    [self.tableView setEditing:YES];
    [self.tableView setAllowsSelectionDuringEditing:YES];
    
    services = [[NSMutableArray alloc] initWithArray:[self getAllServices]];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [services count] + 1;
    }
    else {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0) {
        if (indexPath.row == [services count]) {
            cell.textLabel.text = @"Add Service";
        }
        else {
            cell.textLabel.text = [services objectAtIndex:indexPath.row];            
        }
    }
    else {
        cell.textLabel.text = @"Email Support";
    }
    
    
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        if (indexPath.row == [services count]) {
            return UITableViewCellEditingStyleInsert;
        }
        else {
            return UITableViewCellEditingStyleDelete;
        }
    }
    else {
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    int index = indexPath.row - 1;
    [services removeObjectAtIndex:index];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self saveServices:services];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == [services count]) {
            // Add a new service
            EditName *name = [[EditName alloc] initWithNibName:@"EditName" bundle:nil withName:@""];
            [name setDelegate:self];
            [name.navigationItem setTitle:@"Create Service"];
            [self.navigationController pushViewController:name animated:YES];
        }
        else {
            EditName *name = [[EditName alloc] initWithNibName:@"EditName" bundle:nil withName:[services objectAtIndex:indexPath.row]];
            [name setDelegate:self];
            [name.navigationItem setTitle:@"Edit Service"];
            [self.navigationController pushViewController:name animated:YES];
        }
    }
    else {
        // Show email screen
        
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        [mail setMailComposeDelegate:self];
        [mail setSubject:@"Hoopers App Support"];
        [mail setToRecipients:[NSArray arrayWithObject:@"support@piemanstudios.com"]];
        [mail setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentModalViewController:mail animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    if (section == 0) {
        return @"Edit services available";
    }
    else {
        return @"";
    }
}

#pragma mark - Loading and Saving the services


-(void)saveServices:(NSArray *)Qservices;
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Save.plist"];
	
	
	NSMutableDictionary *holderDict = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] autorelease];
	
	if (holderDict == nil) {
		NSString *pathURL = [NSString stringWithString:[[NSBundle mainBundle] pathForResource:@"Save" ofType:@"plist"]];
		holderDict = [NSMutableDictionary dictionaryWithContentsOfFile:pathURL];
	}
	
	[holderDict setObject:Qservices forKey:@"Services"];
	
	[holderDict writeToFile:path atomically:YES];
}

-(NSArray *)getAllServices;
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Save.plist"];
	
	
	NSMutableDictionary *holderDict = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] autorelease];
	
	if (holderDict == nil) {
		NSString *pathURL = [NSString stringWithString:[[NSBundle mainBundle] pathForResource:@"Save" ofType:@"plist"]];
		holderDict = [NSMutableDictionary dictionaryWithContentsOfFile:pathURL];
	}
	
	return [holderDict objectForKey:@"Services"];
}

#pragma mark - EditNameDelegate

-(void)editName:(EditName *)screen didChangeText:(NSString *)text previousText:(NSString *)prev;
{
    if ([prev length] == 0) {
        // Is a new item
        [services addObject:text];
        [self.tableView reloadData];

       // [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[services count] + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    else {
        // Edited a previous item
        int index;
        for (NSString *str in services) {
            if ([prev isEqualToString:str]) {
                index = [services indexOfObject:str];
                break;
            }
        }
        [services replaceObjectAtIndex:index withObject:text];
        [self.tableView reloadData];
    }
    [self saveServices:services];
}

#pragma mark - Mail Compose Delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
