//
//  NotificationCenter.m
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "NotificationCenter.h"
#import "NotificationEntry.h"

#import "DateDetailEntryStore.h"

#define kNotificationCenterPlist @"NotificationCenter"

static NotificationCenter *sharedCenter = nil;

@implementation NotificationCenter

+ (NotificationCenter *)sharedCenter {
    if (!sharedCenter)
    {
        sharedCenter = [[NotificationCenter alloc] init];
    }
    return sharedCenter;
}

- (void)addNotification:(UILocalNotification *)notification withEntry:(id<NotificationEntry>)entry {
    @synchronized(self)
    {
        if (![_notificationDict objectForKey:[entry notificationEntryID]])
        {
            [_notificationDict setObject:notification 
                                  forKey:[entry notificationEntryID]];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}

- (void)updateNotification:(UILocalNotification *)notification withEntry:(id<NotificationEntry>)entry {
    @synchronized(self)
    {
        UILocalNotification *prevNotification = [_notificationDict objectForKey:[entry notificationEntryID]];
        if (prevNotification)
        {
            [[UIApplication sharedApplication] cancelLocalNotification:prevNotification];
            [_notificationDict setObject:notification 
                                  forKey:[entry notificationEntryID]];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}

- (void)removeNotificationWithEntry:(id<NotificationEntry>)entry {
    @synchronized(self)
    {
        UILocalNotification *notification = [_notificationDict objectForKey:[entry notificationEntryID]];
        if (notification)
        {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            [_notificationDict removeObjectForKey:[entry notificationEntryID]];
        }
    }
}

- (NSString *)filePathOfArchive {
    NSString *directory = [[DateDetailEntryStore sharedStore] applicationDocumentDirectory];
    NSString *filePath = [[directory stringByAppendingPathComponent:kNotificationCenterPlist] stringByAppendingPathExtension:@"plist"];
    return filePath;    
}

- (id)init {
    if ((self = [super init]))
    {
        
        _notificationDict = [[NSMutableDictionary alloc] initWithCapacity:0];        
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathOfArchive]];
        if (dict)
        {
            [_notificationDict setDictionary:dict];
        }
        
    }
    return self;
}

- (void)dealloc {
    [_notificationDict release];
    [super dealloc];
}

- (void)archiveCenter {
    @synchronized(self)
    {
        if ([_notificationDict count] > 0)
        {
            if (![NSKeyedArchiver archiveRootObject:_notificationDict toFile:[self filePathOfArchive]])
            {
                NSLog(@"NSKeyedArchiver Error NotificationCenter");
            }
        }
    }
}

- (UILocalNotification *)notificationForEntry:(id<NotificationEntry>)entry {
    return [_notificationDict objectForKey:[entry notificationEntryID]];
}

- (BOOL)entryNotified:(id<NotificationEntry>)entry {
    UILocalNotification *notification = [_notificationDict objectForKey:[entry notificationEntryID]];
    if (notification)
    {
        return ([notification.fireDate compare:[NSDate date]] == NSOrderedAscending);
    }
    return YES;
}

@end
