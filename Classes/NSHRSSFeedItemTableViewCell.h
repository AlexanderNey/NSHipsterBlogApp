//
//  NSHRSSFeedItemTableViewCell.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSHRSSFeedItemTableViewCell : UITableViewCell

- (void)displayTitle:(NSString *)title
         description:(NSString *)description
     publicationDate:(NSDate *)publicationDate;

@end
