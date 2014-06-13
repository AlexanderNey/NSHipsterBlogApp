//
//  NSHRSSFeedItemTableViewCell.h
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSHRSSFeedItemTableViewCell : UITableViewCell

/**
 *  feeds the cell with the displayale data and updates its layout constraints
 *
 *  @param title           title of the feed item
 *  @param description     description of the feed item
 *  @param publicationDate the publication date of the feed item
 */
- (void)displayTitle:(NSString *)title
         description:(NSString *)description
     publicationDate:(NSDate *)publicationDate;

@end
