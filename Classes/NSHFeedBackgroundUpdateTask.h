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

/**
 *  will fetch the RSS feed and check if the publication date is later then the already sawn publichation
 *  set by setLatestPublicationSeenAt:
 *  if newer content was found a local push notification will be scheuled to inform the user
 *  this should be executed within the context of a background fetch
 *
 *  @param compltion NSHFeedBackgroundUpdateTaskCompletion
 */
+ (void)fetchAndNotify:(NSHFeedBackgroundUpdateTaskCompletion)completion;

/**
 *  set the date of the latest publication the user has seen
 *  this should be called from the UI part of the app after the user saw / read the latest articels
 *
 *  @param latestPublicationDate NSDate
 */
+ (void)setLatestPublicationSeenAt:(NSDate *)publicationDate;

@end
