//
//  NSHFeedTableViewController.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSFeedTableViewController.h"

// Model
#import "NSHRSSFeed.h"
#import "NSHRSSFeedItem.h"

// View
#import "NSHRSSFeedItemTableViewCell.h"


static NSString *const feedURLConfigurationKey = @"NSHFeedURL";


@interface NSHRSSFeedTableViewController ()
@property (nonatomic, copy, readwrite) NSHRSSFeed *rssFeed;
@end

@implementation NSHRSSFeedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self p_updateFeed];
}


#pragma mark - Model

- (void)p_updateFeed
{
    NSURL *feedURL = [NSURL URLWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:feedURLConfigurationKey]];
    [NSHRSSFeed requestFeedFromURL:feedURL completion:^(NSHRSSFeed *feed, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           self.rssFeed = feed;
           [self.tableView reloadData];
       });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.rssFeed items] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSHRSSFeedItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(NSHRSSFeedItemTableViewCell.class) forIndexPath:indexPath];
    
    // Configure the cell...
    NSHRSSFeedItem *feedItem = [[self.rssFeed items] objectAtIndex:indexPath.row];
    
    [cell displayTitle:feedItem.title description:feedItem.description];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
