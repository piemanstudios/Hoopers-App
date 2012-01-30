//
//  ViewController.m
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GCCalendarEvent.h"
#import "GCCalendar.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [customerTable setDelegate:bookingTable];
    [bookingTable setDelegate:self];
    
    cal = [[[GCCalendarPortraitView alloc] init] autorelease];
    
    UINavigationController *cont = [[UINavigationController alloc] initWithRootViewController:cal];
    [cont setNavigationBarHidden:YES];
    [cont.view setFrame:calView.frame];
    [cont.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:cont.view];

    cal.dataSource = self;
    cal.delegate = self;
    
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
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
{
    [cal reloadData];
}


-(IBAction)settingsPressed:(UIBarButtonItem *)sender;
{
    Settings *settings = [[Settings alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:settings];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navCont];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark GCCalendarDataSource

- (NSArray *)calendarEventsForDate:(NSDate *)date {
	NSMutableArray *events = [NSMutableArray array];
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:
									(NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
																   fromDate:date];
	[components setSecond:0];
    
	// create 5 calendar events that aren't all day events
	for (NSInteger i = 0; i < 5; i++) {
		GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
		event.color = [[GCCalendar colors] objectAtIndex:i];
		event.allDayEvent = NO;
		event.eventName = [event.color capitalizedString];
		event.eventDescription = event.eventName;
		
		[components setHour:12 + i];
		[components setMinute:0];
		
		event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[components setMinute:50];
		
		event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[events addObject:event];
		[event release];
	}
    
    
	GCCalendarEvent *evt = [[GCCalendarEvent alloc] init];
	evt.color = [[GCCalendar colors] objectAtIndex:1];
	evt.allDayEvent = NO;
	evt.eventName = @"Test event";
	evt.eventDescription = @"Description for test event. This is intentionnaly too long to stay on a single line.";
	[components setHour:18];
	[components setMinute:0];
	evt.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
	[components setHour:20];
	evt.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
	[events addObject:evt];
	[evt release];
	
	// create an all day event
	GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
	event.allDayEvent = YES;
	event.eventName = @"All Day Event";
	[events addObject:event];
	[event release];
	
	return events;
}

#pragma mark GCCalendarDelegate
- (void)calendarTileTouchedInView:(GCCalendarView *)view withEvent:(GCCalendarEvent *)event {
	NSLog(@"Touch event %@", event.eventName);
}
- (void)calendarViewAddButtonPressed:(GCCalendarView *)view {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Booking Table Delegate
-(void)bookingTable:(BookingTableViewController *)table didChangeDate:(NSDate *)date;
{
    [cal newDateSet:date];
}

@end
