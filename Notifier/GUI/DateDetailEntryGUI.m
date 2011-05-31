//
//  DateDetailEntryGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateDetailEntryGUI.h"
#import "DateDetailEntry.h"
#import "TextFieldGUI.h"
#import "TextViewGUI.h"
#import "NotifyDateSelectGUI.h"
#import "EntryDateSelectGUI.h"

#import <QuartzCore/QuartzCore.h>

#define kLeftPaddding 20.0f
#define kRightPadding 20.0f
#define kTopPadding 0
#define kBottomPadding 0

#define kCellHeight 40.0f

#define TagBaseSubView 0x1234

enum {
    EnumCellTitleLabel,
    EnumCellTitleContent,
    EnumCellDescLabel,
    EnumCellDescContent,
    EnumCellDateLabel,
    EnumCellDateContent,
    EnumCellNotificationDateLabel,
    EnumCellNotificationDateContent,
    EnumCellNotificationAlertLabel,
    EnumCellNotificationAlertLabelContent,
    EnumCellCount
};

@interface DateDetailEntryGUI (Private) <UITableViewDelegate, UITableViewDataSource, TextInputGUIDelegate, DateSelectGUIDelegate>

@end


@implementation DateDetailEntryGUI
@synthesize entryTitle = _entryTitle;
@synthesize entryDesc = _entryDesc;
@synthesize entryDate = _entryDate;

- (id)init {
    if ((self = [super init]))
    {
        _entryTitle = [[NSMutableString alloc] initWithCapacity:0];
        _entryDesc = [[NSMutableString alloc] initWithCapacity:0];
        _entryDate = nil;
        _notification = [[UILocalNotification alloc] init];
        _editable = NO;
    }
    return self;
}

- (void)dealloc {
    [_entryTitle release];
    [_entryDesc release];
    [_entryDate release];
    [_notification release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float pageWidth = self.view.frame.size.width;
    float pageHeight = self.view.frame.size.height - [self.navigationController navigationBar].frame.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftPaddding, kTopPadding, 
                                                               pageWidth - kLeftPaddding - kRightPadding, 
                                                               pageHeight - kTopPadding - kBottomPadding)
                                              style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.shadowOpacity = 0.8f;
    _tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    _tableView.layer.shadowOffset = CGSizeMake(2, 2);
    _tableView.layer.shadowRadius = 1.0f;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self postViewDidLoad];
}    

- (void)postViewDidLoad {
}

@end

@implementation DateDetailEntryGUI (Private)

