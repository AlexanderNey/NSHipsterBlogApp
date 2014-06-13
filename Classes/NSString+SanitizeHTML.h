//
//  NSString+RemoveHTML.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (SanitizeHTML)

/**
 *  will return a string by removing all html tags e.g. <tag> and </tag> from the string
 *  due to performance impliciation the maximum leght of the characters has been limited to 64!
 */
- (NSString *) stringByStrippingHTML;

/**
 *  will return a string by decoding all unicode charancters  in the format of &#2031;
 */
- (NSString *)stringByDecodingXMLUnicodeEntities;

/**
 *  will return a string by decoding well known predefined xml entities e.g. &quot;
 */
- (NSString *)stringByReplacingPredefinedXMLEntities;

@end
