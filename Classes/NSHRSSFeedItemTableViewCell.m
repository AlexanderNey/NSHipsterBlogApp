//
//  NSHRSSFeedItemTableViewCell.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSFeedItemTableViewCell.h"

// Categories
#import <NSDate+TimeAgo/NSDate+TimeAgo.h>


// Defines the maximum string length of the feed description
static const NSInteger NSHRSSFeedItemTableViewCellMaxDescriptionCharacters = 255;

@interface NSHRSSFeedItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


@implementation NSHRSSFeedItemTableViewCell

- (void)displayTitle:(NSString *)title
         description:(NSString *)description
     publicationDate:(NSDate *)publicationDate
{
    self.titleLabel.text = title;
    self.descriptionLabel.text = [description substringToIndex:MIN(NSHRSSFeedItemTableViewCellMaxDescriptionCharacters, description.length)];
    self.dateLabel.text = [publicationDate dateTimeAgo];
    [self.contentView setNeedsLayout];
}

@end
