//
//  NSHRSSFeed.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSFeed.h"

// Private
#import "NSHRSSFeed_Private.h"


NSString *const NSHRSSFeedURLConfigurationKey = @"NSHFeedURL";


@implementation NSHRSSFeed


+ (void)requestFeedFromURL:(NSURL *)feedURL completion:(NSHRSSFeedRequestCompletion)completion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:feedURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(backgroundQueue, ^{
            NSError *parserError;
            NSXMLParser *parser = (NSXMLParser *)responseObject;
            
            NSHRSSFeed *feed = [self feedWithXMLParser:parser error:parserError];
            
            if (completion)
            {
                completion(feed, parserError);
            }

        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (completion)
        {
            completion(nil, error);
        }
    }];
    [operation start];
}

+ (instancetype)feedWithXMLParser:(NSXMLParser *)parser error:(NSError *)error
{
    NSDictionary *feedResult = [NSDictionary dictionaryWithXMLParser:parser];
    NSDictionary *channel = feedResult[@"channel"];
    return [MTLJSONAdapter modelOfClass:self fromJSONDictionary:channel error:&error];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{ NSStringFromSelector(@selector(publicationDate)): @"pubDate",
              NSStringFromSelector(@selector(items)): @"item"};
}

+ (NSValueTransformer *)publicationDateJSONTransformer
{
    return [NSHRSSDateTransformer sharedInstance];
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:NSHRSSFeedItem.class];
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
