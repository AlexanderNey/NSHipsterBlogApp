//
//  NSHRSSDateTransformer.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSDateTransformer.h"

// Frameworks
#import <Mantle/Mantle.h>


@implementation NSHRSSDateTransformer

+ (MTLValueTransformer *)sharedInstance
{
    static dispatch_once_t pred;
    static MTLValueTransformer* sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:locale];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
        sharedInstance = [MTLValueTransformer transformerWithBlock:^(NSString *str) {
            return [dateFormatter dateFromString:str];
        }];
    });
    
    return sharedInstance;
}

@end
