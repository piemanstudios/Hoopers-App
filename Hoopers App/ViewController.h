//
//  ViewController.h
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewController.h"
#import "BookingTableViewController.h"
#import "Settings.h"

#import "GCCalendarPortraitView.h"


@interface ViewController : UIViewController <BookingTableViewControllerDelegate, SelectCustomerDelegate>
{
    IBOutlet CustomerTableViewController *customerTable;
    IBOutlet BookingTableViewController *bookingTable;
    IBOutlet GCCalendarPortraitView *cal;
    
    IBOutlet UIView *line;
    IBOutlet UIView *calView;
}

-(IBAction)settingsPressed:(UIBarButtonItem *)sender;


@end
