//
//  newJEntryViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "newJEntryViewController.h"

@interface newJEntryViewController ()

@end

@implementation newJEntryViewController
@synthesize jKey;
@synthesize mode;
@synthesize edit_bundle;
@synthesize journalUpdateDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cmdSaveAdd.layer.borderColor =  UIColor.blackColor.CGColor;
    _cmdSaveAdd.layer.borderWidth = 2;
    _cmdSaveAdd.layer.cornerRadius = 2;
    
    // Tap recognizers
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (void) keyboardWillShow: (NSNotification *) note
{
    [self.view addGestureRecognizer:tapRecognizer];
}
- (void) keyboardWillHide: (NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}
- (void) didTapAnywhere: (UITapGestureRecognizer *) recognizer
{
    [_txtEntryText resignFirstResponder];
    [_txtEntryTitle resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cmdSaveAdd_Tap:(id)sender {
    
    // We either add a new journal entry, or we'll be editing an existing, depending on the mode
    
    if ([_txtEntryTitle.text isEqualToString:@""])
    {
        AlertBox *errorAlert = [[AlertBox alloc] initWithDefaultErrorMessage:@"Please enter a journal entry title"];
        [self presentViewController:errorAlert.internalController animated:YES completion:nil];
        return;
    }
    if (self.mode == AddMode)
    {
        // Create a new journal entry, validate the input and call the
        //delegate method
        // Add Mode
        // Create the journal object
        DreamJournalEntry *entryToAdd = [[DreamJournalEntry alloc] initWithJournalEntryTitle: _txtEntryTitle.text];
        entryToAdd.JournalEntryText = _txtEntryText.text;
        [_delegate newJournalEntryCreated:entryToAdd]; // Call the delegate
        
    } else {
        // We're in Update mode - updating an existing journal entry
        self.edit_bundle.JournalEntryReference.Title = _txtEntryTitle.text; // Get the title from the text box
        self.edit_bundle.JournalEntryReference.JournalEntryText = _txtEntryText.text; // Updated text
        [journalUpdateDelegate JournalEntryWasUpdatedEdited:self.edit_bundle];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    if (self.mode == AddMode)
    {
        // Update the button's caption
        [_cmdSaveAdd setTitle:@"Save/Add" forState:UIControlStateNormal];
    } else {
        [_cmdSaveAdd setTitle:@"Update" forState:UIControlStateNormal];
        
        // Populate
        //NSLog(self.edit_bundle.JournalEntryReference.JournalEntryText);
        [_txtEntryText setText:self.edit_bundle.JournalEntryReference.JournalEntryText];
        // _txtEntryText.text = edit_bundle.JournalEntryReference.JournalEntryText;
        
        [_txtEntryTitle setText:edit_bundle.JournalEntryReference.Title];
        //_txtEntryTitle.text = edit_bundle.JournalEntryReference.Title;
    }
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
