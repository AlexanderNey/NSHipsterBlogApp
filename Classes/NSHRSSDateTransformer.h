//
//  NSHRSSDateTransformer.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//


@interface NSHRSSDateTransformer : NSValueTransformer

+ (NSValueTransformer *)sharedInstance;

- (instancetype)init __attribute__((unavailable("init not available use +sharedInstance instead")));

@end
