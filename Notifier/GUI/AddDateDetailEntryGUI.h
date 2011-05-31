//
//  AddDateDetailEntryGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateDetailEntryGUI.h"

@class AddDateDetailEntryGUI;

@protocol AddDateDetailEntryGUIDelegate

- (void)cancelButtonTappedInEntryGUI:(AddDateDetailEntryGUI *)entryGUI;
- (void)doneButtonTappedWithNotification:(UILocalNotification *)notification 
                              inEntryGUI:(AddDateDetailEntryGUI *)entryGUI;

@end


@interface AddDateDetailEntryGUI : DateDetailEntryGUI {
    id<AddDateDetailEntryGUIDelegate> _delegate;
}

@property (nonatomic, assign) id<AddDateDetailEntryGUIDelegate> delegate;

- (void)doneDateEntry;

@end
