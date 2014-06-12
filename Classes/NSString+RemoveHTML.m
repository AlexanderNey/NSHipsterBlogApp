//
//  NSString+RemoveHTML.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSString+RemoveHTML.h"


@implementation NSString (RemoveHTML)

- (NSString *) stringByStrippingHTML
{
    NSRange range;
    NSMutableString *string = [self mutableCopy];
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        [string replaceCharactersInRange:range withString:@""];
    return [string copy];
}

@end
