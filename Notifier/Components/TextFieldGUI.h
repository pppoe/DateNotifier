//
//  TextFieldGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "TextInputGUI.h"

@interface TextFieldGUI : TextInputGUI <UITextFieldDelegate> {
    UITextField *_textfield;
}

@end
