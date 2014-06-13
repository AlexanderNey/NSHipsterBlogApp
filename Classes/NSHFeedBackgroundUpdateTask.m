//
//  NSHFeedBackgroundUpdateTask.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 13/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHFeedBackgroundUpdateTask.h"

// Model
#import "NSHRSSFeed.h"

// Categories
#import <NSDate+TimeAgo/NSDate+TimeAgo.h>


static NSString *const NSHFeedBackgroundUpdateTaskLatestPublishDate = @"NSHFeedBackgroundUpdateTaskLatestPublishDate";


@implementation NSHFeedBackgroundUpdateTask

+ (void)setLatestPublicationSeenAt:(NSDate *)latestPublicationDate
{
    if (!latestPublicationDate) return; // Fail gracefully
    
    // Update publication date in user defaults
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:latestPublicationDate forKey:NSHFeedBackgroundUpdateTaskLatestPublishDate];
    [standardDefaults synchronize];
}

+ (void)fetchAndNotify:(NSHFeedBackgroundUpdateTaskCompletion)completion;
{
    NSURL *feedURL = [NSURL URLWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:NSHRSSFeedURLConfigurationKey]];
    
    [NSHRSSFeed requestFeedFromURL:feedURL completion:^(NSHRSSFeed *feed, NSError *error) {
        
        BOOL hasNewContent = NO;
            
        if (!error)
        {
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            NSDate *latestPublicationSeenDate = [standardDefaults objectForKey:NSHFeedBackgroundUpdateTaskLatestPublishDate];
            
            // If publishing date is later then the last saved one > schedule local notification
            if (!latestPublicationSeenDate || [latestPublicationSeenDate compare:feed.publicationDate] == NSOrderedAscending)
            {
                hasNewContent = YES;
                
                UILocalNotification* notification = [[UILocalNotification alloc] init];
                notification.fireDate = [NSDate dateWithTimeIntervalSinceNow: 1];
                notification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"A new article was published %@.", nil) , [feed.publicationDate timeAgo]];
                [[UIApplication sharedApplication] scheduleLocalNotification: notification];
                
                [self setLatestPublicationSeenAt:feed.publicationDate];
            }
        }
        
        if (completion)
        {
            completion(hasNewContent, error);
        }
    }];

}

@end