#pragma mark DateSelectGUIDelegate
- (void)dateGUIFinishedWithDate:(NSDate *)date inSelectGUI:(DateSelectGUI *)selectGUI {
    switch ((selectGUI.tag - TagBaseSubView)) {
        case EnumCellDateLabel:
            if (_entryDate)
            {
                [_entryDate release];
            }
            _entryDate = [date copy];
            break;
        case EnumCellNotificationDateLabel:
            _notification.fireDate = date;
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

#pragma mark TextInputGUIDelegate
- (void)textGUIFinishedWithText:(NSString *)text inInputGUI:(TextInputGUI *)textInputGUI {
    switch ((textInputGUI.tag - TagBaseSubView)) {
        case EnumCellTitleLabel:
            [_entryTitle setString:text];
            break;
        case EnumCellDescLabel:
            [_entryDesc setString:text];
            break;
        case EnumCellNotificationAlertLabel:
            _notification.alertBody = text;
        default:
            break;
    }
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section * 2) {
        case EnumCellTitleLabel:
        {
            TextFieldGUI *textInputGUI = [[TextFieldGUI alloc] initWithText:_entryTitle
                                                                andGUITitle:NSLocalizedString(@"Title", @"")];
            textInputGUI.delegate = self;
            textInputGUI.tag = (EnumCellTitleLabel + TagBaseSubView);
            [self.navigationController pushViewController:textInputGUI animated:YES];
            [textInputGUI release];
        }
            break;
        case EnumCellDescLabel:
        {
            TextViewGUI *textInputGUI = [[TextViewGUI alloc] initWithText:_entryDesc
                                                              andGUITitle:NSLocalizedString(@"Description", @"")];
            textInputGUI.delegate = self;
            textInputGUI.tag = (EnumCellDescLabel + TagBaseSubView);
            [self.navigationController pushViewController:textInputGUI animated:YES];
            [textInputGUI release];
        }
            break;
        case EnumCellDateLabel:
        {
            EntryDateSelectGUI *dateSelectGUI = [[EntryDateSelectGUI alloc] initWithDate:(_entryDate ? _entryDate : [NSDate date])
                                                                   andGUITitle:NSLocalizedString(@"Active Date", @"")];
            dateSelectGUI.delegate = self;
            dateSelectGUI.tag = (EnumCellDateLabel + TagBaseSubView);
            [self.navigationController pushViewController:dateSelectGUI animated:YES];
            [dateSelectGUI release];
        }
            break;
        case EnumCellNotificationAlertLabel:
        {
            TextViewGUI *textInputGUI = [[TextViewGUI alloc] initWithText:(_notification.alertBody ? _notification.alertBody : @"")
                                                              andGUITitle:NSLocalizedString(@"Alert Body", @"")];
            textInputGUI.delegate = self;
            textInputGUI.tag = (EnumCellNotificationAlertLabel + TagBaseSubView);
            [self.navigationController pushViewController:textInputGUI animated:YES];
            [textInputGUI release];            
        }
            break;
        case EnumCellNotificationDateLabel:
        {
            NotifyDateSelectGUI *dateSelectGUI = [[NotifyDateSelectGUI alloc] initWithDate:(_notification.fireDate ? _notification.fireDate : [NSDate date])
                                                                         andGUITitle:NSLocalizedString(@"Notification Date", @"")];
            dateSelectGUI.entryDate = (_entryDate ? _entryDate : [NSDate date]);
            dateSelectGUI.delegate = self;
            dateSelectGUI.tag = (EnumCellNotificationDateLabel + TagBaseSubView);
            [self.navigationController pushViewController:dateSelectGUI animated:YES];
            [dateSelectGUI release];
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_editable)
    {
        if (indexPath.row == 1)
        {
            [self tableView:tableView accessoryButtonTappedForRowWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        }
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    
    NSString *labelStr = nil;
    
    if (indexPath.row == 0)
    {
        switch (indexPath.section * 2) {
            case EnumCellTitleLabel:
                labelStr = NSLocalizedString(@"title", @"");
                break;
            case EnumCellDescLabel:
                labelStr = NSLocalizedString(@"description", @"");
                break;
            case EnumCellDateLabel:
                labelStr = NSLocalizedString(@"date", @"");
                break;
            case EnumCellNotificationDateLabel:
                labelStr = NSLocalizedString(@"notification date", @"");
                break;
            case EnumCellNotificationAlertLabel:
                labelStr = NSLocalizedString(@"alert", @"");
                break;
            default:
                break;
        }
    }
    else if (indexPath.row == 1)
    {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
        switch (indexPath.section * 2) {
            case EnumCellTitleLabel:
                labelStr = (([_entryTitle length] == 0) ? @"" : _entryTitle);
                break;
            case EnumCellDescLabel:
                labelStr = (([_entryDesc length] == 0) ? @"" : _entryDesc);
                break;
            case EnumCellDateLabel:
                labelStr = (_entryDate ? [dateFormatter stringFromDate:_entryDate] : @"");
                break;
            case EnumCellNotificationDateLabel:
                labelStr = (_notification.fireDate ? [dateFormatter stringFromDate:_notification.fireDate] : @"");
                break;
            case EnumCellNotificationAlertLabel:
                labelStr = (_notification.alertBody ? _notification.alertBody : @"");
                break;
            default:
                break;
        }
    }
    
    cell.textLabel.text = [labelStr capitalizedString];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    if (_editable)
    {
        cell.selectionStyle = ((indexPath.row == 0) ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleBlue);
        cell.accessoryType = ((indexPath.row == 0) ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryNone);
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return EnumCellCount/2;    
}

@end
