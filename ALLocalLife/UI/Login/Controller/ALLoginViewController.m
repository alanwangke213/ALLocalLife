//
//  ALLoginViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/25.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALLoginViewController.h"
#import "MBProgressHUD.h"
#import "WeiboSDK.h"
//#import "UMSocialSinaSSOHandler.h"
//#import "UMSocial.h"
#import "AppDelegate.h"
//#import "ALSSOManager.h"

#define kTFPadding 20
#define kTFHeight 80 * 0.5
#define kTFWidth kScreenWidth - kTFPadding*2
#define kBtnCount 4

@interface ALLoginViewController ()<UITextFieldDelegate,WBHttpRequestDelegate>
@property (nonatomic ,weak) UIButton *loginBtn;
@property (nonatomic ,weak) UITextField *usernameTF;
@property (nonatomic ,weak) UITextField *passwordTF;
@property (nonatomic ,weak) UILabel *noticeLabel;
@property (nonatomic ,weak) UIButton *keepPassBtn;
@end

@implementation ALLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"登录";
    self.rightButton.hidden = YES;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBlankView)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self addSubviews];
}

-(void)addSubviews{
    
    //usernameTF
    UITextField *usernameTF = [self getBlueTFWithFrame:CGRectMake(kTFPadding, kStatusBarHeight + kNavBarHeight + 24, kTFWidth, kTFHeight) placeHolder:@"新用户"];
    usernameTF.text = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
    usernameTF.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedValue) name:UITextFieldTextDidChangeNotification object:usernameTF];
    usernameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameTF = usernameTF;
    [self.view addSubview:usernameTF];
    
    //noticeLabel
    UILabel *noticeLabel = [self getLabelwithTitle:@"" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor redColor]];
    noticeLabel.frame = CGRectMake(kTFPadding, CGRectGetMaxY(usernameTF.frame) + noticeLabel.frame.size.height * 0.5 + 5, kTFWidth, 14);
    self.noticeLabel = noticeLabel;
    [self.view addSubview:noticeLabel];
    
    //paswordTF
    UITextField *passwordTF = [self getBlueTFWithFrame:CGRectMake(kTFPadding, kStatusBarHeight + kNavBarHeight + 33 + kTFHeight + 15, kTFWidth, kTFHeight) placeHolder:@"6-12位 仅限数字或字母"];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kKeepPassword]) {
        passwordTF.text = [[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
    }
    
    passwordTF.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedValue) name:UITextFieldTextDidChangeNotification object:passwordTF];
    passwordTF.secureTextEntry = YES;
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF = passwordTF;
    [self.view addSubview:passwordTF];
    
    //keepPasswordBtn
    UIButton *keepPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(kTFPadding, CGRectGetMaxY(passwordTF.frame) + 9, 12 * 5, 12)];
    [keepPasswordBtn setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [keepPasswordBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    [keepPasswordBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    [keepPasswordBtn setTitle:@"记住密码" forState:UIControlStateSelected];
    [keepPasswordBtn setTitleColor:[UIColor colorWithRed:109/255. green:198/255. blue:212/255. alpha:1] forState:UIControlStateNormal];
    [keepPasswordBtn setTitleColor:[UIColor colorWithRed:109/255. green:198/255. blue:212/255. alpha:1] forState:UIControlStateSelected];
    keepPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [keepPasswordBtn addTarget:self action:@selector(keepPassword:) forControlEvents:UIControlEventTouchUpInside];
    keepPasswordBtn.adjustsImageWhenHighlighted = NO;
    self.keepPassBtn = keepPasswordBtn;
    [self.view addSubview:keepPasswordBtn];
    
    //forget password button
    UIButton *forgetPasswordBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordTF.frame) - 12 * 5, keepPasswordBtn.frame.origin.y, 12 * 5, keepPasswordBtn.frame.size.height)];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"忘记密码?"];
    NSRange strRange = {0,[str length]};
    //设置下划线
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    //设置颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:109/255. green:198/255. blue:212/255. alpha:1] range:strRange];
    [forgetPasswordBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:forgetPasswordBtn];
    
    //LoginBtn
    UIButton *loginBtn = [self getBlueButtonWithFrame:CGRectMake(kTFPadding, CGRectGetMaxY(keepPasswordBtn.frame) + 15, passwordTF.frame.size.width, passwordTF.frame.size.height) withTitle:@"登录"];
    loginBtn.enabled = NO;
    loginBtn.adjustsImageWhenHighlighted = NO;
    self.loginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(didClickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //redLabel
    UILabel *redLabel = [self getLabelwithTitle:@"还没有账号吗?立即注册" withFont:[UIFont systemFontOfSize:16] withColor:[UIColor colorWithRed:255/255. green:97/255. blue:154/255. alpha:1.]];
    redLabel.center = CGPointMake(kScreenWidth * 0.5, CGRectGetMaxY(loginBtn.frame) + 33 + redLabel.frame.size.height * 0.5);
    
    [self.view addSubview:redLabel];
    
    //blueLabel
    UILabel *blueLabel = [self getLabelwithTitle:@"第三方登录" withFont:[UIFont systemFontOfSize:12] withColor:[UIColor colorWithRed:81/255. green:190/255. blue:249/255. alpha:1.]];
    blueLabel.center = CGPointMake(kScreenWidth * 0.5, CGRectGetMaxY(redLabel.frame) + 30 + blueLabel.frame.size.height * 0.5);
    [self.view addSubview:blueLabel];
    
    //blueLine
    UIView *blueLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(blueLabel.frame) + 15, kScreenWidth - 10 * 2, 0.5)];
    blueLine.backgroundColor = [UIColor colorWithRed:81/255. green:190/255. blue:249/255. alpha:1.];
    [self.view addSubview:blueLine];
    
    //addShareBtn
    for (NSInteger i = 0;  i < kBtnCount; i ++) {
        CGFloat btnH = 45;
        CGFloat btnW = 45;
        CGFloat padding = (kScreenWidth - 50 * 2 - kBtnCount * btnW) / (kBtnCount - 1);
        CGFloat btnX = 50 + i * (btnW + padding);
        CGFloat btnY = CGRectGetMaxY(blueLine.frame) + 18;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"login_%lu",i]] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        btn.tag = i;
        
        if (i == 0) {
            [btn addTarget:self action:@selector(sinaShare) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (i == 1) {
            NSLog(@"微信登录");
        }

        if (i == 2) {
            [btn addTarget:self action:@selector(sinaSSOLogin) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (i == 3) {
            [btn addTarget:self action:@selector(sinaSSOLogout) forControlEvents:UIControlEventTouchUpInside];
            NSLog(@"--->%@",[WeiboSDK getSDKVersion]);
        }
        
        [self.view addSubview:btn];
    }
}

//get Blue UITextFiled
-(UITextField *)getBlueTFWithFrame:(CGRect)rect placeHolder:(NSString *)placeholder{
    UITextField *TF = [[UITextField alloc] initWithFrame:rect];
    TF.backgroundColor = [UIColor colorWithRed:0.404 green:0.765 blue:1.000 alpha:1.000];
    TF.textAlignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:15]
                                 };
    TF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, kTFHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFHeight, kTFHeight)];
    imageView.image = [UIImage imageNamed:@"login_password"];
    imageView.backgroundColor = [UIColor colorWithRed:0.235 green:0.659 blue:0.965 alpha:1.000];
    [leftView addSubview:imageView];
    
    TF.layer.cornerRadius = 5;
    TF.layer.masksToBounds = YES;
    TF.leftView = leftView;
    TF.leftViewMode = UITextFieldViewModeAlways;
    
    return TF;
}

