//
//  NSHRSSStringSanitizingTransformer.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSStringSanitizingTransformer.h"

// Categories
#import "NSString+RemoveHTML.h"

// Frameworks
#import <Mantle/Mantle.h>


@implementation NSHRSSStringSanitizingTransformer

+ (MTLValueTransformer *)sharedInstance
{
    static dispatch_once_t pred;
    static MTLValueTransformer* sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [MTLValueTransformer transformerWithBlock:^(NSString *str) {
            
            NSString *sanitizedString = [str stringByStrippingHTML];
            sanitizedString = [sanitizedString stringByTrimmingCharactersInSet:
[NSCharacterSet whitespaceCharacterSet]];
            
            return sanitizedString;
        }];
    });
    
    return sharedInstance;
}

@end
