//
//  CustomerTableViewController.m
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomerTableViewController.h"

@implementation CustomerTableViewController
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    customers = [[NSArray alloc] initWithObjects:@"Matt",@"Smells", nil];

    sectionHeaders = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
    
    
    [self loadPeople];
}

-(void)loadPeople;
{
    NSMutableArray* bContacts = [[NSMutableArray alloc] init];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for( int i = 0 ; i < nPeople ; i++ )
    {
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i );
        
        NSString *firstName = (NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        NSString *lastName = (NSString *)ABRecordCopyValue(ref, kABPersonLastNameProperty);
        
        NSString *name;
        BOOL add;
        
        if ([firstName length] > 0) {
            add = YES;
            if ([lastName length] > 0) {
                name = [[NSString alloc] initWithFormat:@"%@ %@",firstName,lastName];
            }
            else {
                name = [[NSString alloc] initWithFormat:@"%@",firstName];
            }
        }
        else if ([lastName length] > 0) {
            add = YES;
            name = [[NSString alloc] initWithFormat:@"%@",lastName];
        }
        if (add) {    
            [bContacts addObject:name];
        }
    }
    
    
    customers = [[NSArray alloc] initWithArray:[bContacts sortedArrayUsingSelector:@selector(compare:)]];
    
    sortedCustomers = [[NSMutableArray alloc] initWithCapacity:27];
    
    for (int i = 0; i < 26; i ++) {
        NSString *header = [sectionHeaders objectAtIndex:i];
        [sortedCustomers addObject:[self getArrayForHeader:header forItems:customers]];
    }
    
    [sortedCustomers addObject:[self getAllItemsNotAlreadyInArray:sortedCustomers fromItems:customers]];
    
    [self.tableView reloadData];
}

-(NSArray *)getArrayForHeader:(NSString *)header forItems:(NSArray *)items;
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    for (NSString *name in items) {
        if ([[[name substringToIndex:1] uppercaseString] isEqualToString:header]) {
            [ret addObject:name];
        }
    }
    return ret;
}

-(NSArray *)getAllItemsNotAlreadyInArray:(NSArray *)totArr fromItems:(NSArray *)allItems;
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    for (NSString *str in allItems) {
        BOOL found = NO;
        for (NSArray *arr in totArr) {
            if ([arr containsObject:str]) {
                found = YES;
                break;
            }
        }
        if (!found) {
            [ret addObject:str];
        }
    }
    return ret;
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
    return [sortedCustomers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[sortedCustomers objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[sortedCustomers objectAtIndex:indexPath.section] objectAtIndex:indexPath. row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    return [sectionHeaders objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
{
    return sectionHeaders;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))
{
    return [sectionHeaders indexOfObject:title];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate SelectCustomerScreen:self didSelectCustomer:[[sortedCustomers objectAtIndex:indexPath.section] objectAtIndex:indexPath. row]];

}

#pragma mark - Interface Buttons
-(IBAction)addPerson:(id)sender;
{
    ABNewPersonViewController *new = [[ABNewPersonViewController alloc] init];
    [new setNewPersonViewDelegate:self];
    UINavigationController *cont = [[UINavigationController alloc] initWithRootViewController:new];
    [cont setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentModalViewController:cont animated:YES];
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person;
{
    if (person != NULL) {
        // Person created!
        
        // Reload all of the people
        [self loadPeople];

    }
    
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)clearPressed:(id)sender;
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathsForSelectedRows] animated:YES];
}

@end
