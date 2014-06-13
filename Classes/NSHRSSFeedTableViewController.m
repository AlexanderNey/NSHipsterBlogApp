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

// Controller
#import "NSHRSSWebViewController.h"


static NSString *const feedURLConfigurationKey = @"NSHFeedURL";


@interface NSHRSSFeedTableViewController ()
@property (nonatomic, copy, readwrite) NSHRSSFeed *rssFeed;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *statusBarButtonItem;
@end

@implementation NSHRSSFeedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     if (!self.rssFeed)
     {
         [self p_updateFeed];
     }
    
    [self.navigationController setToolbarHidden:NO animated:YES];
}


#pragma mark - Model

- (void)p_updateFeed
{
    NSURL *feedURL = [NSURL URLWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:feedURLConfigurationKey]];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView startAnimating];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    NSInteger statusTextIndex = [items indexOfObject:self.statusBarButtonItem];
    NSAssert(statusTextIndex != NSNotFound, @"status text item not found in toolbar");
    [items insertObject:activityItem atIndex:statusTextIndex ];
    self.statusBarButtonItem.title = NSLocalizedString(@"Loading ...", nil);
    
    [self setToolbarItems:items animated:YES];
    
    [NSHRSSFeed requestFeedFromURL:feedURL completion:^(NSHRSSFeed *feed, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           self.rssFeed = feed;
           [self.tableView reloadData];
           
           NSMutableArray *items = [self.toolbarItems mutableCopy];
           [items removeObject:activityItem];
           [self setToolbarItems:items animated:YES];
           
           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
           dateFormatter.timeStyle = NSDateFormatterShortStyle;
           dateFormatter.dateStyle = NSDateFormatterMediumStyle;
           NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Published: %@", nil), [dateFormatter stringFromDate:self.rssFeed.publicationDate]];
           self.statusBarButtonItem.title =  title;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSHRSSFeedItemTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSHRSSFeedItem *feedItem = [[self.rssFeed items] objectAtIndex:indexPath.row];
    
    if([segue.destinationViewController isKindOfClass:NSHRSSWebViewController.class])
    {
        NSHRSSWebViewController *webViewController = (NSHRSSWebViewController *)segue.destinationViewController;
        webViewController.articleURL = feedItem.url;
        webViewController.title = feedItem.title;
    }
}


@end
