//
//  ImageCell.m
//  photogallerytest
//
//  Created by K Rummler on 5/27/13.
//

#import "ImageCell.h"

#import "UIImage+Resize.h"

@interface ImageCell ()



@end

@implementation ImageCell

- (void)setImage:(UIImage *)image
{
    self.imageView.image = [image scaleWithMinSize:self.frame.size.width * [UIScreen mainScreen].scale];
    _image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
