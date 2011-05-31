//
//  UpdateDateDetailEntryGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "UpdateDateDetailEntryGUI.h"
#import "DateDetailEntry.h"

@implementation UpdateDateDetailEntryGUI
@synthesize delegate = _delegate;

- (id)initWithEntry:(DateDetailEntry *)dateEntry andNotification:(UILocalNotification *)notification {
    if ((self = [super init]))
    {
        _editable = YES;

        [_entryTitle setString:[dateEntry title]];
        [_entryDesc setString:[dateEntry desc]];
        _entryDate = [[dateEntry date] copy];
        if (_notification)
        {
            [_notification release];
        }
        _notification = [notification retain];
        
        _dateEntry = [dateEntry retain];
        
        self.title = NSLocalizedString(@"Update Entry", @"");
    }
    return self;
}

- (void)dealloc {
    [_dateEntry release];
    [super dealloc];
}

- (void)cancelDateEntry {
    [self.delegate cancelButtonTappedInEntryGUI:self];
}

- (void)doneDateEntry {
    if (_notification && _entryDate && ([_entryTitle length] > 0) && ([_entryDesc length] > 0))
    {
        [self.delegate doneButtonTappedWithNotification:_notification
                                              dateEntry:_dateEntry
                                       inUpdateEntryGUI:self];
    }
}

- (void)postViewDidLoad {    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancelDateEntry)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    [cancelItem release];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(doneDateEntry)];
    self.navigationItem.rightBarButtonItem = doneItem;
    [doneItem release];
    
    self.title = NSLocalizedString(@"New Entry", @"");
}
@end
