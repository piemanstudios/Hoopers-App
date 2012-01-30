//
//  SelectHairDresser.h
//  Hoopers App
//
//  Created by Ollie on 16/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>


@protocol SelectHairDressorDelegate;


@interface SelectHairDresser : UITableViewController{
    id <SelectHairDressorDelegate> delegate;

    NSArray *HairDressors;
    
    EKEventStore *store;
    
}
@property (nonatomic, assign) id <SelectHairDressorDelegate> delegate;

- (id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)array;


@end

@protocol SelectHairDressorDelegate
-(void)SelectHairDressorScreen:(SelectHairDresser *)screen didSelectHairDressor:(NSString *)name;    
@end