//
//  NSHRSSFeedSpec.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSStringSanitizingTransformer.h"

// Frameworks
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>


SpecBegin(NSHRSSStringSanitizingTransformerSpec)

describe(@"NSHRSSStringSanitizingTransformerSpec", ^{
    
     __block NSValueTransformer *stringTransformer;
    
    beforeAll(^{
        stringTransformer = [NSHRSSStringSanitizingTransformer sharedInstance];
    });
    
    it (@"should not be nil", ^{
        expect(stringTransformer).toNot.beNil();
    });
    
    describe(@"given a bunch of unsanitized strings", ^{
        
        NSString *unsanitizedString1 = @"  This is a real test ";
        NSString *unsanitizedString2 = @"<html> <b>This</b> is a real test a<b/";
        NSString *unsanitizedString3 = @"This <i>is</i> a real test ";
        NSString *unsanitizedString4 = @"This is a &#39;real&#39; test &#248; ";
        NSString *unsanitizedString5 = @"This is a &quot;real&quot; test&lt;b&gt; ";
        
        __block NSDate *sanitizedString1;
        __block NSDate *sanitizedString2;
        __block NSDate *sanitizedString3;
        __block NSDate *sanitizedString4;
        __block NSDate *sanitizedString5;
        
        beforeAll(^{
            sanitizedString1 = [stringTransformer transformedValue:unsanitizedString1];
            sanitizedString2 = [stringTransformer transformedValue:unsanitizedString2];
            sanitizedString3 = [stringTransformer transformedValue:unsanitizedString3];
            sanitizedString4 = [stringTransformer transformedValue:unsanitizedString4];
            sanitizedString5 = [stringTransformer transformedValue:unsanitizedString5];
        });
        
        it(@"should convert unsanitizedString1 to 'This is a real test'", ^{
            expect(sanitizedString1).to.equal(@"This is a real test");
        });
        
        it(@"should convert unsanitizedString2 to 'This is a real test a<b/'", ^{
            expect(sanitizedString2).to.equal(@"This is a real test a<b/");
        });
        
        it(@"should convert unsanitizedString3 to 'This is a real test'", ^{
            expect(sanitizedString3).to.equal(@"This is a real test");
        });
        
        it(@"should convert unsanitizedString4 to 'This is a 'real' test ø'", ^{
            expect(sanitizedString4).to.equal(@"This is a 'real' test ø");
        });
        
        it(@"should convert unsanitizedString5 to 'This is a \"real\" test<b>'", ^{
            expect(sanitizedString5).to.equal(@"This is a \"real\" test<b>");
        });
    });
    
});

SpecEnd