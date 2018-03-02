//
//  DreamCharacter.m
//  Oneiro
//
//  Created by David Eastmond on 2017-10-04.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import "DreamCharacter.h"

//
@implementation DreamCharacter

@synthesize Name = _Name;
@synthesize CreateDate = _CreateDate;
@synthesize gender = _gender;

- (id) initWithNameAndGender:(NSString *)dcName :(DreamCharacterGender)dcGender
{
    // Assign the name and gender
    _Name = dcName;
    _gender = dcGender;
    _CreateDate = [NSDate date];
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.Name = [aDecoder decodeObjectForKey:@"name"];
    _CreateDate = [aDecoder decodeObjectForKey:@"createDate"];
    self.gender = [aDecoder decodeIntForKey:@"gender"];
    
    return self;
}
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Name forKey:@"name"];
    [aCoder encodeObject:self.CreateDate forKey:@"createDate"];
    [aCoder encodeInt:self.gender forKey:@"gender"];
}
@end
