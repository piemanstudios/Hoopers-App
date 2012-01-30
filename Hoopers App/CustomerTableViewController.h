//
//  CustomerTableViewController.h
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@protocol SelectCustomerDelegate;

@interface CustomerTableViewController : UITableViewController{
    id <SelectCustomerDelegate> delegate;

    NSArray *customers, *sectionHeaders;
    NSMutableArray *sortedCustomers;
}
@property (nonatomic, assign) id <SelectCustomerDelegate> delegate;

-(id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)array;
-(IBAction)addPerson:(id)sender;
-(void)loadPeople;
-(NSArray *)getArrayForHeader:(NSString *)header forItems:(NSArray *)items;
-(NSArray *)getAllItemsNotAlreadyInArray:(NSArray *)totArr fromItems:(NSArray *)allItems;
-(IBAction)clearPressed:(id)sender;

@end

@protocol SelectCustomerDelegate

-(void)SelectCustomerScreen:(CustomerTableViewController *)screen didSelectCustomer:(NSString *)name;    

@end


