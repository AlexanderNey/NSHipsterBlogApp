//
//  NSHAppDelegate.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHAppDelegate.h"

// Model
#import "NSHFeedBackgroundUpdateTask.h"


@implementation NSHAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];

    
    return YES;
}

- (void) application:(UIApplication *)application
  performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [NSHFeedBackgroundUpdateTask fetchAndNotify:^(BOOL hasNewContent, NSError *error) {
        if (hasNewContent)
        {
            completionHandler(UIBackgroundFetchResultNewData);
        }
        else
        {
            completionHandler(UIBackgroundFetchResultNoData);
        }
    }];
}

@end
