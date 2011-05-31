//
//  AddDateDetailEntryGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "AddDateDetailEntryGUI.h"

@implementation AddDateDetailEntryGUI
@synthesize delegate = _delegate;

- (id)init {
    if ((self = [super init]))
    {
        _editable = YES;
    }
    return self;
}

- (void)cancelDateEntry {
    [self.delegate cancelButtonTappedInEntryGUI:self];
}

- (void)doneDateEntry {
    if (_notification && _entryDate && ([_entryTitle length] > 0) && ([_entryDesc length] > 0))
    {
        [self.delegate doneButtonTappedWithNotification:_notification
                                             inEntryGUI:self];
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