//get Blue Button
-(UIButton *)getBlueButtonWithFrame:(CGRect)rect withTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    btn.titleLabel.text = title;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange strRange = {0,[str length]};
    //设置颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1] range:strRange];
    [btn setAttributedTitle:str forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor colorWithRed:0.235 green:0.659 blue:0.965 alpha:1.000];
    
    return  btn;
}

-(UILabel *)getLabelwithTitle:(NSString *)title withFont:(UIFont *)font withColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = font;
    label.textColor = color;
    [label sizeToFit];
    return label;
}




#pragma mark - UmengSDK 暂未使用
-(void)umengLogin{
    /*---umeng 未使用---*/
        //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        //
        //    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //
        //        //          获取微博用户名、uid、token等
        //
        //        if (response.responseCode == UMSResponseCodeSuccess) {
        //
        //            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
        //
        //            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
        //
        //        }});
}

#pragma mark - SinaWeiBoSDK
-(void)sinaSSOLogin{
//    [[ALSSOManager sharedInstance] weiboSSOLogin];
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiBoRedirectURI;
    request.scope = @"all";
    //仅作为测试
    request.userInfo = @{@"SSO_From": @"ALLoginVc",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"app": @{@"logo": @"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png", @"name": @"SinaWeiBoSDK"}};
    [WeiboSDK sendRequest:request];
    
}

