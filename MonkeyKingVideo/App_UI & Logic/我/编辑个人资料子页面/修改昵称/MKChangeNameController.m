//
//  MKChangeNameController.m
//  MonkeyKingVideo
//
//  Created by Mose on 2020/9/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKChangeNameController.h"
#import "MKChangeNameController+VM.h"

@interface MKChangeNameController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,copy)MKDataBlock changeNickNameBlock;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)UIButton *mkClearButton;

@end

@implementation MKChangeNameController

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+(instancetype)ComingFromVC:(UIViewController *)rootVC
                comingStyle:(ComingStyle)comingStyle
          presentationStyle:(UIModalPresentationStyle)presentationStyle
              requestParams:(nullable id)requestParams
                    success:(MKDataBlock)block
                   animated:(BOOL)animated{
    MKChangeNameController *vc = MKChangeNameController.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    vc.nickName = (NSString *)requestParams[@"nikcName"];
    vc.textField.text = vc.nickName;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0x242a37);
    self.gk_navTitleColor = kWhiteColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = 1;
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navTitle = @"修改昵称";
    
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    [self.view addSubview:self.backView];
    [self mkAddSubView];
    [self mkLayOutView];
    [self.textField becomeFirstResponder];
}
#pragma mark - 添加子视图
- (void)mkAddSubView {
    [self.backView addSubview:self.textField];
    [self.backView addSubview:self.mkClearButton];
    [self.view addSubview:self.saveBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
#pragma mark - 布局子视图
#pragma mark - # Private Methods
-(void)mkLayOutView {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.left.mas_equalTo(0);
        make.height.offset(44);
        if (iPhoneScreen_XR |
            iPhoneScreen_X_XS |
            iPhoneScreen_XSMAX |
            iPhoneX) {
            make.top.mas_equalTo(13+88);
        } else {
            make.top.mas_equalTo(13+64);
        }
      }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(14*SCREEN_W/375);
           make.top.bottom.offset(0);
           make.right.offset(-20*SCREEN_W/375);
    }];
    [self.mkClearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.height.offset(44);
        make.centerY.offset(0);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SCALING_RATIO(168));
        make.centerX.offset(0);
        make.top.mas_equalTo(self.backView.mas_bottom).offset(24);
        make.height.offset(32);
    }];
}

-(void)actionChangeNickNameBlock:(MKDataBlock)changeNickNameBlock{
    self.changeNickNameBlock = changeNickNameBlock;
}
#pragma mark —— UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if([MKTools isContainsTwoEmoji:string]) {
        [MBProgressHUD wj_showPlainText:@"不可以输入表情" view:nil];
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
        [_saveBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];  ;
        [_saveBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
                if (self.changeNickNameBlock) {
                    self.changeNickNameBlock(self.textField);
                }
            }else{
                [MBProgressHUD wj_showPlainText:@"总的写点什么吧" view:nil];
            }
        }];
    }return _saveBtn;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = UITextField.new;
        _textField.textColor = UIColor.whiteColor;
        _textField.returnKeyType = UIReturnKeySend;
        _textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
        _textField.delegate = self;
        _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入新的昵称"
                                                                          attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                                                                       NSForegroundColorAttributeName:[UIColor colorWithHexString:@"4C525F"]}];
    }return _textField;
}

- (UIButton *)mkClearButton {
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

- (UIView *)backView {
    if (!_backView) {
        _backView = UIView.new;
        _backView.backgroundColor = HEXCOLOR(0x212632);
    }return _backView;
}

@end
