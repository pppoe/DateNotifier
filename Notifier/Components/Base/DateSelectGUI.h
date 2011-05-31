//
//  DateSelectGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateSelectGUI;

@protocol DateSelectGUIDelegate

- (void)dateGUIFinishedWithDate:(NSDate *)date inSelectGUI:(DateSelectGUI *)selectGUI;

@end

@interface DateSelectGUI : UIViewController {
    
    int tag;
    id<DateSelectGUIDelegate> _delegate;
    
    UIButton *_dateButton;
    UIButton *_timeButton;
    UIDatePicker *_datePicker;
}

@property (nonatomic, assign) int tag;
@property (nonatomic, assign) id<DateSelectGUIDelegate> delegate;

- (id)initWithDate:(NSDate *)date andGUITitle:(NSString *)guiTitle;

- (void)postViewDidLoad;
- (void)postViewWillAppear;

- (void)doneButtonTapped:(id)sender;

- (NSDate *)minimumDate;
- (NSDate *)minimumDate;

- (NSString *)dateFormatString;
- (NSString *)timeFormatString;

@end
