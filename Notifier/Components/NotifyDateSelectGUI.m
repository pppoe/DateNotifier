//
//  NotifyDateSelectGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "NotifyDateSelectGUI.h"


@implementation NotifyDateSelectGUI
@synthesize entryDate = _entryDate;

- (NSDate *)maximumDate {
    return self.entryDate;
}

- (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

- (NSString *)timeFormatString {
    return @"hh:mm aa";
}

- (void)dealloc {
    [_entryDate release];
    [super dealloc];
}

@end
