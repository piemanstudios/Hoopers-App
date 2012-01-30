//
//  Settings.h
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditName.h"
#import <MessageUI/MessageUI.h>

@interface Settings : UITableViewController <EditNameDelegate> {
    
    NSMutableArray *services;
}
-(void)saveServices:(NSArray *)Qservices;
-(NSArray *)getAllServices;

@end
