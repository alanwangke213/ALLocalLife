//
//  ALScrollAdsView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/24.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALFocusView.h"
#import "AlanDownLoadIMGManager.h"

@interface ALFocusView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *adsView;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *adPageControl;
@property (weak, nonatomic) UIScrollView *scrollView;

@property (strong ,nonatomic) NSTimer *timer;

@end

@implementation ALFocusView

-(void)awakeFromNib{
    self.adPageControl.currentPage = 0;
}

-(void)setHomeModel:(ALHomeModel *)homeModel{
    _homeModel = homeModel;
    
    self.adPageControl.numberOfPages = _homeModel.focus.list.count;

    [self addSubviews];
}

-(void)addSubviews{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.contentSize = CGSizeMake(_homeModel.focus.list.count*kScreenWidth, 0);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    self.scrollView = scrollView;
    [self.adsView addSubview:scrollView];
    
    //为了优化视觉效果，需要多增加一个放在最左边
    for (int i = 0; i < _homeModel.focus.list.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, self.bounds.size.height)];
        NSString *URLString = [self.homeModel.focus.list[i] cover];
        AlanDownLoadIMGManager *manager = [AlanDownLoadIMGManager sharedInstance];
        [manager downloadIMGWith:URLString withFinishedBlock:^(UIImage *image) {
            imageView.image = image;
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }];
        
        [scrollView addSubview:imageView];
    }
    self.adTitleLabel.text = [self.homeModel.focus.list[0] title];
    [self startTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.adPageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}

//需要优化
-(void)startTimer{
    
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
        self.timer = timer;

}

-(void)stopTimer{
    [self.timer invalidate];
}

-(void)changePage{
//    if (self.adPageControl.currentPage == self.homeModel.focus.list.count - 1){
//        self.scrollView.contentOffset = CGPointMake(-kScreenWidth, 0);
//    }
    self.adPageControl.currentPage = (self.adPageControl.currentPage + 1) % self.adPageControl.numberOfPages;
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(kScreenWidth * self.adPageControl.currentPage, 0);
        self.adTitleLabel.text = [self.homeModel.focus.list[self.adPageControl.currentPage] title];

    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
