    //
//  TextViewGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "TextViewGUI.h"


@implementation TextViewGUI

- (id)initWithText:(NSString *)text andGUITitle:(NSString *)guiTitle{
    if ((self = [super init]))
    {
        float pageWidth = 320.0f;
        
        const float kLeftPaddding = 20.0f;
        const float kRightPadding = 20.0f;
        const float kTopPadding = 40.0f;
        
        const float kTextFieldHeight = 150.0f;
        
        const float kFontSize = 15.0f;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(kLeftPaddding, kTopPadding, 
                                                                   pageWidth - kLeftPaddding - kRightPadding, 
                                                                   kTextFieldHeight)];
        _textView.font = [UIFont systemFontOfSize:kFontSize];
        _textView.text = text;
        
        self.title = guiTitle;
    }
    return self;
}

- (void)dealloc {
    [_textView release];
    [super dealloc];
}

- (void)postViewDidLoad {
    [super postViewDidLoad];
    [self.view addSubview:_textView];
}

- (void)postViewWillAppear {
    [_textView becomeFirstResponder];
}

- (void)doneButtonTapped:(id)sender {
    [_textView resignFirstResponder];
    [self.delegate textGUIFinishedWithText:_textView.text
                                inInputGUI:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
