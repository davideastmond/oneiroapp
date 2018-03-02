//
//  DreamCharacter.h
//  Oneiro
//
//  Created by David Eastmond on 2017-10-04.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    male, female, other
} DreamCharacterGender;

@interface DreamCharacter : NSObject <NSCoding>
{
}

@property NSString* Name;
@property (readonly) NSDate* CreateDate;
@property DreamCharacterGender gender;
// - Constructor
- (id) initWithNameAndGender: (NSString *) dcName
                            : (DreamCharacterGender) dcGender;
@end
