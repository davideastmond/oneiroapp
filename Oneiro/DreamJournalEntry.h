//
//  DreamJournalEntry.h
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamCharacter.h"
#import "dreamSign.h"

// Journal Entries
@interface DreamJournalEntry : NSObject <NSCoding>
{
}
@property (readonly) NSDate *CreateDate;
@property NSString *Title;

@property (readonly) NSMutableArray *dreamCharacters; // This holds an array of dreamCharacters
@property (readonly) NSMutableArray *dreamSigns; // Holds list of dream signs
@property NSString *JournalEntryText;

// Constructor
- (id) initWithJournalEntryTitle : (NSString *) entryTitle;

// We need a method that adds dream characters to the array
- (void) AddDreamCharacter : (DreamCharacter *) charToAdd;
- (void) AddDreamSign : (dreamSign *) dreamSignToAdd;
@end

// Journal Edit update bundle
@interface JournalEditBundle : NSObject
{
    
}
- (id) initWithBundle : (DreamJournalEntry *) Entry forIndex: (NSInteger) index;
@property NSInteger EntryIndex;
@property (weak, nonatomic) DreamJournalEntry *JournalEntryReference;
@end
