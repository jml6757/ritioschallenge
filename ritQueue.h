//
//  ritQueue.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)

- (id) head;
- (void) pop;
- (void) push:(id)obj;

@end
