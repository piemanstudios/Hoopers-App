//
//  SelectDate.m
//  Hoopers App
//
//  Created by Ollie on 19/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectDate.h"

@implementation SelectDate
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    self.navigationItem.title = @"Date";

    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPressed)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(savePressed)];
    self.navigationItem.rightBarButtonItem = save;                     
                             
                                
                                
                                
    // Do any additional setup after loading the view from its nib.
}

                             
- (void)savePressed;
{
    [self.delegate SelectDateScreen:self didSelectDate:picker.date];
    [self.delegate SelectDateScreenDismissPopover:self];
}
                             
- (void)cancelPressed;
{   
    [self.delegate SelectDateScreenDismissPopover:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
