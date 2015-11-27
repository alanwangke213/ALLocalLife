//
//  ALGroupViewCell.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/24.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALGroupViewCell.h"
#import "ALGroupViewItem.h"
#import "AlanDownLoadIMGManager.h"

@interface ALGroupViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic ,weak) UICollectionView *collectionView;
@end

@implementation ALGroupViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubviews];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)addSubviews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    layout.itemSize = CGSizeMake(kScreenWidth * 0.25, 353 * 0.5 * 0.5);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 353 * 0.5) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ooo"];
    self.collectionView = collectionView;
    [self addSubview:collectionView];
}

-(void)setHomeModel:(ALHomeModel *)homeModel{
    _homeModel = homeModel;
//    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ooo" forIndexPath:indexPath];
    
    ALGroupViewItem *item = [[NSBundle mainBundle] loadNibNamed:@"ALGroupViewItem" owner:nil options:nil].lastObject;
    item.frame = CGRectMake(0, 0, kScreenWidth * 0.25, 353 * 0.5 * 0.5);
    
    if (self.homeModel != nil) {
        item.titleLabel.text = [self.homeModel.group.list[indexPath.row] title];
        
        [[AlanDownLoadIMGManager sharedInstance] downloadIMGWith:[self.homeModel.group.list[indexPath.row] cover] withFinishedBlock:^(UIImage *image) {
            
            item.imageView.image = image;
            
            item.backgroundColor = [UIColor whiteColor];
        }];
    }
    
    [cell addSubview:item];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.backgroundColor = [UIColor greenColor];
    // Configure the view for the selected state
}

@end
