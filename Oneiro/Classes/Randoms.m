//
//  Randoms.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-05.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "Randoms.h"

@implementation Randoms

// Generate a random value
+ (int) randomIntegerBetween:(int)min and:(int)max
{
    return (int) (min + arc4random_uniform(max - min + 1));
}
+ (NSString *) randomStringOfLength:(NSUInteger)len
{
    if (len <= 0)
    {
        // Cannot be less than or equal to 0
        NSException *InvalidArgumentException = [NSException exceptionWithName:@"InvalidArgumentException" reason:@"Length must be greater than 0" userInfo:nil];
        @throw InvalidArgumentException;
    }
    
    NSMutableString *ReturnString = [[NSMutableString alloc] initWithString:@""];
    
    for (int i = 1; i <= len; i++)
    {
        // Characters (including numerals)
        int alphaValue = [self randomIntegerBetween:65 and:90];
        int numValue = [self randomIntegerBetween:48 and:57];
        NSInteger numOrLetter = [self randomIntegerBetween:0 and:2];
        
        NSString *charChoice;
        if(numOrLetter == 0)
        {
            // Make a letter
            charChoice = [NSString stringWithFormat:@"%c", alphaValue];
        } else {
            charChoice = [NSString stringWithFormat:@"%c", numValue];
        }
        [ReturnString appendString:charChoice];
    }
    return ReturnString;
}
@end
