//
//  ALFamousView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/25.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALFamousViewCell.h"
#import "ALFamousViewItem.h"
#import "AlanDownLoadIMGManager.h"
@interface ALFamousViewCell ()<UICollectionViewDataSource ,UICollectionViewDelegate>
@property (nonatomic ,weak) UICollectionView *collectionView;
@end
@implementation ALFamousViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bounds = CGRectMake(0, 0, kScreenWidth, 393 * 0.5);
        [self addSubviews];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)setHomeModel:(ALHomeModel *)homeModel{
    _homeModel = homeModel;
    [self.collectionView reloadData];
}

-(void)addSubviews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth * 0.5 - 0.5, 393 * 0.5 * 0.5);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1];
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"ALFamousViewItem" bundle:nil] forCellWithReuseIdentifier:@"ALFamousViewItem"];
    
    self.collectionView = collectionView;
    [self addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ALFamousViewItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"ALFamousViewItem" forIndexPath:indexPath];
    
    item.bounds = CGRectMake(0, 0, kScreenWidth * 0.5 - 0.5, self.bounds.size.height * 0.5 - 0.5);
    item.titleLabel.text = [_homeModel.famous.list[indexPath.row] name];
    item.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%ld",[_homeModel.famous.list[indexPath.row] score]]];
    [[AlanDownLoadIMGManager sharedInstance] downloadIMGWith:[_homeModel.famous.list[indexPath.row] cover]withFinishedBlock:^(UIImage *image) {
        item.imageView.image = image;
    }];
    item.distanceLabel.text = [NSString stringWithFormat:@"距离200米"];
    item.introLabel.text = [_homeModel.famous.list[indexPath.row] intro];
    
    return item;
}
#pragma mark - UICollectionViewDelegate

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
