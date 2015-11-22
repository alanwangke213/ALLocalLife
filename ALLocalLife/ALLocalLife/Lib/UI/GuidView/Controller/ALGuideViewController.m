//
//  ALGuideViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/22.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALGuideViewController.h"

@interface ALGuideViewController ()
@property (nonatomic ,strong) NSArray *guideViewImages;
@end

@implementation ALGuideViewController

static NSString * const reuseIdentifier = @"GuideViewCell";

-(NSArray *)guideViewImages{
    if (!_guideViewImages) {
        UIImage *image0 = [UIImage imageNamed:@"guide_0"];
        UIImage *image1 = [UIImage imageNamed:@"guide_1"];
        UIImage *image2 = [UIImage imageNamed:@"guide_2"];
        
        _guideViewImages = [NSArray arrayWithObjects:image0,image1,image2, nil];
        
    }
    return _guideViewImages;
}

-(instancetype)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.guideViewImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    /* CGContextRef */
    
    UIGraphicsBeginImageContext(kScreenBounds.size);
    UIImage *image = self.guideViewImages[indexPath.row];
    [image drawInRect:kScreenBounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    cell.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
    /* action */
    
    if (indexPath.row == self.guideViewImages.count - 1) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enter)];
        
        [cell addGestureRecognizer:tap];
    }
    
    return cell;
}

-(void)enter{
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:kFirstLogin];
    self.loginBlock(YES);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
