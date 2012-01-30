//
//  SelectServices.h
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectServiceDelegate;

@interface SelectServices : UITableViewController
{
    id <SelectServiceDelegate> delegate;   
    NSArray *Service;
}

@property (nonatomic, assign) id <SelectServiceDelegate> delegate;

- (id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)array;
-(NSArray *)getAllServices;


@end

@protocol SelectServiceDelegate
-(void)SelectServiceScreen:(SelectServices *)screen didSelectService:(NSString *)name withKey:(NSString *)key;    
@end
