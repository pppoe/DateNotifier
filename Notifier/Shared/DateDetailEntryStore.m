//
//  DateDetailEntryStore.m
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateDetailEntryStore.h"
#import "DateDetailEntry.h"

#define kDateDetailEntryStorePlist @"DateDetailEntryStore"

static DateDetailEntryStore *sharedStore = nil;

@implementation DateDetailEntryStore
@synthesize entries = _entries;

+ (DateDetailEntryStore *)sharedStore {
    if (!sharedStore)
    {
        sharedStore = [[DateDetailEntryStore alloc] init];
    }
    return sharedStore;
}

- (NSString *)filePathOfArchive {
    NSString *directory = [self applicationDocumentDirectory];
    NSString *filePath = [[directory stringByAppendingPathComponent:kDateDetailEntryStorePlist] stringByAppendingPathExtension:@"plist"];
    return filePath;
}

- (id)init {
    if ((self = [super init]))
    {
        _entries = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathOfArchive]];
        if (array)
        {
            [_entries setArray:array];
        }
        
        
        _nextEntryID = 0;
        for (int i = 0; i < [self.entries count]; i++)
        {
            DateDetailEntry *entry = [self.entries objectAtIndex:i];
            if (_nextEntryID < [entry entryID])
            {
                _nextEntryID = [entry entryID];
            }
        }
        _nextEntryID++;            
        
    }
    return self;
}

- (void)dealloc {
    [_entries release];
    [super dealloc];
}

- (void)archiveStore {
    @synchronized(self)
    {
        if ([_entries count] > 0)
        {
            if (![NSKeyedArchiver archiveRootObject:_entries toFile:[self filePathOfArchive]])
            {
                NSLog(@"NSKeyedArchiver Error DateDetailEntryStore");
            }
        }
    }
}

- (NSString *)applicationDocumentDirectory {
    return [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                           inDomain:NSUserDomainMask 
                                  appropriateForURL:nil
                                             create:NO
                                              error:nil] path];
}

- (DateDetailEntry *)addEntryWithTitle:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date {
    @synchronized(self)
    {
        DateDetailEntry *newEntry = [DateDetailEntry entryWithID:_nextEntryID 
                                                           title:title 
                                                     description:desc 
                                                         andDate:date];        
        [_entries addObject:newEntry];
        _nextEntryID++;
        return newEntry;
    }
}

- (DateDetailEntry *)updateEntryWithID:(NSInteger)entryID title:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date {
    @synchronized(self)
    {
        DateDetailEntry *newEntry = [DateDetailEntry entryWithID:entryID 
                                                           title:title
                                                     description:desc 
                                                         andDate:date];
        for (DateDetailEntry *entry in [self entries])
        {
            if ([entry entryID] == entryID)
            {
                [self removeEntry:entry];
                break;
            }
        }
        
        [_entries addObject:newEntry];
        
        return newEntry;
    }
}

- (void)removeEntry:(DateDetailEntry *)entry {
    @synchronized(self)
    {
        if ([_entries containsObject:entry])
        {
            [_entries removeObject:entry];
        }
    }
}

@end
