//
//  MKChangeNickNameVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBindingTelVC.h"
#import "MKBindingTelVC+VM.h"

@interface MKBindingTelVC ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UIView *backView;
@property(strong,nonatomic)UIButton *mkClearButton;// 清除按钮
@property(nonatomic,strong)UIView *verCodeView;
@property(nonatomic,strong)UILabel *iphoneLabel;
@property(nonatomic,strong)UILabel *verCodeLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *lineLabel2;
@property(nonatomic,strong)UILabel *codeVerLabelA;
@property(nonatomic,strong)UIButton *countDownBtn;//获取验证码
@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,copy)MKDataBlock changeNickNameBlock;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;


@end

@implementation MKBindingTelVC

#pragma mark - # Life Cycle
- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKBindingTelVC *vc = MKBindingTelVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    vc.nickName = (NSString *)requestParams[@"nikcName"];
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.isSave = NO;
    }return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.iphoneLabel];
    [self.view addSubview:self.verCodeLabel];
    [self.backView addSubview:self.lineLabel];
    [self.view addSubview:self.verCodeView];
    [self.view addSubview:self.lineLabel2];
    [self.verCodeView addSubview:self.verCodeTextFeild];
    [self.view addSubview:self.countDownBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xF8F8F8);
    self.gk_navTitleColor = UIColor.blackColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = 1;
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.gk_navBackgroundColor = UIColor.whiteColor;
    self.gk_navTitle = @"绑定手机号";
    
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    [self.view addSubview:self.backView];
    [self mkAddSubView];
    [self mkLayOutView];
    [self.textField becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    [self.countDownBtn timerDestroy];
}
#pragma mark - 添加子视图
- (void)mkAddSubView {
    [self.backView addSubview:self.textField];
    [self.backView addSubview:self.mkClearButton];
    [self.view addSubview:self.saveBtn];
}
#pragma mark - 布局子视图
#pragma mark - # Private Methods
-(void)mkLayOutView {
    
    [self.iphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*SCREEN_W/375);
        if (iPhoneX | iPhoneScreen_XR | iPhoneScreen_X_XS | iPhoneScreen_XSMAX) {
             make.top.mas_equalTo(30+88);
        } else {
            make.top.mas_equalTo(30+64);
        }
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.offset(0);
          make.left.mas_equalTo(10*SCREEN_W/375);
          make.height.offset(44);
          make.top.mas_equalTo(self.iphoneLabel.mas_bottom).offset(13);
      }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(14*SCREEN_W/375);
           make.top.bottom.offset(0);
           make.right.offset(-20*SCREEN_W/375);
       }];
    
    [self.verCodeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iphoneLabel.mas_left);
        make.top.equalTo(self.backView.mas_bottom).offset(30);

    }];
    [self.verCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.offset(0);
          make.left.mas_equalTo(10*SCREEN_W/375);
          make.height.offset(30);
          make.top.equalTo(self.verCodeLabel.mas_bottom).offset(13);
    }];
    [self.verCodeTextFeild mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14*SCREEN_W/375);
        make.top.bottom.offset(0);
        make.right.offset(-120*SCREEN_W/375);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.textField.mas_left);
           make.bottom.mas_equalTo(0);
           make.height.mas_equalTo(1);
         make.right.offset(-20*SCREEN_W/375);
       }];
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verCodeTextFeild.mas_bottom).offset(10);
        make.left.mas_equalTo(self.verCodeTextFeild.mas_left);
        make.height.mas_equalTo(1);
         make.right.offset(-20*SCREEN_W/375);
      }];
   
    [self.verCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iphoneLabel.mas_left);
        make.top.equalTo(self.backView.mas_bottom).offset(30);
        
       }];
    [self.mkClearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.height.offset(44);
        make.centerY.offset(0);
    }];
    
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.verCodeView.mas_centerY);
        make.right.offset(-24*SCREEN_W/375);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(20);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SCALING_RATIO(168));
        make.centerX.offset(0);
        make.top.mas_equalTo(self.backView.mas_bottom).offset(124);
        make.height.offset(32);
    }];
}
#pragma mark —— UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if([MKTools isContainsTwoEmoji:string]) {
        [MBProgressHUD wj_showPlainText:@"不可以输入表情"
                                   view:nil];
        return NO;
    }return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
