//
//  TableViewEntryBrowserTableViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamJournalEntry.h"
#import "newJEntryViewController.h"
#import "JournalController.h"
#import "UINotificationBanner.h"
@interface TableViewEntryBrowserTableViewController : UITableViewController <EditUpdateJournalEntryDelegate>
{
   
}
@property (strong, nonatomic) IBOutlet UINavigationItem *tableViewTitle;
@property NSMutableArray *pJournalEntries;
@end
