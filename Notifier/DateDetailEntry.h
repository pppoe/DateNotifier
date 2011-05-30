//
//  DateDetailEntry.h
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NotificationEntry.h"

@interface DateDetailEntry : NSObject <NotificationEntry> {
    NSUInteger _entryID;
    NSString *_title;
    NSString *_desc;
}

- (NSUInteger) entryID;
- (NSString *) title;
- (NSString *) desc;

- (id)initWithID:(NSUInteger)entryID title:(NSString *)title andDescription:(NSString *)desc;
+ (DateDetailEntry *)entryWithID:(NSUInteger)entryID title:(NSString *)title andDescription:(NSString *)desc;

@end
