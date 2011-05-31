//
//  NotifyDateSelectGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateSelectGUI.h"

@interface NotifyDateSelectGUI : DateSelectGUI {
    NSDate *_entryDate;
}

@property (nonatomic, retain) NSDate *entryDate;

@end
