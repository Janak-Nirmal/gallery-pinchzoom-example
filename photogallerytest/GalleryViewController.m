//
//  GalleryViewController.m
//  photogallerytest
//
//  Created by K Rummler on 5/29/13.
//

#import "GalleryViewController.h"
#import "GalleryImageCell.h"
#import "ImageContext.h"

@interface GalleryViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation GalleryViewController

- (id)initWithImages:(NSArray*)images selected:(NSUInteger)selectedImage
{
    self = [super initWithNibName:@"GalleryViewController" bundle:nil];
    if (self) {
        self.images = images;
        self.selectedImage = selectedImage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [[UIApplication sharedApplication] keyWindow].frame;
    UINib *cellNib = [UINib nibWithNibName:@"GalleryImageCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"galleryImageCell"];
    
    [self.collectionView setPagingEnabled:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"galleryImageCell" forIndexPath:indexPath];

    ImageContext *imageContext = [self.images objectAtIndex:indexPath.row];
    
    cell.imageContext = imageContext;
    
    return cell;
}

- (void)setSelectedImage:(NSUInteger)selectedImage
{
    _selectedImage = selectedImage;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedImage inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally | UICollectionViewScrollPositionCenteredVertically) animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
