//
//  ImageCell.h
//  photogallerytest
//
//  Created by K Rummler on 5/27/13.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) UIImage *image;

@end
