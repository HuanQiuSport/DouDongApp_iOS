//
//  MKChangePersonalizedSignatureVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKChangePersonalizedSignatureVC.h"
#import "MKChangePersonalizedSignatureVC+VM.h"
#define InputLimit 40

@interface MKChangePersonalizedSignatureVC ()
<UITextViewDelegate>

@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UIButton *BackBtn;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)SZTextView *textView;
@property(nonatomic,strong)UILabel *tipsLab;

@property(nonatomic,assign)int inputLimit;
@property(nonatomic,copy)MKDataBlock changePersonalizedSignatureBlock;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation MKChangePersonalizedSignatureVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.inputLimit = InputLimit;
        self.isSave = NO;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.BackBtn];
    self.gk_navTitle = @"修改个性签名";
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    
    self.view.backgroundColor = HEXCOLOR(0xF8f8f8);
    self.gk_navTitleColor = UIColor.blackColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = 1;
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.gk_navBackgroundColor = UIColor.whiteColor;

    
    
    self.backView.alpha = 1;
    self.textView.alpha = 1;
    self.tipsLab.alpha = 1;
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(168);
        make.height.offset(28);
        make.centerX.offset(0);
        make.top.mas_equalTo(self.backView.mas_bottom).offset(84);
    }];
    self.textView.text = self.requestParams;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
#pragma mark - UITextViewDelegate协议中的方法
//将要进入编辑模式
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {return YES;}
//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView {}
//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {return YES;}
//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView {}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {}
//选中textView 或者输入内容的时候调用
- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (textView.text.length > self.inputLimit ){
        textView.text = [textView.text substringToIndex:self.inputLimit];
    }
    _tipsLab.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还可以输入%d个字符",self.inputLimit-(int)textView.text.length] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC" size: 15], NSForegroundColorAttributeName:HEXCOLOR(0x242A37)}];
}
//从键盘上将要输入到textView 的时候调用
//rangge  光标的位置
//text  将要输入的内容
//返回YES 可以输入到textView中  NO不能
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    return YES;
}

-(void)actionChangePersonalizedSignatureBlock:(MKDataBlock)changePersonalizedSignatureBlock{
    self.changePersonalizedSignatureBlock = changePersonalizedSignatureBlock;
}

-(void)giveUpUSave{
    [self backBtnClickEvent:self.BackBtn];
}

-(void)BackBtnClickEvent:(UIButton *)sender{
    //    if (!self.isSave && ![NSString isNullString:self.textView.text] && ) {
    //
    //       }
    if (![self.textView.text isEqualToString:self.requestParams]){
        [NSObject showSYSAlertViewTitle:@"您还没有保存资料"
                                message:@"放弃保存资料？"
                        isSeparateStyle:NO
                            btnTitleArr:@[@"我放弃",@"手滑啦"]
                         alertBtnAction:@[@"giveUpUSave",@""]
                               targetVC:self
                           alertVCBlock:^(id data) {
            //DIY
        }];
    }else{
        [self backBtnClickEvent:sender];
    }
    
}
#pragma mark —— lazyLoad

-(UIButton *)BackBtn{
    if (!_BackBtn) {
        _BackBtn = UIButton.new;
        [_BackBtn setBackgroundImage:KIMG(@"Back")
                            forState:UIControlStateNormal];//backBtnClickEvent
        [_BackBtn addTarget:self
                     action:@selector(BackBtnClickEvent:)
           forControlEvents:UIControlEventTouchUpInside];
    }return _BackBtn;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = UIView.new;
        _backView.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(11);
            make.right.offset(-11);
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(16);
            make.height.mas_equalTo(130);
        }];
        _backView.layer.cornerRadius = 16;
        _backView.layer.masksToBounds = 1;
    }return _backView;
}

-(SZTextView *)textView{
    if (!_textView) {
        _textView = SZTextView.new;
        _textView.backgroundColor = UIColor.whiteColor;
        _textView.delegate = self;
        _textView.placeholderTextColor = HEXCOLOR(0x999999);
        _textView.placeholder = @"填写个性签名更容易获得别人的关注哦";
        _textView.textColor = UIColor.blackColor;
        _textView.font = [UIFont systemFontOfSize:15];
        [self.backView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(8);
            make.right.bottom.offset(-8);
        }];
    }return _textView;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.textColor = HEXCOLOR(0x999999);//
        _tipsLab.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还可以输入%d个字符",self.inputLimit]
                                                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC" size: 15],
                                                                                      NSForegroundColorAttributeName:HEXCOLOR(0x999999)}];
        [self.backView addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-19);
            make.height.offset(21);
            make.bottom.offset(-8);
        }];
        _tipsLab.textAlignment = NSTextAlignmentRight;
    }return _tipsLab;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _sureBtn.layer.cornerRadius = 14;
        _sureBtn.layer.masksToBounds = 1;
        [_sureBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.changePersonalizedSignatureBlock(self.textView);
//            if (![NSString isNullString:self.textView.text]) {
//                if (self.changePersonalizedSignatureBlock) {
//
//                }
//            }else{
//                [MBProgressHUD wj_showPlainText:@"总的写点什么吧"
//                                           view:nil];
//            }
        }];
    }
    return _sureBtn;
}
@end
