//
//  TextInputGUI.h
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextInputGUI;

@protocol TextInputGUIDelegate

- (void)textGUIFinishedWithText:(NSString *)text inInputGUI:(TextInputGUI *)textInputGUI;

@end


@interface TextInputGUI : UIViewController {
    id<TextInputGUIDelegate> _delegate;
    int tag;
}

@property (nonatomic, assign) int tag;
@property (nonatomic, assign) id<TextInputGUIDelegate> delegate;

- (id)initWithText:(NSString *)text andGUITitle:(NSString *)guiTitle;

- (void)postViewDidLoad;
- (void)postViewWillAppear;

- (void)doneButtonTapped:(id)sender;

@end
