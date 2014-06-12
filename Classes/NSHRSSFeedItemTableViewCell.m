//
//  NSHRSSFeedItemTableViewCell.m
//  NSHipsterBlogApp
//
//  Created by Alexander Ney on 12/06/2014.
//  Copyright (c) 2014 Alexander Ney. All rights reserved.
//

#import "NSHRSSFeedItemTableViewCell.h"


static const NSInteger maxDescriptionCharacters = 100;

@interface NSHRSSFeedItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end


@implementation NSHRSSFeedItemTableViewCell

- (void)displayTitle:(NSString *)title description:(NSString *)description
{
    self.titleLabel.text = title;
    self.descriptionLabel.text = [description substringToIndex:MIN(maxDescriptionCharacters, description.length)];
}

@end
