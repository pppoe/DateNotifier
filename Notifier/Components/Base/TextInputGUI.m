    //
//  TextInputGUI.m
//  DateNotifier
//
//  Created by Haoxiang on 5/31/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "TextInputGUI.h"


@implementation TextInputGUI
@synthesize delegate = _delegate;
@synthesize tag;

- (id)initWithText:(NSString *)text andGUITitle:(NSString *)guiTitle {
    if ((self = [super init]))
    {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postViewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self postViewWillAppear];
}

- (void)doneButtonTapped:(id)sender {
}

- (void)postViewDidLoad {
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    [doneItem release];
}

- (void)postViewWillAppear {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end
