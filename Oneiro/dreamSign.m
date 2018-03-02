//
//  dreamSign.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "dreamSign.h"

@implementation dreamSign
@synthesize Caption;

- (id) initWithSignCaption:(NSString *) XsignCaption
{
    if ([XsignCaption isEqualToString:@""])
    {
        Caption = @"default sign";
    } else {
        Caption = XsignCaption;
    }
    return self;
}
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.Caption forKey:@"signCaption"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    
    if (!self)
    {
        return nil;
    }
    self.Caption = [aDecoder decodeObjectForKey:@"signCaption"];
    return self;
}

@end
