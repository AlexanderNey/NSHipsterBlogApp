//
//  NSHRSSWebViewController.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 13/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSHRSSWebViewController : UIViewController

// the url of the feed article to be displayed
@property (nonatomic, strong, readwrite) NSURL *articleURL;

@end
