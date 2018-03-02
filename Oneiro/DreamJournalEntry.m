//
//  DreamJournalEntry.m
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import "DreamJournalEntry.h"

@implementation DreamJournalEntry

@synthesize JournalEntryText;
@synthesize dreamCharacters = _dreamCharacters;
@synthesize Title = _Title;
@synthesize CreateDate = _CreateDate;
@synthesize dreamSigns = _dreamSigns;

- (id) initWithJournalEntryTitle:(NSString *)entryTitle
{
    // Property assign the entry date
    _CreateDate = [NSDate date];
    _Title = entryTitle;
    _dreamCharacters = [[NSMutableArray alloc] init];
    _dreamSigns = [[NSMutableArray alloc] init]; // Initialize
    
    // create a default dreamsign
    dreamSign *defaultSign = [[dreamSign alloc] initWithSignCaption:@"default"];
    [self AddDreamSign:defaultSign]; // Add the dream sign to the mutable array
    
    // Create a default dream character
    DreamCharacter *defaultChar = [[DreamCharacter alloc] initWithNameAndGender:@"default dream character" :male];
    [self AddDreamCharacter:defaultChar];
    return self;
}

- (void) AddDreamCharacter:(DreamCharacter *)charToAdd
{
    // Adds a dream character
    [_dreamCharacters addObject:charToAdd];
    NSLog(@"Added object %@", charToAdd.Name);
}

- (void) AddDreamSign: (dreamSign *) dreamSignToAdd
{
    [_dreamSigns addObject:dreamSignToAdd];
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.JournalEntryText = [aDecoder decodeObjectForKey:@"entryText"];
    _dreamCharacters = [aDecoder decodeObjectForKey:@"dcs"];
    self.Title = [aDecoder decodeObjectForKey:@"title"];
    _CreateDate = [aDecoder decodeObjectForKey: @"createDate"];
    _dreamSigns = [aDecoder decodeObjectForKey:@"dreamsigns"];
    return self;
}
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.JournalEntryText forKey:@"entryText"];
    [aCoder encodeObject:self.dreamCharacters forKey:@"dcs"];
    [aCoder encodeObject:self.Title forKey:@"title"];
    [aCoder encodeObject:self.CreateDate forKey:@"createDate"];
    [aCoder encodeObject:self.dreamSigns forKey:@"dreamsigns"];
}
@end

@implementation JournalEditBundle

@synthesize JournalEntryReference = _reference;
@synthesize EntryIndex;
- (id) initWithBundle:(DreamJournalEntry *)Entry forIndex:(NSInteger)index
{
    _reference = Entry;
    EntryIndex = index;
    return self;
}
@end
