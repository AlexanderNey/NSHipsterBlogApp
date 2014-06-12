//
//  NSHRSSFeedItem.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSFeedItem.h"

// Private
#import "NSHRSSFeedItem_Private.h"


@implementation NSHRSSFeedItem


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{ NSStringFromSelector(@selector(publicationDate)): @"pubDate",
              NSStringFromSelector(@selector(url)): @"link" };
}

+ (NSValueTransformer *)urlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)publicationDateJSONTransformer
{
    return [NSHRSSDateTransformer sharedInstance];
}

+ (NSValueTransformer *)titleJSONTransformer
{
    return [NSHRSSStringSanitizingTransformer sharedInstance];
}

+ (NSValueTransformer *)descriptionJSONTransformer
{
    return [NSHRSSStringSanitizingTransformer sharedInstance];
}

@end
