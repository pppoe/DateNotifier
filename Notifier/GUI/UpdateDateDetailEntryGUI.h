//
//  UpdateDateDetailEntryGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateDetailEntryGUI.h"

@class DateDetailEntry;
@class UpdateDateDetailEntryGUI;

@protocol UpdateDateDetailEntryGUIGUIDelegate

- (void)cancelButtonTappedInEntryGUI:(DateDetailEntryGUI *)entryGUI;
- (void)doneButtonTappedWithNotification:(UILocalNotification *)notification 
                               dateEntry:(DateDetailEntry *)dateEntry
                        inUpdateEntryGUI:(UpdateDateDetailEntryGUI *)entryGUI;

@end

@interface UpdateDateDetailEntryGUI : DateDetailEntryGUI {
    id<UpdateDateDetailEntryGUIGUIDelegate> _delegate;
    DateDetailEntry *_dateEntry;
}

- (id)initWithEntry:(DateDetailEntry *)dateEntry andNotification:(UILocalNotification *)notification;

@property (nonatomic, assign) id<UpdateDateDetailEntryGUIGUIDelegate> delegate;

@end
