//
//  ALShopDetail.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/28.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALShopDetailHeader.h"
#import "AppDelegate.h"
#import "WBHttpRequest+WeiboShare.h"
#import "AlanDownLoadIMGManager.h"
#import "ALShopModel.h"

#import "ALShopIntroCell.h"

@interface ALShopDetailHeader ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic ,weak) UIImagePickerController *picker;

@end
@interface ALShopDetailHeader ()

@end

@implementation ALShopDetailHeader

-(void)awakeFromNib{
    
    self.shareBtn.layer.cornerRadius = 5;
    self.shareBtn.layer.masksToBounds = YES;
    
    [self.shareBtn addTarget:self action:@selector(sinaShare) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - sinaSDK + share

//分享
-(void)sinaShare{
    //    [[ALSSOManager sharedInstance] weiboSSOLogin];
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //获取一个*自动释放的*WBBaseRequest对象
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kWeiBoRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"screen_name":@"Praerr",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

//获取message内容
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    
    WBImageObject *image = [WBImageObject object];
    
    //先让shareBtn隐藏再截图
//    self.shareBtn.transform = CGAffineTransformMakeTranslation(200, 0);
    
    image.imageData = UIImagePNGRepresentation([self getScreenShotWithView:self]);
    //取消shareBtn的隐藏状态
//    self.shareBtn.transform = CGAffineTransformIdentity;
    message.imageObject = image;
    
//    WBWebpageObject *webpage = [WBWebpageObject object];
//    webpage.objectID = @"identifier1";
//    webpage.title = NSLocalizedString(@"分享网页标题", nil);
//    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
//    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
//    webpage.webpageUrl = @"http://sina.cn?a=1";
    
//    message.mediaObject = webpage;
    
    return message;
}

-(void)setShopModel:(ALShopModel *)shopModel{
    _shopModel = shopModel;
    
    [[AlanDownLoadIMGManager sharedInstance] downloadIMGWith:shopModel.cover withFinishedBlock:^(UIImage *image) {
        _imageView.image = image;
    }];
    _starLabel.text = [NSString stringWithFormat:@"%ld.0分",_shopModel.score];
    _starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%ld",_shopModel.score]];
    _shopNameLabel.text = _shopModel.name;
    _locationLabel.text = _shopModel.address;
    [_phoneBtn setTitle:_shopModel.phone forState:UIControlStateNormal];
}

-(UIImage *)getScreenShotWithView:(UIView *)view{
    self.shareBtn.hidden = YES;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.bounds.size.width, view.bounds.size.height), NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.shareBtn.hidden = NO;
    return image;
}

//phoneBtn
- (IBAction)didClickPhoneBtn:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_phoneBtn.titleLabel.text]];
    [[UIApplication sharedApplication]openURL:url];
}

@end
