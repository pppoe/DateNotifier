//
//  DateDetailEntry.m
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateDetailEntry.h"

#define kCoderKeyEntryID @"kCoderKeyEntryID"
#define kCoderKeyTitle @"kCoderKeyTitle"
#define kCoderKeyDesc @"kCoderKeyDesc"
#define kCoderKeyDate @"kCoderKeyDate"


@implementation DateDetailEntry

- (NSInteger) entryID {
    return _entryID;
}

- (NSString *) title {
    return _title;
}

- (NSString *) desc {
    return _desc;
}

- (NSDate *) date {
    return _date;
}

+ (DateDetailEntry *)entryWithID:(NSInteger)entryID title:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date {
    return [[[DateDetailEntry alloc] initWithID:entryID
                                          title:title
                                    description:desc 
                                        andDate:date] autorelease];
}

- (id)initWithID:(NSInteger)entryID title:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date {
    if ((self = [super init]))
    {
        _entryID = entryID;
        _title = [title copy];
        _desc = [desc copy];
        _date = [date copy];
    }
    return self;
}

- (void)dealloc {
    [_date release];
    [_title release];
    [_desc release];
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSNumber numberWithInteger:_entryID] forKey:kCoderKeyEntryID];
    [aCoder encodeObject:_title forKey:kCoderKeyTitle];
    [aCoder encodeObject:_desc forKey:kCoderKeyDesc];
    [aCoder encodeObject:_date forKey:kCoderKeyDate];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        NSNumber *entryIDNumber = [aDecoder decodeObjectForKey:kCoderKeyEntryID];

        _entryID = [entryIDNumber integerValue];
        
        _title = [[aDecoder decodeObjectForKey:kCoderKeyTitle] retain];
        _desc = [[aDecoder decodeObjectForKey:kCoderKeyDesc] retain];
        _date = [[aDecoder decodeObjectForKey:kCoderKeyDate] retain];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Entry<%d> [\nTitle: %@\nDesc: %@\nDate: %@\n]",
            _entryID, _title, _desc, _date];
}

#pragma mark NotificationEntry
- (NSNumber *)notificationEntryID {
    return [NSNumber numberWithUnsignedInteger:[self entryID]];
}

- (BOOL)expired {
    return ([[NSDate date] compare:[self date]]  == NSOrderedDescending);
}

@end
