//
//  NSHRSSFeed.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
#import <Mantle/Mantle.h>

FOUNDATION_EXPORT NSString *const NSHRSSFeedURLConfigurationKey;


@class NSHRSSFeed;

typedef void (^NSHRSSFeedRequestCompletion)(NSHRSSFeed *feed, NSError *error);

@interface NSHRSSFeed : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSDate   *publicationDate;
@property (nonatomic, strong, readonly) NSArray  *items;

+ (void)requestFeedFromURL:(NSURL *)feedURL completion:(NSHRSSFeedRequestCompletion)completion;
+ (instancetype)feedWithXMLParser:(NSXMLParser *)parser error:(NSError *)error;

@end