-(void)sinaSSOLogout{
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];

    
}

-(void)sinaShare{
    //    [[ALSSOManager sharedInstance] weiboSSOLogin];
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kWeiBoRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
    
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
        WBImageObject *image = [WBImageObject object];
//        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sinaWeibo.png" ofType:nil]];
    image.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"]];
        message.imageObject = image;

    //
//        WBWebpageObject *webpage = [WBWebpageObject object];
//        webpage.objectID = @"identifier1";
//        webpage.title = NSLocalizedString(@"分享网页标题", nil);
//        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
//        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
//        webpage.webpageUrl = @"http://sina.cn?a=1";
//        message.mediaObject = webpage;

    return message;
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"request: %@",request);
    NSLog(@"response: %@",response);
}


#pragma mark - Login Btn Enable Mode
-(void)textFieldChangedValue{
    if ([self checkUsernamePattern:_usernameTF.text] && [self checkPasswordPattern:_passwordTF.text]) {//格式正确
        _loginBtn.enabled = _usernameTF.text.length && _passwordTF.text.length;
    }
}

#pragma mark - Button Function
-(void)didClickLoginBtn{
    [self.view endEditing:YES];
    
    /* check username and password */
    
    //如果验证成功则将登陆状态保存
    //    if (loginSucced) {
    //        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsLogined];
    //    }
    if (_keepPassBtn.selected) {
        [[NSUserDefaults standardUserDefaults] setValue:_usernameTF.text forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setValue:_passwordTF.text forKey:kPassword];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kKeepPassword];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPassword];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kKeepPassword];
    }
    
    
    [self showLoadViewWithTitle:@"Loading"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideLoadView];
        
        [self showNoticeViewWithTitle:@"登陆失败"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideLoadView];
        });
    });
}

-(void)didClickBlankView{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_usernameTF.text.length) {
        if ([self checkUsernamePattern:_usernameTF.text]){
            self.noticeLabel.text = @"";
        }else{
            self.noticeLabel.text = @"请输入正确的手机或邮箱";
            return;
        }
    }
    if (_passwordTF.text.length) {
        if ([self checkPasswordPattern:_passwordTF.text]) {
            self.noticeLabel.text = @"";
        }else{
            self.noticeLabel.text = @"密码格式不正确";
        }
    }
    
}

-(void)keepPassword:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mark - RegularExpression 正则表达式

-(BOOL)checkUsernamePattern:(NSString *)str{
    
    NSString *phonePattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *emailPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSArray *patternArray = @[phonePattern,emailPattern];
    
    for (NSString *pattern in patternArray) {
        NSRegularExpression *regularExpression = [NSRegularExpression  regularExpressionWithPattern:pattern options:0 error:nil];
        NSArray *resultarray= [regularExpression matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
        if (resultarray.count > 0) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)checkPasswordPattern:(NSString *)str{
    
    NSString *passwordPattern = @"^[A-Za-z0-9]{6,12}$";
    
    NSRegularExpression *regularExpression = [NSRegularExpression  regularExpressionWithPattern:passwordPattern options:0 error:nil];
    NSArray *resultarray= [regularExpression matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    if (resultarray.count > 0) {
        return YES;
    }
    
    return NO;
}

@end
