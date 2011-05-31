//
//  DateDetailEntry.h
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NotificationEntry.h"

@interface DateDetailEntry : NSObject <NotificationEntry, NSCoding> {
    NSInteger _entryID;
    NSString *_title;
    NSString *_desc;
    NSDate *_date;
}

- (NSInteger) entryID;
- (NSString *) title;
- (NSString *) desc;
- (NSDate *) date;

- (id)initWithID:(NSInteger)entryID title:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date;
+ (DateDetailEntry *)entryWithID:(NSInteger)entryID title:(NSString *)title description:(NSString *)desc andDate:(NSDate *)date;

- (BOOL)expired;

@end
