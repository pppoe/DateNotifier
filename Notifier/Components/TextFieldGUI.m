//
//  TextFieldGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "TextFieldGUI.h"

@implementation TextFieldGUI

- (id)initWithText:(NSString *)text andGUITitle:(NSString *)guiTitle{
    if ((self = [super init]))
    {
        float pageWidth = 320.0f;

        const float kLeftPaddding = 20.0f;
        const float kRightPadding = 20.0f;
        const float kTopPadding = 40.0f;
        
        const float kTextFieldHeight = 50.0f;
        
        const float kFontSize = 18.0f;
        
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(kLeftPaddding, kTopPadding, 
                                                                   pageWidth - kLeftPaddding - kRightPadding, 
                                                                   kTextFieldHeight)];
        _textfield.delegate = self;
        _textfield.font = [UIFont systemFontOfSize:kFontSize];
        _textfield.text = text;
        
        self.title = guiTitle;
    }
    return self;
}

- (void)dealloc {
    [_textfield release];
    [super dealloc];
}

- (void)postViewDidLoad {
    [super postViewDidLoad];
    [self.view addSubview:_textfield];
}

- (void)postViewWillAppear {
    [_textfield becomeFirstResponder];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)doneButtonTapped:(id)sender {
    [self.delegate textGUIFinishedWithText:_textfield.text
                                inInputGUI:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
