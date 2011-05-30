//
//  NotificationCenter.h
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotificationCenterUserInfoKey @"kNotificationCenterUserInfoKey"

@protocol NotificationEntry;

@interface NotificationCenter : NSObject {
    NSMutableDictionary *_notificationDict;
}

- (void)addNotification:(UILocalNotification *)notification withEntry:(id<NotificationEntry>)entry;
- (void)updateNotification:(UILocalNotification *)notification withEntry:(id<NotificationEntry>)entry;
- (void)removeNotificationWithEntry:(id<NotificationEntry>)entry;

+ (NotificationCenter *)sharedCenter;

- (void)archiveCenter;

@end
