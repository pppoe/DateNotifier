//
//  NotificationListGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "NotificationListGUI.h"
#import "NotificationCenter.h"
#import "DateDetailEntryStore.h"
#import "DateDetailEntry.h"
#import "AddDateDetailEntryGUI.h"
#import "UpdateDateDetailEntryGUI.h"

@interface NotificationListGUI (Private) <AddDateDetailEntryGUIDelegate, UpdateDateDetailEntryGUIGUIDelegate>

@end

@implementation NotificationListGUI

- (void)commitChanges {
    [[NotificationCenter sharedCenter] archiveCenter];
    [[DateDetailEntryStore sharedStore] archiveStore];
    
    [self.tableView reloadData];    
}

//< Actions
- (void)addDateEntry {
    
    AddDateDetailEntryGUI *entryGUI = [[AddDateDetailEntryGUI alloc] init];
    entryGUI.delegate = self;
    UINavigationController *modalNavController = [[UINavigationController alloc] initWithRootViewController:entryGUI];
    [modalNavController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [entryGUI release];
    
    [self presentModalViewController:modalNavController animated:YES];
}

- (void)editDateEntries {
    
    [self.tableView setEditing:YES animated:YES];

    UIBarButtonItem *editDoneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(editDateEntriesDone)];
    self.navigationItem.rightBarButtonItem = editDoneItem;
    [editDoneItem release];    
}

- (void)editDateEntriesDone {

    [self.tableView setEditing:NO animated:YES];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                              target:self
                                                                              action:@selector(editDateEntries)];
    self.navigationItem.rightBarButtonItem = editItem;
    [editItem release];    
}

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization.
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addDateEntry)];
    self.navigationItem.leftBarButtonItem = addItem;
    [addItem release];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                              target:self
                                                                              action:@selector(editDateEntries)];
    self.navigationItem.rightBarButtonItem = editItem;
    [editItem release];
    
    self.title = NSLocalizedString(@"Notifications", @"");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DateDetailEntry *entry = [[[DateDetailEntryStore sharedStore] entries] objectAtIndex:indexPath.row];
        [[NotificationCenter sharedCenter] removeNotificationWithEntry:entry];
        [[DateDetailEntryStore sharedStore] removeEntry:entry];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self commitChanges];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[DateDetailEntryStore sharedStore] entries] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    DateDetailEntry *entry = [[[DateDetailEntryStore sharedStore] entries] objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    if ([[NotificationCenter sharedCenter] entryNotified:entry])
    {
        cell.textLabel.textColor = [UIColor greenColor];
    }
    
    if ([entry expired])
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%3d:%@", [entry entryID], [entry title]];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    DateDetailEntry *entry = [[[DateDetailEntryStore sharedStore] entries] objectAtIndex:indexPath.row];
    UILocalNotification *notification = [[NotificationCenter sharedCenter] notificationForEntry:entry];
    UpdateDateDetailEntryGUI *entryGUI = [[UpdateDateDetailEntryGUI alloc] initWithEntry:entry
                                                                         andNotification:notification];
    entryGUI.delegate = self;
    UINavigationController *modalNavController = [[UINavigationController alloc] initWithRootViewController:entryGUI];
    [modalNavController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [entryGUI release];
    
    [self presentModalViewController:modalNavController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end

@implementation NotificationListGUI (Private)

- (void)cancelButtonTappedInEntryGUI:(AddDateDetailEntryGUI *)entryGUI {
    [entryGUI dismissModalViewControllerAnimated:YES];
}

- (void)doneButtonTappedWithNotification:(UILocalNotification *)notification 
                              inEntryGUI:(AddDateDetailEntryGUI *)entryGUI {
    DateDetailEntry *entry = [[DateDetailEntryStore sharedStore] addEntryWithTitle:entryGUI.entryTitle 
                                                                       description:entryGUI.entryDesc
                                                                           andDate:entryGUI.entryDate];
    notification.applicationIconBadgeNumber = [entry entryID];
    [[NotificationCenter sharedCenter] addNotification:notification 
                                             withEntry:entry];
    [entryGUI dismissModalViewControllerAnimated:YES];
    [self commitChanges];
}

- (void)doneButtonTappedWithNotification:(UILocalNotification *)notification 
                               dateEntry:(DateDetailEntry *)dateEntry
                        inUpdateEntryGUI:(UpdateDateDetailEntryGUI *)entryGUI {
    DateDetailEntry *newEntry = [[DateDetailEntryStore sharedStore] updateEntryWithID:[dateEntry entryID]
                                                                                title:[entryGUI entryTitle]
                                                                          description:[entryGUI entryDesc]
                                                                              andDate:[entryGUI entryDate]];
    [[NotificationCenter sharedCenter] updateNotification:notification withEntry:newEntry];
    [entryGUI dismissModalViewControllerAnimated:YES];
    [self commitChanges];;
}

@end


