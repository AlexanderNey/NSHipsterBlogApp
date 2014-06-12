//
//  NSHRSSFeedSpec.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSDateTransformer.h"

// Frameworks
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>


SpecBegin(NSHRSSDateTransformerSpec)

describe(@"NSHRSSDateTransformer", ^{
    
    __block NSValueTransformer *dateTransformer;
    
    beforeAll(^{
        dateTransformer = [NSHRSSDateTransformer sharedInstance];
    });
    
    it (@"should not dateTransformer nil", ^{
        expect(dateTransformer).toNot.beNil();
    });
    
    describe(@"given date1 = Tue, 21 Feb 1982 16:01:02 0000 and date2 = Tue, 21 Feb 1982 16:01:02 +0200", ^{
        
        NSString *dateString1 = @"Tue, 21 Feb 1982 16:01:02 GMT";
        NSString *dateString2 = @"Tue, 21 Feb 1982 16:01:02 +0200";
        
        __block NSDate *date1;
        __block NSDate *date2;
        
        beforeAll(^{
            date1 = [dateTransformer transformedValue:dateString1];
            date2 = [dateTransformer transformedValue:dateString2];
        });
        
        it(@"should convert date1 to 21.02.1982 16:01:02 GMT", ^{
            expect(date1).to.equal([NSDate dateWithTimeIntervalSince1970:383155262]);
        });
        
        it(@"should convert date2 to 21.02.1982 16:01:02 GMT+2", ^{
            expect(date2).to.equal([NSDate dateWithTimeIntervalSince1970:383155262 - (60 * 60 * 2)]);
        });
        
    });

});

SpecEnd