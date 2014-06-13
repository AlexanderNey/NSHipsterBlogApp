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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.requestCounter = 0;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.articleURL]];
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.requestCounter++;
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    if ([items indexOfObject:self.activityItem] == NSNotFound)
    {
        NSInteger statusTextIndex = [items indexOfObject:self.statusBarButtonItem];
        NSAssert(statusTextIndex != NSNotFound, @"status text item not found in toolbar");
        [items insertObject:self.activityItem atIndex:statusTextIndex ];
        self.statusBarButtonItem.title = NSLocalizedString(@"Loading ...", nil);
        [self setToolbarItems:items animated:YES];
    }
    
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self p_removeLoadingIndicator];
        });
    }
}

#pragma mark - loading indicator

- (void)p_removeLoadingIndicator
{
    if (self.requestCounter == 0)
    {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
}


@end
