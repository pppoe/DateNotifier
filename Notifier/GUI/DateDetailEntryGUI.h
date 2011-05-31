//
//  DateDetailEntryGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateDetailEntryGUI : UIViewController {
    UITableView *_tableView;
    
    UILocalNotification *_notification;
    
    //< For Date Detail Entry
    NSMutableString *_entryTitle;
    NSMutableString *_entryDesc;
    NSDate *_entryDate;
    
    BOOL _editable;
}

@property (nonatomic, readonly) NSString *entryTitle;
@property (nonatomic, readonly) NSString *entryDesc;
@property (nonatomic, readonly) NSDate *entryDate;

- (void)postViewDidLoad;

@end
