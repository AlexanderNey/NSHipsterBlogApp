//
//  NSHRSSFeedItem_Private.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

// Model
#import "NSHRSSDateTransformer.h"
#import "NSHRSSStringSanitizingTransformer.h"


@interface NSHRSSFeedItem ()

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *description;
@property (nonatomic, strong, readwrite) NSURL    *url;
@property (nonatomic, strong, readwrite) NSDate   *publicationDate;

@end