#pragma mark —— lazyLoad
-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = UIButton.new;
        [_saveBtn setBackgroundImage:KIMG(@"gradualColor")
                            forState:UIControlStateNormal];  ;
        [_saveBtn setTitle:@"确认"
                  forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _saveBtn.layer.cornerRadius = 14;
        _saveBtn.layer.masksToBounds = YES;
        @weakify(self)
        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![NSString isNullString:self.textField.text]) {
#pragma mark - 昵称过滤 昵称输入框可输入范围为4-16个字符。低于4个字符，点击“确认”按钮时，显示Tips提示“不低于4个字符”。超过16个字符时，不可再进行输入； 来自UI图
                NSInteger strCout = [MKTools mkCountCharNumber:self.textField.text];
                if(strCout < 4){
                    [MBProgressHUD wj_showPlainText:@"不低于4个字符" view:nil];
                    return;
                }
                if(strCout > 16){
                    [MBProgressHUD wj_showPlainText:@"超过16个字符" view:nil];
                    return;
                }
                [self uploadDataRequest];
            }else{
                [MBProgressHUD wj_showPlainText:@"请输入手机号" view:nil];
            }
        }];
    }return _saveBtn;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = UITextField.new;
        _textField.textColor = UIColor.blackColor;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.returnKeyType = UIReturnKeyDone;
//        _textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
        _textField.delegate = self;
        _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]}];
    }return _textField;
}

-(UIButton *)mkClearButton {
    if (!_mkClearButton) {
        _mkClearButton = [[UIButton alloc]init];
        [_mkClearButton setImage:KIMG(@"clearbutton") forState:UIControlStateNormal];
        [_mkClearButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        @weakify(self)
        [[_mkClearButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
             self.textField.text = @"";
        }];
    }return _mkClearButton;
}

-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                               runType:CountDownBtnRunType_manual
                                      layerBorderWidth:0
                                     layerCornerRadius:6
                                      layerBorderColor:nil
                                            titleColor:[UIColor colorWithPatternImage:KIMG(@"gradualColor")]
                                         titleBeginStr:@"获取验证码"
                                        titleLabelFont:[UIFont systemFontOfSize:14
                                                                         weight:UIFontWeightRegular]];
        _countDownBtn.titleRuningStr = @"重新发送";
        _countDownBtn.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;
        _countDownBtn.titleLabel.numberOfLines = 0;
        _countDownBtn.titleEndStr = @"重新发送";
        _countDownBtn.backgroundColor = kClearColor;
        _countDownBtn.bgCountDownColor = kClearColor;//倒计时的时候此btn的背景色
        _countDownBtn.bgEndColor = kClearColor;//倒计时完全结束后的背景色
        _countDownBtn.showTimeType = ShowTimeType_SS;
        _countDownBtn.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        @weakify(self)
        [_countDownBtn actionCountDownClickEventBlock:^(id data) {
            @strongify(self)
            if (self.textField.text.length != 0 &&
                [MKBindingTelVC checkTelNumber:self.textField.text] == YES) {
                [self pushRequestMessage];
                [self.countDownBtn timeFailBeginFrom:60];
            }else{
              [MBProgressHUD wj_showPlainText:@"请输入正确的手机号" view:self.view];
            }
        }];
        [self.view addSubview:_countDownBtn];
    }return _countDownBtn;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = UIView.new;
        _backView.backgroundColor = [UIColor clearColor];
    }return _backView;
}

- (UILabel *)iphoneLabel {
    if (!_iphoneLabel) {
        _iphoneLabel = [[UILabel alloc] init];
        _iphoneLabel.text = @"手机号码";
        _iphoneLabel.textColor  = [UIColor blackColor];
        _iphoneLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
    }return _iphoneLabel;
}

- (UILabel *)verCodeLabel {
    if (!_verCodeLabel) {
        _verCodeLabel = [[UILabel alloc] init];
        _verCodeLabel.text = @"验证码";
        _verCodeLabel.textColor  = [UIColor blackColor];
        _verCodeLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    }return _verCodeLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = COLOR_HEX(0xA2A2A2, 0.2);
    }return _lineLabel;
}

- (UILabel *)lineLabel2 {
    if (!_lineLabel2) {
        _lineLabel2 = [[UILabel alloc] init];
        _lineLabel2.backgroundColor = COLOR_HEX(0xA2A2A2, 0.2);
    }return _lineLabel2;
}

- (UITextField *)verCodeTextFeild {
    if (!_verCodeTextFeild) {
        _verCodeTextFeild = [[UITextField alloc] init];
        _verCodeTextFeild.textColor = UIColor.blackColor;
        _verCodeTextFeild.keyboardType=UIKeyboardTypeNumberPad;
        _verCodeTextFeild.delegate = self;
        _verCodeTextFeild.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
        _verCodeTextFeild.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码"
                                                                                 attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                                                                              NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]}];
        [_verCodeTextFeild setDelegate:self];
    }return _verCodeTextFeild;
}

- (UIView *)verCodeView {
    if (!_verCodeView) {
        _verCodeView = [UIView new];
        _verCodeView.backgroundColor = [UIColor clearColor];
    }return _verCodeView;
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

@end
