//
//  dcListViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-03.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamJournalEntry.h"
#import "newJEntryViewController.h"
#import "JournalController.h"
#import "UINotificationBanner.h"

@interface dcListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *dcTable;
@property NSMutableArray* dcList;
@end
