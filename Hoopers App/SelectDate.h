//
//  SelectDate.h
//  Hoopers App
//
//  Created by Ollie on 19/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectDateDelegate;

@interface SelectDate : UIViewController
{
    IBOutlet UIDatePicker *picker;
    id <SelectDateDelegate> delegate;
}
@property (nonatomic, assign) id <SelectDateDelegate> delegate;

@end

@protocol SelectDateDelegate
-(void)SelectDateScreen:(SelectDate *)screen didSelectDate:(NSDate *)date; 

-(void)SelectDateScreenDismissPopover:(SelectDate *)screen; 


@end
