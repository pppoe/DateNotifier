//
//  DateDetailEntryStore.h
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DateDetailEntry;

@interface DateDetailEntryStore : NSObject {
    NSInteger _nextEntryID;
    NSMutableArray *_entries;
}

@property (nonatomic, readonly) NSArray *entries;

+ (DateDetailEntryStore *)sharedStore;

//- (void)setupFromPlistFileName:(NSString *)fileName;

- (NSString *)applicationDocumentDirectory;

- (void)archiveStore;

- (DateDetailEntry *)addEntryWithTitle:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date;
- (DateDetailEntry *)updateEntryWithID:(NSInteger)entryID title:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date;
- (void)removeEntry:(DateDetailEntry *)entry;

@end
