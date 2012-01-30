//
//  BookingTableViewController.h
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectHairDresser.h"
#import "SelectServices.h"
#import "SelectDate.h"
#import "Settings.h"
#import "CustomerTableViewController.h"

#import <EventKit/EventKit.h>
#import "GCCalendarPortraitView.h"

@protocol BookingTableViewControllerDelegate;

@interface BookingTableViewController : UITableViewController {
    id <BookingTableViewControllerDelegate> delegate;
    
    NSMutableDictionary *details;
    UIPopoverController *popover;
    
    EKEventStore *store;
}
@property (nonatomic, assign) id <BookingTableViewControllerDelegate> delegate;

-(IBAction)createPressed:(id)sender;
-(IBAction)clearPressed:(id)sender;
-(IBAction)settingsPressed:(id)sender;

@end

@protocol BookingTableViewControllerDelegate
-(void)bookingTable:(BookingTableViewController *)table didChangeDate:(NSDate *)date;
@end