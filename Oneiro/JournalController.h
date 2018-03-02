//
//  JournalController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamJournal.h"

@interface JournalController : NSObject
{
}

// Class methods
+ (DreamJournal *) getArchievedDreamJournal : (NSString *) forWhatKey;

+ (void) saveArchieveDreamJournal : (DreamJournal *) journalToSave
                       forWhatKey : (NSString *) key;

+ (void) deleteJournalArchieve : (NSString *) forWhatKey;
+ (bool) isSavedJournalPresent : (NSString *) forWhatKey;
+ (void) addJournalEntryToJournal : (DreamJournalEntry *) entry forWhatKey : (NSString *) key;
+ (NSInteger) getJournalEntryCount : (NSString *) forWhatKey;
+ (void) debugPrintJournalEntries : (NSString *) forWhatKey;

+ (NSString *) getJournalTitle : (NSString *) forWhatKey;
@end