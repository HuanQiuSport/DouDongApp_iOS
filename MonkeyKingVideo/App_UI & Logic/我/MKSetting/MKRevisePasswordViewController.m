//
//  MKRevisePasswordViewController.m
//  MonkeyKingVideo
//
//  Created by blank blank on 2020/9/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKRevisePasswordViewController.h"
#import "MKRevisePasswordViewController+VM.h"
@interface MKRevisePasswordViewController ()
@property (nonatomic, strong) UITextField *oldField;
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UITextField *confirmNewField;
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation MKRevisePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    self.gk_navTitleColor = kWhiteColor;
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navTitle = @"修改密码";
    self.gk_navLineHidden = YES;
    [self initUI];
    [self refreshSkin];
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.view.backgroundColor = UIColor.whiteColor;
        self.gk_navTitleColor = UIColor.blackColor;
        self.gk_backStyle = GKNavigationBarBackStyleBlack;
    } else {
        self.view.backgroundColor = kBlackColor;
        self.gk_navTitleColor = kWhiteColor;
        self.gk_backStyle = GKNavigationBarBackStyleWhite;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)initUI {
    
    UIColor *labColor = UIColor.whiteColor;
    UIColor *lineColor = HEXCOLOR(0x4C525F);
    UIColor *filedColor = UIColor.whiteColor;
    UIColor *filedHolderColor = HEXCOLOR(0x4C525F);
    UIColor *topLineViewColor = UIColor.clearColor;
    if ([SkinManager manager].skin == MKSkinWhite) {
        labColor = UIColor.blackColor;
        lineColor = COLOR_HEX(0xA2A2A2,0.2);
        filedColor = UIColor.blackColor;
        filedHolderColor = HEXCOLOR(0x999999);
        topLineViewColor = COLOR_HEX(0xA2A2A2,0.2);
    }
    NSArray *titles = @[@"原密码",@"新密码",@"确认新密码"];
    NSArray *placeholders = @[@"请输入原密码",@"请输入6-12位字母或数字的组合密码",@"请再次输入密码"];
    UIView *topLineView = UIView.new;
    [self.view addSubview:topLineView];
    topLineView.backgroundColor = topLineViewColor;
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(self.gk_navigationBar.mas_bottom).offset(0);
    }];
    for (int i = 0; i < titles.count; i++) {
        UILabel *lab = UILabel.new;
        [self.view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.height.offset(21);
            make.top.mas_equalTo(self.gk_navigationBar.mas_bottom).offset(20 + i *(21+82));
        }];
        lab.text = titles[i];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = labColor;
        UITextField *field = UITextField.new;
        [self.view addSubview:field];
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.height.offset(24+9*2);
            make.top.mas_equalTo(lab.mas_bottom).offset(17-9);
            make.right.offset(-20);
        }];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:placeholders[i] attributes:
           @{NSForegroundColorAttributeName:filedHolderColor,
             NSFontAttributeName:[UIFont systemFontOfSize:17]}
           ];
        field.attributedPlaceholder = attrString;
        
        field.textColor = filedColor;
        field.font = [UIFont systemFontOfSize:17];
        
        [field addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
        
        if (i == 0) {
            self.oldField = field;
        } else if (i == 1) {
            self.field = field;
        } else {
            self.confirmNewField = field;
        }
        UIView *line = UIView.new;
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.height.offset(1);
            make.top.mas_equalTo(field.mas_bottom).offset(0);
        }];
        line.backgroundColor = lineColor;
    }
    UIButton *btn = UIButton.new;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(192);
        make.height.offset(32);
        make.centerX.offset(0);
        make.top.mas_equalTo(self.confirmNewField.mas_bottom).offset(26);
    }];
    [btn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.cornerRadius = 16;
    btn.layer.masksToBounds = 1;
    btn.enabled = NO;
    btn.alpha = 0.7;
    self.submitBtn = btn;
    @weakify(self)
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (!self.oldField.text.length) {
            
            [WHToast showMessage:@"请输入原密码"
                        duration:1
                   finishHandler:nil];
            
            return;
        }
        if (!self.field.text.length) {

            [WHToast showMessage:@"请输入新密码"
                        duration:1
                   finishHandler:nil];
            
            return;
        }
        if (!self.confirmNewField.text.length) {

            [WHToast showMessage:@"请再次输入密码"
                        duration:1
                   finishHandler:nil];
            
            return;
        }
        if (![self.confirmNewField.text isEqualToString:self.field.text]) {
            
            [WHToast showMessage:@"两次密码输入不一致"
                        duration:1
                   finishHandler:nil];
            
            
            return;
        }
        if (self.field.text.length < 6) {

            [WHToast showMessage:@"密码至少6位"
                        duration:1
                   finishHandler:nil];
            
            return;
        }
        if (self.field.text.length > 12) {
            
            [WHToast showMessage:@"密码不能超过12位"
                        duration:1
                   finishHandler:nil];
            
            return;
        }
        [self resetPasswordWith:self.oldField.text newPassword:self.field.text confirmPassword:self.confirmNewField.text data:^(id data) {
        }];
    }];
}

- (void)textFieldDidChange:(UITextField *)textField {
    bool enable = (self.oldField.text.length >= 6 && self.confirmNewField.text.length >= 6 && self.field.text.length >= 6) ? YES : NO;
    self.submitBtn.enabled = enable;
    self.submitBtn.alpha =  self.submitBtn.enabled ? 1 : 0.7;
}

#pragma mark - getter
- (UITextField *)oldField {
    if (!_oldField) {
        _oldField = UITextField.new;

    }
    return _oldField;
}

- (UITextField *)field {
    if (!_field) {
        _field = UITextField.new;
    }
    return _field;
}

- (UITextField *)confirmNewField {
    if (!_confirmNewField) {
        _confirmNewField = UITextField.new;
    }
    return _confirmNewField;
}
@end
