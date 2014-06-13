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
@property (strong, nonatomic) IBOutlet UIRefreshControl *refreshControll;
@property (strong, nonatomic)  UIBarButtonItem *activityItem;
@property (atomic, assign, readwrite, getter = isLoading) BOOL loading;
@end

@implementation NSHRSSFeedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = _refreshControll;
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

- (IBAction)p_updateFeed
{
    if (self.isLoading) return;
    
    NSURL *feedURL = [NSURL URLWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:feedURLConfigurationKey]];
    
    [self p_updateUIToLoadingState];
    
    [NSHRSSFeed requestFeedFromURL:feedURL completion:^(NSHRSSFeed *feed, NSError *error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if (!error)
           {
               self.rssFeed = feed;
               [self.tableView reloadData];
           }
           
           [self p_updateUIToLoadedStateWithError:error];
       });
    }];
}

#pragma mark - Properties

- (UIBarButtonItem *)activityItem
{
    if (!_activityItem)
    {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        _activityItem = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    }
    
    return _activityItem;
}

#pragma mark - UI Updates

- (void)p_updateUIToLoadingState
{
    [self.refreshControl beginRefreshing];
    
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    NSInteger statusTextIndex = [items indexOfObject:self.statusBarButtonItem];
    NSAssert(statusTextIndex != NSNotFound, @"status text item not found in toolbar");
    [items insertObject:self.activityItem atIndex:statusTextIndex ];
    self.statusBarButtonItem.title = NSLocalizedString(@"Loading ...", nil);
    
    [self setToolbarItems:items animated:YES];
}

- (void)p_updateUIToLoadedStateWithError:(NSError *)error
{
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    [items removeObject:self.activityItem];
    [self setToolbarItems:items animated:YES];
    
    NSString *title;
    
    if (error)
    {
        title = error.localizedDescription;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        
        title = [NSString stringWithFormat:NSLocalizedString(@"Published: %@", nil), [dateFormatter stringFromDate:self.rssFeed.publicationDate]];
    }
    
    self.statusBarButtonItem.title =  title;
    
    [self.refreshControl endRefreshing];
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
    
    [cell displayTitle:feedItem.title
           description:feedItem.description
       publicationDate:feedItem.publicationDate];
    
    return cell;
}

#pragma mark - Navigation

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
