//
//  DateNotifierAppDelegate.h
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateNotifierAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)autoSaveChanges;

@end

