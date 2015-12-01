//
//  ALSelfCenterViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALSelfCenterViewController.h"
#import "ALObjFactory.h"
#import "ALAccountManager.h"
#import "AppDelegate.h"
#define kSex @"男"
#define kTelephone @"13691091920"
@interface ALSelfCenterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,weak) UILabel *nameLabel;
@property (nonatomic ,weak) UILabel *sexLabel;
@property (nonatomic ,weak) UIView *coverView;
@property (nonatomic ,weak) UIImageView *imageView;
@property (nonatomic ,strong) UIImagePickerController *picker;
@end

@implementation ALSelfCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"个人中心";
    
    [self.rightButton setImage:nil forState:UIControlStateNormal];
    self.rightButton.enabled = NO;
    
    [self addSubviews];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseLogo)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tapGes];
}

-(void)addSubviews{
    //view_0
    UIView *view_0 = [ALObjFactory getUIViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.navBar.frame), kScreenWidth, 170 ) withColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 170 - 24, 170 - 24)];
    imageView.backgroundColor = [UIColor colorWithWhite:0.529 alpha:1.000];
    [view_0 addSubview:imageView];
    
    self.imageView = imageView;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 25, (CGRectGetHeight(imageView.frame) - 19 - 16 - 19) * 0.5, 22 * 5, 22)];
    label.font = [UIFont systemFontOfSize:22];
    [view_0 addSubview:label];
    self.nameLabel = label;
    label.text = @"小白";
    
    UIButton *recordButton = [ALObjFactory getBlueButtonWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame) + 36 * 0.6, kScreenWidth * 0.3, 64 * 0.6) withTitle:@"我的订单"];
    recordButton.layer.cornerRadius = 5;
    recordButton.layer.masksToBounds = YES;
    [view_0 addSubview:recordButton];
    [self.view addSubview:view_0];
    
    //view_1
    UIView *view_1 = [ALObjFactory getUIViewWithFrame:CGRectMake(0, CGRectGetMaxY(view_0.frame) + 6, kScreenWidth, 84 * 0.6 ) withColor:[UIColor whiteColor]];
    UILabel *sexLabel = [ALObjFactory getLabelwithTitle:@"性别" withFont:[UIFont systemFontOfSize:28 * 0.6] withColor:[UIColor colorWithRed:40/255. green:40/255. blue:40/255. alpha:1]];
    sexLabel.frame = CGRectMake(15, (84 - 28) * 0.25, 28 * 0.6 * 2, 28 * 0.6);
    [view_1 addSubview:sexLabel];
    UILabel *sexInfoLabel = [ALObjFactory getLabelwithTitle:kSex withFont:[UIFont systemFontOfSize:28 * 0.6] withColor:[UIColor colorWithRed:40/255. green:40/255. blue:40/255. alpha:1]];
    sexInfoLabel.frame = CGRectMake(kScreenWidth * 0.5, (84 - 28) * 0.25, 28 * 0.6 * 2, 28 * 0.6);
    self.sexLabel = sexInfoLabel;
    [view_1 addSubview:sexInfoLabel];
    [self.view addSubview:view_1];
    //view_2
    
    UIView *view_2 = [ALObjFactory getUIViewWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 1, kScreenWidth, 84 * 0.6 ) withColor:[UIColor whiteColor]];
    UILabel *telLabel = [ALObjFactory getLabelwithTitle:@"手机" withFont:[UIFont systemFontOfSize:28 * 0.6] withColor:[UIColor colorWithRed:40/255. green:40/255. blue:40/255. alpha:1]];
    telLabel.frame = CGRectMake(15, (84 - 28) * 0.25, 28 * 0.6 * 2, 28 * 0.6);
    [view_2 addSubview:telLabel];
    UILabel *telInfoLabel = [ALObjFactory getLabelwithTitle:kTelephone withFont:[UIFont systemFontOfSize:28 * 0.6] withColor:[UIColor colorWithRed:40/255. green:40/255. blue:40/255. alpha:1]];
    telInfoLabel.frame = CGRectMake(kScreenWidth * 0.5, telLabel.frame.origin.y, 28 * 0.6 * 14, 28 * 0.6);
    self.sexLabel = telInfoLabel;
    
    [view_2 addSubview:telInfoLabel];
    [self.view addSubview:view_2];
    
    //view_3
    //    kScreenHeight - CGRectGetMaxY(view_2.frame)/960. * kScreenHeight
    UIView *view_3 = [ALObjFactory getUIViewWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 1, kScreenWidth,  (kScreenHeight - CGRectGetMaxY(view_2.frame) - 1 )) withColor:[UIColor whiteColor]];
    UIButton *editInfoBtn = [ALObjFactory getBlueButtonWithFrame:CGRectMake(36, 64 * 0.6, (kScreenWidth - 36 - 36 - 28 * 0.6) * 0.5, 74 * 0.6) withTitle:@"修改资料"];
    [editInfoBtn setImage:[UIImage imageNamed:@"user_info"] forState:UIControlStateNormal];
    editInfoBtn.backgroundColor = [UIColor colorWithRed:0.204 green:0.698 blue:0.780 alpha:1.000];
    [view_3 addSubview:editInfoBtn];
    
    UIButton *editPassBtn = [ALObjFactory getBlueButtonWithFrame:CGRectMake(CGRectGetMaxX(editInfoBtn.frame) + 28 * 0.6, 64 * 0.6, (kScreenWidth - 36 - 36 - 28 * 0.6) * 0.5, 74 * 0.6) withTitle:@"修改密码"];
    [editPassBtn setImage:[UIImage imageNamed:@"user_passwd"] forState:UIControlStateNormal];
    editPassBtn.backgroundColor = [UIColor colorWithRed:0.204 green:0.698 blue:0.780 alpha:1.000];
    [view_3 addSubview:editPassBtn];
    
    //logoutBtn
    UIButton *logoutBtn = [ALObjFactory getBlueButtonWithFrame:CGRectMake(36 ,CGRectGetMaxY(editInfoBtn.frame) + 54 * 0.6 , kScreenWidth - 120 * 0.6 ,74 * 0.6) withTitle:@"退出登录"];
    logoutBtn.backgroundColor = [UIColor colorWithRed:0.769 green:0.318 blue:0.184 alpha:1.000];
    [view_3 addSubview:logoutBtn];
    [logoutBtn addTarget:self action:@selector(logoutNotice) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view_3];
}

