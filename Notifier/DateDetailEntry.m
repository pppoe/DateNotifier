//
//  DateDetailEntry.m
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateDetailEntry.h"

@implementation DateDetailEntry

- (NSUInteger) entryID {
    return _entryID;
}

- (NSString *) title {
    return _title;
}

- (NSString *) desc {
    return _desc;
}

+ (DateDetailEntry *)entryWithID:(NSUInteger)entryID title:(NSString *)title andDescription:(NSString *)desc {
    return [[[DateDetailEntry alloc] initWithID:entryID
                                          title:title
                                 andDescription:desc] autorelease];
}

- (id)initWithID:(NSUInteger)entryID title:(NSString *)title andDescription:(NSString *)desc {
    if ((self = [super init]))
    {
        _entryID = entryID;
        _title = [title copy];
        _desc = [desc copy];
    }
    return self;
}

- (void)dealloc {
    [_title release];
    [_desc release];
    [super dealloc];
}

#pragma mark NotificationEntry
- (NSNumber *)notificationEntryID {
    return [NSNumber numberWithUnsignedInteger:[self entryID]];
}

@end
