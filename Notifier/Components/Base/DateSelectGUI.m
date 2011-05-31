    //
//  DateSelectGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateSelectGUI.h"

@implementation DateSelectGUI
@synthesize tag;
@synthesize delegate = _delegate;

- (id)initWithDate:(NSDate *)date andGUITitle:(NSString *)guiTitle {
    if ((self = [super init]))
    {
        const float leftPadding = 20.0f;
        const float rightPadding = 20.0f;
        const float topPadding = 40.0f;
        const float pageHeight = 416.0f;
        const float pageWidth = 320.0f;
        const float pickerHeight = 216.0f;
        const float labelHeight = 40.0f;
        CGRect dateLabelRect = CGRectMake(leftPadding, topPadding, 
                                          pageWidth - leftPadding - rightPadding, 
                                          labelHeight);
        CGRect timeLabelRect = CGRectMake(leftPadding, CGRectGetMaxY(dateLabelRect), 
                                          pageWidth - leftPadding - rightPadding, 
                                          labelHeight);
        CGRect pickerRect = CGRectMake(0, pageHeight - pickerHeight, pageWidth, pickerHeight);
        
        _dateButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [_dateButton setFrame:dateLabelRect];
        
        _timeButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [_timeButton setFrame:timeLabelRect];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:pickerRect];
        _datePicker.locale = [NSLocale currentLocale];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        [_datePicker setDate:date animated:YES];
        
        self.title = guiTitle;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        {
            [formatter setDateFormat:[self dateFormatString]];
            NSString *dispStr = [formatter stringFromDate:date];
            [_dateButton setTitle:dispStr forState:UIControlStateNormal];
        }
        {
            [formatter setDateFormat:[self timeFormatString]];
            NSString *dispStr = [formatter stringFromDate:date];
            [_timeButton setTitle:dispStr forState:UIControlStateNormal];
        }        
    }
    return self;
}

- (void)dealloc {
    [_dateButton release];
    [_timeButton release];
    [_datePicker release];
    [super dealloc];
}

- (void)postViewDidLoad {

    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    [doneItem release];
    
    [self.view addSubview:_dateButton];
    [self.view addSubview:_timeButton];
    [self.view addSubview:_datePicker];
    
    [_dateButton addTarget:self
                    action:@selector(dateButtonTapped)
          forControlEvents:UIControlEventTouchUpInside];
    [_timeButton addTarget:self
                    action:@selector(timeButtonTapped)
          forControlEvents:UIControlEventTouchUpInside];
    [_datePicker addTarget:self
                    action:@selector(datePickerSelectionChanged)
          forControlEvents:UIControlEventValueChanged];
}

- (void)postViewWillAppear {
}

- (NSDate *)minimumDate {
    return nil;
}

- (NSDate *)maximumDate {
    return nil;
}

- (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

- (NSString *)timeFormatString {
    return @"hh:mm:ss aa";
}

//< Actions
- (void)doneButtonTapped:(id)sender {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:[NSString stringWithFormat:@"%@ %@", [self dateFormatString], [self timeFormatString]]];
    NSString *dateString = [NSString stringWithFormat:@"%@ %@", 
                            [_dateButton titleForState:UIControlStateNormal],
                            [_timeButton titleForState:UIControlStateNormal],
                            nil];                            
    [self.delegate dateGUIFinishedWithDate:[formatter dateFromString:dateString]
                               inSelectGUI:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dateButtonTapped {
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate *minimumDate = [self minimumDate];
    if (minimumDate)
    {
        _datePicker.minimumDate = minimumDate;
    }

    NSDate *maximumDate = [self maximumDate];
    if (maximumDate)
    {
        _datePicker.maximumDate = maximumDate;
    }
        
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[self dateFormatString]];
    [_datePicker setDate:[formatter dateFromString:[_dateButton titleForState:UIControlStateNormal]] 
                animated:YES];
    [formatter release];
}

- (void)timeButtonTapped {
    _datePicker.datePickerMode = UIDatePickerModeTime;

    NSDate *minimumDate = [self minimumDate];
    if (minimumDate)
    {
        _datePicker.minimumDate = minimumDate;
    }
    
    NSDate *maximumDate = [self maximumDate];
    if (maximumDate)
    {
        _datePicker.maximumDate = maximumDate;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[self timeFormatString]];
    [_datePicker setDate:[formatter dateFromString:[_timeButton titleForState:UIControlStateNormal]]
                animated:YES];
    [formatter release];
}

- (void)datePickerSelectionChanged {
    UIButton *targetButton = nil;
    NSString *formatString= nil;
    if (_datePicker.datePickerMode == UIDatePickerModeDate)
    {
        targetButton = _dateButton;
        formatString = [self dateFormatString];
    }
    else if (_datePicker.datePickerMode == UIDatePickerModeTime)
    {
        targetButton = _timeButton;
        formatString = [self timeFormatString];        
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString *dispStr = [formatter stringFromDate:_datePicker.date];
    [targetButton setTitle:dispStr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postViewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self postViewWillAppear];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end
