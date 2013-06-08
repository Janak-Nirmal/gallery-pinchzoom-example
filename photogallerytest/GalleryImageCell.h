//
//  GalleryImageCell.h
//  photogallerytest
//
//  Created by K Rummler on 6/4/13.
//

#import <UIKit/UIKit.h>
#import "ImageContext.h"

@interface GalleryImageCell : UICollectionViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) ImageContext *imageContext;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
