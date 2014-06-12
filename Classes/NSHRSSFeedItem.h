//
//  NSHRSSFeedItem.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
#import <Mantle/Mantle.h>


@interface NSHRSSFeedItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *description;
@property (nonatomic, strong, readonly) NSURL    *url;
@property (nonatomic, strong, readonly) NSDate   *publicationDate;

@end
