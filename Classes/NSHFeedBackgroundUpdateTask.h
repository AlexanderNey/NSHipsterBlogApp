//
//  NSHFeedBackgroundUpdateTask.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 13/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^NSHFeedBackgroundUpdateTaskCompletion)(BOOL hasNewContent, NSError *error);

@interface NSHFeedBackgroundUpdateTask : NSObject

+ (void)fetchAndNotify:(NSHFeedBackgroundUpdateTaskCompletion)compltion;
+ (void)setLatestPublicationSeenAt:(NSDate *)latestPublicationDate;

@end
