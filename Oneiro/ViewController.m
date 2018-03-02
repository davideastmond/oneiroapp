//
//  ViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-01-28.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "ViewController.h"
#import "DreamJournal.h"

#define defaultJournalKey @"journal"

@interface ViewController ()

@end

@implementation ViewController 
@synthesize currentJournalTitle, CreateDate, OwnerName;
- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    // Do any additional setup after loading the view.

     
     
    // Check if a journal exists
    */
    //[self DeleteJournalEntryFromSystemForKey:defaultJournalKey]; // Test to default
    //NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:defaultJournalKey];
    
   
    
    DreamJournal *Journal;
    
    if ([JournalController isSavedJournalPresent:defaultJournalKey] == false)
    {
        // The data is nil, so create a new entry
        NSLog(@"No default entry was found:creating new");
        
        // We need to change the screen input to allow user to create
        Journal = [self createDefaultJournalEntryObject];
        
        [self performSegueWithIdentifier:@"segue_registerNewJournal" sender:self];
        [self enableStartScreenOptions:NO];
    } else
    {
        Journal = [JournalController getArchievedDreamJournal:defaultJournalKey];
        NSLog(@"Data was correctly found. Reading from file");
        [_cmdCreateNewJournal setHidden:YES];
        // Journal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        // Set the properties of current journal
        self.currentJournalTitle = Journal.Title;
        self.OwnerName = [Journal getJournalOwnerFullNameAsString];
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
        [tempFormatter setDateFormat:@"yyyy-MM-dd"];
        self.CreateDate = [tempFormatter stringFromDate:Journal.CreateDate];
        
        [self enableStartScreenOptions:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) DeleteJournalEntryFromSystemForKey: (NSString *) archKey
{
    // Deletest the object from memory
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:archKey];
}
- (id) createDefaultJournalEntryObject
{
    // Creates a default journal entry if none is found
    NSDateComponents *date_comps = [[NSDateComponents alloc] init];
    
    [date_comps setDay:15];
    [date_comps setMonth:10];
    [date_comps setYear:1981];
    NSDate *dob = [[NSCalendar currentCalendar] dateFromComponents:date_comps];
    
    JournalOwner *jOwner =  [[JournalOwner alloc] initWithOwnerFirstAndLastName: @"David" withLastName:@"Eastmond" withDateOfBirth:dob];
    
    DreamJournal *journal = [[DreamJournal alloc] initWithTitleOwnerAndDefaultEntry:@"default title"
                                                                                   : jOwner];
    // DreamCharacter *obj = [[DreamCharacter alloc] initWithNameAndGender:@"david" :male];
    // [[journal journalEntries] addObject:obj];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:journal];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:defaultJournalKey];
    
    return journal;
}
- (void) didCreateNewJournal:(DreamJournal *)info
{
    // Delegate function
    [self.navigationController popViewControllerAnimated:YES];
    if (info == nil)
    {
        NSLog(@"User clicked cancel. Delegate");
        [self enableStartScreenOptions:NO];
    } else
    {
        NSLog(@"Received delegate object and saved file");
        [UINotificationBanner showBannerWithMessage:@"Journal was created" forDuration:3];
        [self enableStartScreenOptions:YES];
    }
}

- (void) didDeleteJournal
{
    // Delegate function. User deleted the journal
    [self.navigationController popViewControllerAnimated:YES]; //Dismiss
    [self enableStartScreenOptions:NO]; // User is forced only to create a new journal
    NSLog(@"Deleted Journal Delegate");
    [UINotificationBanner showBannerWithMessage:@"Journal was deleted." forDuration:3  ];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segue_JournalOptions"])
    {
        // Options
        journalOptionsViewController *optionsControllerSegue = [[journalOptionsViewController alloc] init];
        optionsControllerSegue = (journalOptionsViewController *) segue.destinationViewController;
        optionsControllerSegue.Options_CreateDate = self.CreateDate;
        optionsControllerSegue.Options_JOwner = self.OwnerName;
        optionsControllerSegue.Options_JTitle = self.currentJournalTitle;
        optionsControllerSegue.refKey = defaultJournalKey;
        optionsControllerSegue.delegate = self;
        NSLog(@"Segue to journal options");
    } else if ([segue.identifier isEqualToString:@"segueNewJEntry"])
    {
        // New Journal entry segue
        newJEntryViewController *newENtryVC = [[newJEntryViewController alloc] init];
        newENtryVC = (newJEntryViewController *) segue.destinationViewController;
        newENtryVC.delegate = self;
        newENtryVC.mode = AddMode; // Set to add mode (versus edit mode)
        newENtryVC.jKey = defaultJournalKey;
        
    } else if ([segue.identifier isEqualToString:@"segueShowEntryBrowser"])
    {
        TableViewEntryBrowserTableViewController *tableViewEntryBrowser = (TableViewEntryBrowserTableViewController *) segue.destinationViewController;
        
        // Get the entries
        DreamJournal *j = [JournalController getArchievedDreamJournal:defaultJournalKey];
        // Pass the data forward
        tableViewEntryBrowser.pJournalEntries = j.journalEntries; 
    }
    /*
    newJournalViewController *newJ = segue.destinationViewController;
    
    newJ.delegate = self;
    [self.navigationController popViewControllerAnimated:YES]; */
}
- (void) enableStartScreenOptions  : (BOOL) opts
{
    // This is for disabling or enabling features
    
    // If false then the only option should be "Create new dream journal"
    
    if (opts == NO)
    {
        // Disable the new entry, options and browse features
        [_cmdCreateNewJournal setHidden:NO];
        [_cmdBrowse setHidden:YES];
        [_cmdNewJournalEntry setHidden:YES];
        [_cmdJournalOptions setHidden:YES];
        NSLog(@"Start screen options are disabled");
    } else
    {
        [_cmdCreateNewJournal setHidden:YES];
        [_cmdBrowse setHidden:NO];
        [_cmdNewJournalEntry setHidden:NO];
        [_cmdJournalOptions setHidden:NO];
        NSLog(@"Start screen options are enabled");
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"View Will Appear! Main view controller");
}
- (void)newJournalEntryCreated:(DreamJournalEntry *)createdEntry
{
    // Delegate function
    // Get the created entry and add it to the Journal
    [self.navigationController popViewControllerAnimated:YES];
    
    //Use the journal controller to add the journalentry to the journal data
    [JournalController addJournalEntryToJournal:createdEntry forWhatKey:defaultJournalKey];
    NSLog(@"Journal Entry was added. Entry count is now %lu", [JournalController getJournalEntryCount:defaultJournalKey] );
    
    [UINotificationBanner showBannerWithMessage:@"Entry Added" forDuration:3];
    // TEST DEBUG - print all entries
   // [JournalController debugPrintJournalEntries:defaultJournalKey];
}
- (IBAction)cmdTest_Tap:(id)sender
{
    [UINotificationBanner showBannerWithMessage:@"Your selected an entry" forDuration:3];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end