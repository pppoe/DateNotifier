//
//  EntryDateSelectGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "EntryDateSelectGUI.h"

@implementation EntryDateSelectGUI

- (NSDate *)minimumDate {
    return [NSDate date];
}

- (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

- (NSString *)timeFormatString {
    return @"hh:mm aa";
}

@end
