//
//  journalOptionsViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-16.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "journalOptionsViewController.h"

#define defaultJournalKey @"journal"
@interface journalOptionsViewController ()

@end

@implementation journalOptionsViewController
@synthesize Options_JOwner, Options_JTitle, Options_CreateDate, refKey; // Properties passed forward

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cmdCancel_Tap:(id)sender {
    
    // Cancel and dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    [ _txtJournalTitle setText: self.Options_JTitle];
    _lblOwnerName.text = [_lblOwnerName.text stringByAppendingString:self.Options_JOwner];
    _lblCreateDate.text = [_lblCreateDate.text stringByAppendingString:self.Options_CreateDate];
}
- (IBAction)cmdDeleteJournal_Tap:(id)sender
{
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSLog(@"Dream Journal has been deleted (test)");
        
        [JournalController deleteJournalArchieve:defaultJournalKey];
        [_delegate didDeleteJournal]; // Call Delegate Function
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel aborted");
    }];
    NSArray *alertActionsArray = [NSArray arrayWithObjects:okAction, cancelAction, nil];
    AlertBox *_alertDialog = [[AlertBox alloc] initWithTitleStringAndActionButtons:@"Delete Journal" :@"Are you sure you want to delete this journal. Action cannot be undone" :alertActionsArray];
    [self presentViewController:_alertDialog.internalController animated:YES completion:nil];
    
}
- (IBAction)cmdRenameJournal_Tap:(id)sender {
    
    // Prompt user to enter a new name with a InputUserBox
    
    UIAlertController *alertbox = [UIAlertController alertControllerWithTitle:@"Change Journal Title" message:@"Enter a new title for your journal:" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertbox addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.textColor = [UIColor blackColor];
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.borderStyle = UITextBorderStyleNone;
     }];
    
    [alertbox addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Action - this will change the name of the journal title
        
        if (![alertbox.textFields[0].text isEqualToString:@""])
        {
            DreamJournal *j = [JournalController getArchievedDreamJournal:refKey];
            // Load the journal
            j.Title = alertbox.textFields[0].text; // Update the title
            
            // Save the data
            [JournalController saveArchieveDreamJournal:j forWhatKey:refKey];
            NSLog(@"User inputted: %@", alertbox.textFields[0].text);
            [UINotificationBanner showBannerWithMessage:@"Journal was renamed." forDuration:3];
        }
        
    }]];
    [alertbox addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //This will cancel out
        NSLog(@"User tapped cancel");
    }]];
    [self presentViewController:alertbox animated:YES completion:nil];
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