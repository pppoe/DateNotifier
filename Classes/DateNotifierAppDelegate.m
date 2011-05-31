//
//  DateNotifierAppDelegate.m
//  DateNotifier
//
//  Created by Haoxiang on 5/30/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DateNotifierAppDelegate.h"
#import "DateDetailEntryStore.h"
#import "NotificationCenter.h"
#import "NotificationListGUI.h"

#define kAutoSaveTimeInterval 60

@implementation DateNotifierAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        //< Pop alert here
        NSLog(@"didFinishLaunchingWithOptions: %@", notification);
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    NotificationListGUI *listGUI = [[NotificationListGUI alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:listGUI];
    [listGUI release];
    
    [self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];

    //< AUTO SAVE
    [NSTimer scheduledTimerWithTimeInterval:kAutoSaveTimeInterval
                                     target:self
                                   selector:@selector(autoSaveChanges)
                                   userInfo:nil
                                    repeats:YES];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self autoSaveChanges];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    [self autoSaveChanges];
}

- (void)autoSaveChanges {
    [[DateDetailEntryStore sharedStore] archiveStore];
    [[NotificationCenter sharedCenter] archiveCenter];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"didReceiveLocalNotification: %@", notification);
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //< Pop alert here
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
    [navController release];
    [window release];
    [super dealloc];
}


@end
