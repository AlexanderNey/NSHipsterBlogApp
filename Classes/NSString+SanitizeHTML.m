//
//  NSString+RemoveHTML.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSString+SanitizeHTML.h"

static NSDictionary *_predefinedXMLEntities;

@implementation NSString (SanitizeHTML)

- (NSString *) stringByStrippingHTML
{
    NSRange range;
    NSMutableString *string = [self mutableCopy];
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        [string replaceCharactersInRange:range withString:@""];
    }
    return [string copy];
}

- (NSString *)stringByReplacingXMLUnicodeEntities
{
    NSRange range;
    NSMutableString *string = [self mutableCopy];
    while ((range = [string rangeOfString:@"&#[^>]{1,4};" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        NSMutableCharacterSet *nonNumberChars = [NSMutableCharacterSet characterSetWithCharactersInString:@"&#;"];
        NSString *unicodeString = [[string substringWithRange:range] stringByTrimmingCharactersInSet:nonNumberChars];
        unichar unicodeChar = [unicodeString integerValue];
        if (unicodeChar > 0)
        {
            [string replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%c", unicodeChar]];
        }
        else
        {
            [string replaceCharactersInRange:range withString:@"�"];
        }
    }
    return [string copy];
}

- (NSString *)stringByReplacingPredefinedXMLEntities
{
    NSDictionary *predefinedXMLEntities = [self predefinedXMLEntities];
    NSRange range;
    NSMutableString *string = [self mutableCopy];
    while ((range = [string rangeOfString:@"&[^>]{2,4};" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        NSMutableCharacterSet *nonRelatedChars = [NSMutableCharacterSet characterSetWithCharactersInString:@"&;"];
        NSString *enitityName = [[string substringWithRange:range] stringByTrimmingCharactersInSet:nonRelatedChars];
        
        if (predefinedXMLEntities[enitityName])
        {
            [string replaceCharactersInRange:range withString:predefinedXMLEntities[enitityName]];
        }
        else
        {
            [string replaceCharactersInRange:range withString:@"�"];
        }
    }
    return [string copy];
}

- (NSDictionary *)predefinedXMLEntities
{
    if (!_predefinedXMLEntities)
    {
        _predefinedXMLEntities = @{@"quot" : @"\"",
                                   @"amp" : @"&",
                                   @"apos" : @"'",
                                   @"lt" : @"<",
                                   @"gt" : @">",};
    }
    return _predefinedXMLEntities;
}

@end
