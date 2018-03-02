//
//  dreamSign.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dreamSign : NSObject <NSCoding>

@property NSString *Caption;

- (id) initWithSignCaption : (NSString *) DreamSignCaption;
@end
