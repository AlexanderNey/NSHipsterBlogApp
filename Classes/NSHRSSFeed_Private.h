//
//  NSHRSSFeed_Private.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//


// Model
#import "NSHRSSFeedItem.h"
#import "NSHRSSDateTransformer.h"
#import "NSHRSSStringSanitizingTransformer.h"

// Frameworks
#import <XMLDictionary/XMLDictionary.h>
#import <AFNetworking/AFNetworking.h>


@interface NSHRSSFeed ()

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *description;
@property (nonatomic, strong, readwrite) NSDate   *publicationDate;
@property (nonatomic, strong, readwrite) NSArray  *items;


@end
