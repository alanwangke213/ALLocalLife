//
//  ALLoginViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/25.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define kTFPadding 20
#define kTFHeight 80 * 0.5
#define kTFWidth kScreenWidth - kTFPadding*2
#define kBtnCount 4
@interface ALLoginViewController ()<UITextFieldDelegate>
@property(nonatomic ,weak) UIButton *loginBtn;
@property(nonatomic ,weak) UITextField *usernameTF;
@property(nonatomic ,weak) UITextField *passwordTF;
@property (nonatomic ,weak) UILabel *noticeLabel;
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
    usernameTF.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedValue) name:UITextFieldTextDidChangeNotification object:usernameTF];
    self.usernameTF = usernameTF;
    [self.view addSubview:usernameTF];
    
    //noticeLabel
    UILabel *noticeLabel = [self getLabelwithTitle:@"" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor redColor]];
    noticeLabel.frame = CGRectMake(kTFPadding, CGRectGetMaxY(usernameTF.frame) + noticeLabel.frame.size.height * 0.5, kTFWidth, 14);
    self.noticeLabel = noticeLabel;
    [self.view addSubview:noticeLabel];
    
    //paswordTF
    UITextField *passwordTF = [self getBlueTFWithFrame:CGRectMake(kTFPadding, kStatusBarHeight + kNavBarHeight + 33 + kTFHeight + 15, kTFWidth, kTFHeight) placeHolder:@"6-12位 仅限数字或字母"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedValue) name:UITextFieldTextDidChangeNotification object:passwordTF];
    self.passwordTF = passwordTF;
    [self.view addSubview:passwordTF];
    
    //keepPasswordBtn
    UIButton *keepPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(kTFPadding, CGRectGetMaxY(passwordTF.frame) + 9, 12, 12)];
    [keepPasswordBtn setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [keepPasswordBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
#pragma mark - warning -
    [keepPasswordBtn addTarget:self action:@selector(keepPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keepPasswordBtn];
    
    //keep password label
    UILabel *keepLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(keepPasswordBtn.frame) + 5, keepPasswordBtn.frame.origin.y, 12 * 5, 12)];
    keepLabel.font = [UIFont systemFontOfSize:12];
    keepLabel.textColor = [UIColor colorWithRed:109/255. green:198/255. blue:212/255. alpha:1];
    keepLabel.text = @"记住密码";
    [self.view addSubview:keepLabel];
    
    //forget password button
    UIButton *forgetPasswordBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(passwordTF.frame) - 12 * 5, keepLabel.frame.origin.y, 12 * 5, keepLabel.frame.size.height)];
    
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
    UIButton *loginBtn = [self getBlueButtonWithFrame:CGRectMake(kTFPadding, CGRectGetMaxY(keepLabel.frame) + 15, passwordTF.frame.size.width, passwordTF.frame.size.height) withTitle:@"登录"];
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
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"login_%ld",i]] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        btn.tag = i;
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

//get Blue UITextFiled
-(UITextField *)getBlueTFWithFrame:(CGRect)rect placeHolder:(NSString *)placeholder{
    UITextField *TF = [[UITextField alloc] initWithFrame:rect];
    TF.backgroundColor = [UIColor colorWithRed:0.404 green:0.765 blue:1.000 alpha:1.000];
    TF.textAlignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:14]
                                 };
    TF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, kTFHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFHeight, kTFHeight)];
    imageView.image = [UIImage imageNamed:@"login_password"];
    imageView.backgroundColor = [UIColor colorWithRed:0.235 green:0.659 blue:0.965 alpha:1.000];
    [leftView addSubview:imageView];
    
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

#pragma mark - shareSDK
-(void)share:(UIButton *)sender{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:[NSString stringWithFormat:@"login_%ld",sender.tag]]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                   }];
    }

}


-(void)textFieldChangedValue{
    _loginBtn.enabled = _usernameTF.text.length && _passwordTF.text.length;
}

-(void)didClickLoginBtn{
    [self.view endEditing:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsLogined];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hasLogined" object:@YES];
    
    NSLog(@"Login");
}

-(void)didClickBlankView{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *str = textField.text;
    
    if ([self checkPattern:str]){
        self.noticeLabel.text = @"格式正确";
        self.noticeLabel.textColor = [UIColor greenColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.noticeLabel.text = @"";
        });
    }else{
        self.noticeLabel.text = @"格式不正确";
    }
}


-(BOOL)checkPattern:(NSString *)str{
    
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

@end
