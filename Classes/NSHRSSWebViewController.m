//
//  NSHRSSWebViewController.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 13/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSWebViewController.h"

@interface NSHRSSWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *statusBarButtonItem;
@property (strong, nonatomic)  UIBarButtonItem *activityItem;
@property (nonatomic, assign, readwrite) NSInteger requestCounter;
@end

@implementation NSHRSSWebViewController

#pragma mark - View lLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.requestCounter = 0;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.articleURL]];
}

#pragma mark - Properties

/**
 *  dynamic getter for the Activity item to be placed in the bottom bar
 *
 *  @return UIBarButtonItem
 */
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.requestCounter++;
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    
    // If activityIndicator is not in the bottom bar...
    if ([items indexOfObject:self.activityItem] == NSNotFound)
    {
        // Initialize the bottom bar with a activity view and loading title
        NSInteger statusTextIndex = [items indexOfObject:self.statusBarButtonItem];
        NSAssert(statusTextIndex != NSNotFound, @"status text item not found in toolbar");
        [items insertObject:self.activityItem atIndex:statusTextIndex ];
        self.statusBarButtonItem.title = NSLocalizedString(@"Loading ...", nil);
        [self setToolbarItems:items animated:YES];
    }
    
    
    // Show bottom bar if hidden
    if (self.navigationController.isToolbarHidden)
    {
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.requestCounter--;
    
    if (self.requestCounter == 0)
    {
        // hide the bottom bar (loading indicator) if it was the latest request
        // due to the possiblity that request can be scheduled afterwards which will lead to a "flickr" animation
        // delay the removal by 300ms - this is much smoother
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self p_removeLoadingIndicator];
        });
    }
}

#pragma mark - loading indicator

/**
 *  if lates request was finished > hide the bottom bar
 */
- (void)p_removeLoadingIndicator
{
    if (self.requestCounter == 0)
    {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
}


@end
