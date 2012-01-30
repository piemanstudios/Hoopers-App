//
//  EditName.h
//  ProjectManager
//
//  Created by Matthew Stephens on 28/12/2010.
//  Copyright 2010 Pieman Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditNameDelegate;


@interface EditName : UIViewController {
	id <EditNameDelegate> delegate;
	
	UITextField *textField;
	IBOutlet UITableView *myTableView;
	NSString *text;
}
@property (nonatomic,assign) id <EditNameDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withName:(NSString *)name;

@end

@protocol EditNameDelegate
-(void)editName:(EditName *)screen didChangeText:(NSString *)text;
-(void)editName:(EditName *)screen didChangeText:(NSString *)text previousText:(NSString *)prev;

@end