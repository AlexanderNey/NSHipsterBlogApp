//
//  NSHRSSFeedSpec.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSFeed.h"
#import "NSHRSSFeedItem.h"

// Frameworks
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>


SpecBegin(NSHRSSFeedSpec)

describe(@"NSHRSSFeedSpec", ^{
    
    
    describe(@"given a valid rss xml is parsed", ^{
        
        __block NSHRSSFeed *feed;
        __block NSError *parserError;
        
        beforeAll(^{

            NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
            NSURL *testXMLURL = [mainBundle URLForResource:@"sample" withExtension:@"xml"];
            NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:testXMLURL];
            
            feed = [NSHRSSFeed feedWithXMLParser:parser error:parserError];
        });

        it(@"won't have set the a parser error", ^{
            expect(parserError).to.beNil();
        });
        
        it(@"won't return nil", ^{
            expect(feed).notTo.beNil();
        });
        
        it(@"will have title", ^{
            expect(feed.title).to.equal(@"FeedForAll Sample Feed");
        });
        
        it(@"will have description", ^{
            expect(feed.description).to.equal(@"RSS is a fascinating technology...");
        });
        
        it(@"publication date is 10 / 19 / 2004 @ 17:38:55 UTC", ^{
            expect(feed.publicationDate).to.equal([NSDate dateWithTimeIntervalSince1970:1098207535]);
        });
        
        it(@"will have x items", ^{
            expect(feed.items).to.haveCountOf(3);
        });
       
        it(@"feed items are all of type NSHRSSFeedItem", ^{
            for (id item in feed.items)
            {
                expect(item).to.beKindOf(NSHRSSFeedItem.class);
            }
        });
        
        it(@"first feed item has correct values", ^{
            
            NSHRSSFeedItem *item = feed.items[0];
            expect(item.title).to.equal(@"RSS Solutions for Restaurants");
            expect(item.description).to.equal(@"FeedForAll");
            expect(item.publicationDate).to.equal([NSDate dateWithTimeIntervalSince1970:1098198551]);
            expect(item.url).to.equal([NSURL URLWithString:@"http://www.feedforall.com/restaurant.htm"]);
        });
        
        it(@"second feed item has correct values", ^{
            
            NSHRSSFeedItem *item = feed.items[1];
            expect(item.title).to.equal(@"RSS Solutions for Politicians");
            expect(item.description).to.equal(@"FeedForAll helps Politicians...");
            expect(item.publicationDate).to.equal([NSDate dateWithTimeIntervalSince1970:1098198543]);
            expect(item.url).to.equal([NSURL URLWithString:@"http://www.feedforall.com/politics.htm"]);
        });
        
        it(@"third feed item has correct values", ^{
            
            NSHRSSFeedItem *item = feed.items[2];
            expect(item.title).to.equal(@"RSS Solutions for Meteorologists");
            expect(item.description).to.equal(@"FeedForAll helps Meteorologists...");
            expect(item.publicationDate).to.equal([NSDate dateWithTimeIntervalSince1970:1098198541]);
            expect(item.url).to.equal([NSURL URLWithString:@"http://www.feedforall.com/weather.htm"]);
        });
    });
});

SpecEnd