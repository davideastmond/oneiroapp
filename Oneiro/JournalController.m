//
//  JournalController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "JournalController.h"
#define backUpJournal @"bckup"

@implementation JournalController

+(DreamJournal *) getArchievedDreamJournal : (NSString *) forWhatKey
{
    // Method for retrieving the journal data
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:forWhatKey];
    DreamJournal *returnJournal;
    
    returnJournal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return returnJournal;
}
+ (void) saveArchieveDreamJournal : (DreamJournal *) journalToSave
                       forWhatKey : (NSString *) key
{
    //Delete the old key
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:journalToSave];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}
+ (bool) isSavedJournalPresent:(NSString *)forWhatKey
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:forWhatKey];
    if (data == nil)
    {
        NSLog(@"No journal found for key %@", forWhatKey);
        return false;
    }
    return true;
}
+ (void) deleteJournalArchieve:(NSString *)forWhatKey
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:forWhatKey] == nil)
    {
        // There is an error
        NSLog(@"Key does not exist or error");
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:forWhatKey];
        NSLog(@"Journal deleted");
    }
}
+ (void) addJournalEntryToJournal:(DreamJournalEntry *)entry forWhatKey:(NSString *)key
{
    DreamJournal *j = [self getArchievedDreamJournal:key];
    if (j != nil)
    {
        [j addEntryToJournal:entry];
    
    
        // Save the journal to disk
        [self saveArchieveDreamJournal:j forWhatKey:key];
    } else {
        //Nothing was saved
        NSLog(@"Unable to add journal entry.");
    }
}
+ (NSInteger) getJournalEntryCount:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal:forWhatKey];
    NSInteger returnCount = 0;
    if (j != nil)
    {
        returnCount=  j.journalEntries.count;
    }
    return returnCount;
}
+(void) debugPrintJournalEntries:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal: forWhatKey];
    
    for (int b = 0; b <= j.journalEntries.count - 1; b++)
    {
        DreamJournalEntry *Entry = [j getJournalEntryForEntryIndex:b];
        NSLog(@"Entry %d is titled %@", b, Entry.Title);
        NSLog(@"Text reads: \n %@", Entry.JournalEntryText);
    }
}
+ (NSString *) getJournalTitle:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal:forWhatKey];
    NSString *returnTitle = j.Title;
    return returnTitle;
}
+ (NSMutableArray *) getAllDreamCharacters:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal:forWhatKey];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if (j != nil)
    {
    // This function returns an NSMutableArray containing all the dream characters in each entry
        for (DreamJournalEntry *jEntries in j.journalEntries)
        {
            for (DreamCharacter *jChar in jEntries.dreamCharacters)
            {
                [ret addObject:jChar];
                NSLog(@"Character %@", jChar.Name);
            }
        }
    }
    
    // If the count is zero, return nil, otherwise return an array
    if (ret.count <= 0)
    {
        return nil;
        
    } else {
        return ret;
    }
        
}
+ (void) backUpJournalArchieveForJournal : (DreamJournal *) bckup
{
    // Back up the dreamJournal
    if (bckup != nil)
    {
        [self saveArchieveDreamJournal:bckup forWhatKey:backUpJournal];
        // Save the backup
        NSLog(@"Back-up journal saved");
    }
    else {
        // An error
        [UINotificationBanner showBannerWithMessage:@"Error backing up journal" forDuration:3];
    }
}
+ (void) resetJournalArchieve:(NSString *)forWhatKey
{
    // Deletes and resets the journal archieve
    DreamJournal *tempBackUp = [self getArchievedDreamJournal:forWhatKey];
    [self backUpJournalArchieveForJournal:tempBackUp]; // Back up
    
    [self deleteJournalArchieve:forWhatKey]; // Delete
    
    // Create a default journal
    NSDate *now = [NSDate date];
    JournalOwner *owner = [[JournalOwner alloc] initWithOwnerFirstAndLastName:@"Test First Name" withLastName:@"TestLastName" withDateOfBirth:now];
    DreamJournal *newJ = [[DreamJournal alloc] initWithTitleOwnerAndDefaultEntry:@"New Default Debug Joural" :owner];
    [self saveArchieveDreamJournal: newJ forWhatKey:forWhatKey];// Replace
}
@end