#pragma mark - Lazy
-(UIImagePickerController *)picker{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
    }
    return _picker;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
//注销
-(void)logoutNotice{
    UIView *coverView = [[UIView alloc] initWithFrame:kScreenBounds];
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480 * 0.6, 270 * 0.6)];
    blueView.backgroundColor = [UIColor colorWithRed:0.851 green:0.969 blue:0.976 alpha:1.000];
    blueView.center = coverView.center;
    blueView.layer.cornerRadius = 10;
    blueView.layer.masksToBounds = YES;
    
    UILabel *noticeLabel = [ALObjFactory getLabelwithTitle:@"你真的要残忍退出吗？" withFont:[UIFont systemFontOfSize:38 * 0.6] withColor:[UIColor colorWithRed:66/255. green:66/255. blue:66/255. alpha:1.]];
    noticeLabel.frame = CGRectMake(0, 54 * 0.6, blueView.frame.size.width, 38 * 0.6);
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    [blueView addSubview:noticeLabel];
    
    UIButton * quitBtn = [ALObjFactory getBlueButtonWithFrame:CGRectMake(70 * 0.6, CGRectGetMaxY(noticeLabel.frame) + 36 * 0.6, (noticeLabel.frame.size.width - 140 * 0.6 - 48 * 0.6) * 0.5, 80 * 0.6) withTitle:@"残忍退出"];
    [quitBtn addTarget:self action:@selector(didClickLogoutBtn) forControlEvents:UIControlEventTouchUpInside];
    [blueView addSubview:quitBtn];
    
    UIButton * cancelBtn = [ALObjFactory getBlueButtonWithFrame:CGRectMake(CGRectGetMaxX(quitBtn.frame) + 48 * 0.6, CGRectGetMaxY(noticeLabel.frame) + 36 * 0.6, (noticeLabel.frame.size.width - 140 * 0.6 - 48 * 0.6) * 0.5, 80 * 0.6) withTitle:@"取消"];
    
    [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [blueView addSubview:cancelBtn];
    
    [coverView addSubview:blueView];
    self.coverView = coverView;
    self.coverView.alpha = 0;
    [self.view addSubview:coverView];
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 1;
    }];
}

-(void)didClickLogoutBtn{
    [self didClickCancelBtn];
    [ALAccountManager logout];
    //修改当前页的登陆状态
    [self changeRightBtnWithLoginStatus];
#pragma warning home页面无法自动修改
    //修改Home页面登录状态 <无法自动修改>
    [self.navigationController.viewControllers[0] performSelector:@selector(changeRightBtnWithLoginStatus) withObject:nil afterDelay:0];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickCancelBtn{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0.2;
    } completion:^(BOOL finished) {
        
        [self.coverView removeFromSuperview];
        
    }];
}

-(void)chooseLogo{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"分享" message:@"xxx" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionTakePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseLogoFromTakingPhoto];
    }];
    
    UIAlertAction *actionPhotoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseLogoFromPhotoLibrary];
        NSLog(@"相");
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    [alertVc addAction:actionTakePhoto];
    [alertVc addAction:actionPhotoLibrary];
    [alertVc addAction:actionCancel];
    
    [self presentViewController:alertVc animated:YES completion:^{
        
        
    }];
}

-(void)chooseLogoFromPhotoLibrary{
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.delegate = self;
    
    //设置选择后的图片可被编辑
    self.picker.allowsEditing = YES;
    
    [self presentViewController:self.picker animated:YES completion:^{
        
    }];
}

-(void)chooseLogoFromTakingPhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        self.picker.delegate = self;
        //设置拍照后的图片可被编辑
        self.picker.allowsEditing = YES;
        self.picker.sourceType = sourceType;
        [self presentViewController:self.picker animated:YES completion:^{
            
        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    NSLog(@"%@",info);
    //设置头像
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
#pragma warning - 上传头像未实现
    //上传头像到服务器
    
    //设置头像
    _imageView.image = image;
}

@end
