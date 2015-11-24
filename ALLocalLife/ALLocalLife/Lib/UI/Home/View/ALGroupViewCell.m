//
//  ALGroupViewCell.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/24.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALGroupViewCell.h"

@interface ALGroupViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ALGroupViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self addSubviews];
    
    return self;
}

-(void)addSubviews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    

    layout.itemSize = CGSizeMake(kScreenWidth * 0.25, 353 * 0.5 * 0.5);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 353) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ooo"];
    
    [self addSubview:collectionView];
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
    if (cell == nil) {
        
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    return cell;
}


#pragma mark - UICollectionViewDelegate


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.backgroundColor = [UIColor greenColor];
    // Configure the view for the selected state
}

@end