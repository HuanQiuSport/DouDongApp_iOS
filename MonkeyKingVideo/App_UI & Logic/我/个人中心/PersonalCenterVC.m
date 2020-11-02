//
//  PersonalCenterVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "ProductionVC.h"
#import "LikedVC.h"
#import "PersonalCenterVC+VM.h"
#import "MKPersonalnfoModel.h"
#import "MKAttentionVC.h"

#import "MKPersonView.h"
@interface TipsV ()

@property(nonatomic,strong)UILabel *showNumberLab;
@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation TipsV

-(instancetype)initWithTitle:(NSString *)titleStr
                  showNumber:(NSString *)showNumberStr{
    if (self = [super init]) {
        self.showNumberLab.text = showNumberStr;
        self.titleLab.text = titleStr;
    }return self;;
}

#pragma mark —— lazyLoad
-(UILabel *)showNumberLab{
    if (!_showNumberLab) {
        _showNumberLab = UILabel.new;
        _showNumberLab.textColor = kWhiteColor;
        _showNumberLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_showNumberLab];
        [_showNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
        }];
    }return _showNumberLab;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = kWhiteColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.showNumberLab.mas_bottom).offset(SCALING_RATIO(5));
        }];
    }return _titleLab;
}

@end

@interface PersonalCenterVC ()
<
JXCategoryTitleViewDataSource
,JXCategoryListContainerViewDelegate
,JXCategoryViewDelegate
>

@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;

@property(nonatomic,strong)FSCustomButton *header_nameBtn;
@property(nonatomic,strong)UIButton *rightBarBtn;
@property(nonatomic,strong)UIButton *attentionBtn;
@property(nonatomic,strong)UILabel *sex_oldLab;
@property(nonatomic,strong)UILabel *provincelab;
@property(nonatomic,strong)UILabel *constellationLab;
@property(nonatomic,strong)UILabel *personalizedSignatureLab;
@property(nonatomic,strong)TipsV *tipsV_attention;
@property(nonatomic,strong)TipsV *tipsV_fans;
@property(nonatomic,strong)TipsV *tipsV_like;

@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
/// 进入页面属性
@property (assign,nonatomic) MKGoToPersonalType mkGoToPersonalType;


/// ProductionVC
@property (strong,nonatomic) ProductionVC *mkProductVC;
/// LikedVC
@property (strong,nonatomic) LikedVC *mkLikedVC;

/// PersonView
@property (strong,nonatomic) MKPersonView *mkPersonView;
@end

@implementation PersonalCenterVC

//@synthesize backBtn = _backBtn;

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    PersonalCenterVC *vc = PersonalCenterVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    NSNumber *b = (NSNumber *)vc.requestParams[@"MKGoToPersonalType"];
    vc.mkGoToPersonalType = b.intValue;
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
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0x333333);
    self.mkPersonView.alpha = 1;
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarBtn];
    self.gk_navTitle = @"";
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    
//    self.header_nameBtn.alpha = 1;
    self.attentionBtn.alpha = 1;
    self.sex_oldLab.alpha = 1;
    self.provincelab.alpha = 1;
    self.constellationLab.alpha = 1;
    self.personalizedSignatureLab.alpha = 1;
    self.tipsV_attention.alpha = 1;
    self.tipsV_fans.alpha = 1;
    self.tipsV_like.alpha = 1;
    
//    self.categoryView.alpha = 1;
    self.navigationController.navigationBar.hidden = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;

    self.mkPersonView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    WeakSelf
    [self getDataUserData:self.requestParams[@"videoid"] Block:^(id data) {
        if ((Boolean)data) {
            NSLog(@"数据请求成功");
            NSLog(@"%@",weakSelf.mkPernalModel);
             weakSelf.categoryView.alpha = 1;
            [weakSelf MKaddValue];
        }else{
            weakSelf.categoryView.alpha = 1;
            NSLog(@"数据请求失败");
        }
    }];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

- (void)MKaddValue{
    
    if([self.mkPernalModel.attention isEqualToString:@"1"]){
        
        self.attentionBtn.selected = YES;
        
//        self.attentionBtn.enabled = NO;
    }else{
        self.attentionBtn.selected = NO;
        
//        self.attentionBtn.enabled = YES;
    }
    self.header_nameBtn.hidden = YES;
    
    [self.mkPersonView.mkUserImageView sd_setImageWithURL:[NSURL URLWithString:self.mkPernalModel.headImage]];
    
    self.mkPersonView.mkUserLabel.text = [NSString stringWithFormat:@"@%@",self.mkPernalModel.nickName?self.mkPernalModel.nickName : @"抖动用户"];
    
//    [self.header_nameBtn sd_setImageWithURL:[NSURL URLWithString:self.mkPernalModel.headImage]
//                                   forState:UIControlStateNormal
//                           placeholderImage:KIMG(@"用户头像（大）")];
//
//    [self.header_nameBtn setTitle:[NSString stringWithFormat:@"%@",self.mkPernalModel.nickName] forState:UIControlStateNormal];
//
    self.sex_oldLab.text = [NSString stringWithFormat:@"%@ %@",self.mkPernalModel.sex.boolValue ? @"女" : @"男",[[NSString ensureNonnullString:self.mkPernalModel.age ReplaceStr:@"18"] stringByAppendingString:@"岁"]];
    
    self.provincelab.text = [NSString ensureNonnullString:self.mkPernalModel.area ReplaceStr:@"浙江省"];
    
    self.constellationLab.text = [NSString ensureNonnullString:self.mkPernalModel.constellation ReplaceStr:@"狮子座"];
    
    self.personalizedSignatureLab.text = [NSString ensureNonnullString:self.mkPernalModel.remark ReplaceStr:@"这人很懒，没有签名哦"];
    
    self.tipsV_fans.showNumberLab.text = [NSString ensureNonnullString:self.mkPernalModel.fansNum ReplaceStr:@"0"];
    
    self.tipsV_attention.showNumberLab.text = [NSString ensureNonnullString:self.mkPernalModel.focusNum ReplaceStr:@"0"];
    
    self.tipsV_like.showNumberLab.text = [NSString ensureNonnullString:self.mkPernalModel.praiseNum ReplaceStr:@"0"];
    
    self.mkProductVC.mkPernalModel = self.mkPernalModel;
    
    self.mkLikedVC.mkPernalModel = self.mkPernalModel;
    
    [self.mkLikedVC requestData];
    
    [self.mkProductVC requestData];
    
}

#pragma mark —— 点击事件
-(void)rightBarBtnClickEvent:(UIButton *)sender{
    [NSObject showSYSActionSheetTitle:nil
                              message:nil
                      isSeparateStyle:YES
                          btnTitleArr:@[@"分享",@"举报",@"拉黑",@"取消"]
                       alertBtnAction:@[@"share",@"report",@"blacklist",@"cancel"]
                             targetVC:self
                               sender:sender
                         alertVCBlock:^(id data) {
        //DIY
    }];
}
#pragma mark - 分享
-(void)share{
    
}
#pragma mark - 举报
-(void)report{
    
}
#pragma mark - 黑名单
-(void)blacklist{
    [self requestAddBlackListWith:self.mkPernalModel.id WithBlock:^(id data) {
        if ((Boolean)data) {
            [MBProgressHUD wj_showSuccess:@"加入黑名单成功"];
        }else{
            [MBProgressHUD wj_showSuccess:@"加入黑名单失败"];
        }
    }];
}
#pragma mark - 取消
-(void)cancel{
    
}

-(void)header_nameBtnClickEvent:(UIButton *)sender{
    
}
#pragma mark - 关注
-(void)attentionBtnClickEvent:(UIButton *)sender{
    if([self.mkPernalModel.areSelf isEqualToString:@"1"]){
        [MBProgressHUD wj_showError:@"用户不能对自己进行关注"];
        return;
    }
    
    @weakify(self)
    if ([MKTools mkLoginIsYESWith:weak_self]) {
        if (!sender.selected) {
            //关注
            [self requestAttentionWith:self.mkPernalModel.id
                                         WithBlock:^(id data) {
                if((Boolean)data){
                    sender.selected = !sender.selected;
                }
            }];
        }else{
            //取消关注
            [weak_self requestDeleteAttentionWith:weak_self.mkPernalModel.userId
                                       WithBlock:^(id data) {
                if((Boolean)data){
                    sender.selected = !sender.selected;
                }
            }];
        }
    }else{}
}
#pragma mark JXCategoryTitleViewDataSource
//// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
//// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
//- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView
//               widthForTitle:(NSString *)title{
//
//    return 10;
//}

#pragma mark JXCategoryListContainerViewDelegate
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titleMutArr.count;
}

/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                          initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}

#pragma mark JXCategoryViewDelegate
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}

#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)titleMutArr{
    
    if (!_titleMutArr) {
        
        _titleMutArr = NSMutableArray.array;
        
        [_titleMutArr addObject:[NSString stringWithFormat:@"作品 %@",[NSString ensureNonnullString:self.mkPernalModel.publicVideoNum ReplaceStr:@"3"]]];
        
        [_titleMutArr addObject:[NSString stringWithFormat:@"喜欢 %@",[NSString ensureNonnullString:self.mkPernalModel.videoPraiseNum ReplaceStr:@"4"]]];
    }
    return _titleMutArr;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [self.childVCMutArr addObject:self.mkProductVC];
        [self.childVCMutArr addObject:self.mkLikedVC];
    }return _childVCMutArr;
}

-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView
                                                                      delegate:self];
        _listContainerView.defaultSelectedIndex = 0;
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.tipsV_attention.mas_bottom).offset(SCALING_RATIO(10));
        }];
        [self.view layoutIfNeeded];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = kWhiteColor;
    }return _lineView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = HEXCOLOR(0x333333);
        _categoryView.titleSelectedColor = kWhiteColor;
        _categoryView.titleColor = kWhiteColor;
        _categoryView.titleFont = [UIFont systemFontOfSize:13];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:15];
        _categoryView.delegate = self;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[self.lineView];
        _categoryView.defaultSelectedIndex = 0;
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(KDeviceScale * 50));
            make.top.equalTo(self.listContainerView);
        }];
    }return _categoryView;
}

-(UIButton *)rightBarBtn{
    if (!_rightBarBtn) {
        _rightBarBtn = UIButton.new;
        [_rightBarBtn setBackgroundImage:KIMG(@"省略号")
                                forState:UIControlStateNormal];
        [_rightBarBtn addTarget:self
                         action:@selector(rightBarBtnClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    }return _rightBarBtn;
}

-(FSCustomButton *)header_nameBtn{
    if (!_header_nameBtn) {
        _header_nameBtn = FSCustomButton.new;
        _header_nameBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_header_nameBtn addTarget:self
                            action:@selector(header_nameBtnClickEvent:)
                  forControlEvents:UIControlEventTouchUpInside];
        [_header_nameBtn setTitle:@"@用户昵称"
                         forState:UIControlStateNormal];
        [_header_nameBtn setTitleColor:kBlackColor
                              forState:UIControlStateNormal];
        [_header_nameBtn sd_setImageWithURL:[NSURL URLWithString:@""]
                                   forState:UIControlStateNormal
                           placeholderImage:KIMG(@"用户头像")];
        _header_nameBtn.titleEdgeInsets = UIEdgeInsetsMake(SCALING_RATIO(0),
                                                           0,
                                                           0,
                                                           0);
        _header_nameBtn.imageEdgeInsets = UIEdgeInsetsMake(SCALING_RATIO(-50),
                                                           0,
                                                           0,
                                                           0);
        [self.view addSubview:_header_nameBtn];
        [_header_nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(SCALING_RATIO(15));
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(SCALING_RATIO(3));
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(100), SCALING_RATIO(150)));
        }];
    }return _header_nameBtn;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        [_attentionBtn setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x0979FE)] forState:UIControlStateNormal] ;
        [_attentionBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected] ;
        [_attentionBtn setTitle:@"关注"
                       forState:UIControlStateNormal];
        [_attentionBtn setTitle:@"已关注"
                       forState:UIControlStateSelected];
        [_attentionBtn addTarget:self
                          action:@selector(attentionBtnClickEvent:)
                forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.header_nameBtn.mas_right).offset(SCALING_RATIO(15));
            make.right.equalTo(self.view.mas_right).offset(SCALING_RATIO(-15));
            make.top.equalTo(self.header_nameBtn);
        }];
        [UIView cornerCutToCircleWithView:_attentionBtn
                          AndCornerRadius:6.f];
        [self.view layoutIfNeeded];
    }return _attentionBtn;
}

-(UILabel *)sex_oldLab{
    if (!_sex_oldLab) {
        _sex_oldLab = UILabel.new;
        _sex_oldLab.backgroundColor = HEXCOLOR(0xF2F2F2);
        _sex_oldLab.textColor = kBlackColor;
        _sex_oldLab.textAlignment = NSTextAlignmentCenter;
        _sex_oldLab.text = @"女 28";
        [self.view addSubview:_sex_oldLab];
        [_sex_oldLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.attentionBtn);
            make.top.equalTo(self.attentionBtn.mas_bottom).offset(SCALING_RATIO(15));
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.attentionBtn.frame) / 3 - SCALING_RATIO(7) * 2, CGRectGetHeight(self.attentionBtn.frame)));
        }];
        [UIView cornerCutToCircleWithView:_sex_oldLab
                          AndCornerRadius:CGRectGetHeight(self.attentionBtn.frame) / 2];
    }return _sex_oldLab;
}

-(UILabel *)provincelab{
    if (!_provincelab) {
        _provincelab = UILabel.new;
        _provincelab.backgroundColor = HEXCOLOR(0xF2F2F2);
        _provincelab.textColor = kBlackColor;
        _provincelab.textAlignment = NSTextAlignmentCenter;
        _provincelab.text = @"广东省";
        [self.view addSubview:_provincelab];
        [_provincelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.attentionBtn);
            make.size.top.equalTo(self.sex_oldLab);
        }];
        [UIView cornerCutToCircleWithView:_provincelab
                          AndCornerRadius:CGRectGetHeight(self.attentionBtn.frame) / 2];
    }return _provincelab;
}

-(UILabel *)constellationLab{
    if (!_constellationLab) {
        _constellationLab = UILabel.new;
        _constellationLab.backgroundColor = HEXCOLOR(0xF2F2F2);
        _constellationLab.textColor = kBlackColor;
        _constellationLab.textAlignment = NSTextAlignmentCenter;
        _constellationLab.text = @"双鱼座";
        [self.view addSubview:_constellationLab];
        [_constellationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.top.equalTo(self.sex_oldLab);
            make.right.equalTo(self.attentionBtn);
        }];
        [UIView cornerCutToCircleWithView:_constellationLab
                           AndCornerRadius:CGRectGetHeight(self.attentionBtn.frame) / 2];
    }return _constellationLab;
}

-(UILabel *)personalizedSignatureLab{
    if (!_personalizedSignatureLab) {
        _personalizedSignatureLab = UILabel.new;
//        _personalizedSignatureLab.backgroundColor = HEXCOLOR(0xF2F2F2);
        _personalizedSignatureLab.textColor = kBlackColor;
        _personalizedSignatureLab.numberOfLines = 0;
        _personalizedSignatureLab.textAlignment = NSTextAlignmentCenter;
        _personalizedSignatureLab.text = @"个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名";
        [self.view addSubview:_personalizedSignatureLab];
        [_personalizedSignatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.attentionBtn);
            make.top.equalTo(self.constellationLab.mas_bottom).offset(SCALING_RATIO(15));
            make.height.mas_equalTo(CGRectGetHeight(self.attentionBtn.frame) * 1.5);
        }];
    }return _personalizedSignatureLab;
}

-(TipsV *)tipsV_attention{
    if (!_tipsV_attention) {
        _tipsV_attention = [[TipsV alloc] initWithTitle:@"关注"
                                             showNumber:@"5.1万"];
        [self.view addSubview:_tipsV_attention];
        [_tipsV_attention mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.personalizedSignatureLab.mas_bottom).offset(SCALING_RATIO(5));
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 6, SCALING_RATIO(50)));
            make.left.equalTo(self.view).offset(SCALING_RATIO(30));
        }];
        @weakify(self)
        [_tipsV_attention addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
            
            if (![MKTools mkLoginIsYESWith:weak_self]) { return; }
            
            [MKAttentionVC ComingFromVC:weak_self
                            comingStyle:ComingStyle_PUSH
                      presentationStyle:UIModalPresentationAutomatic
                          requestParams:@{
                              @"mkType":@(2),@"dataModel":weak_self.mkPernalModel
                          }
                                success:^(id data) {}
                               animated:YES];
        }];
    }return _tipsV_attention;
}

-(TipsV *)tipsV_fans{
    if (!_tipsV_fans) {
        _tipsV_fans = [[TipsV alloc] initWithTitle:@"粉丝"
                                        showNumber:@"146万"];
        [self.view addSubview:_tipsV_fans];
        [_tipsV_fans mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.personalizedSignatureLab.mas_bottom).offset(SCALING_RATIO(5));
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 6, SCALING_RATIO(50)));
            make.centerX.equalTo(self.view);
        }];
        @weakify(self)
        [_tipsV_fans addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
            
            if (![MKTools mkLoginIsYESWith:weak_self]) { return; }
            
            [MKAttentionVC ComingFromVC:weak_self
                            comingStyle:ComingStyle_PUSH
                      presentationStyle:UIModalPresentationAutomatic
                          requestParams:@{
                              @"mkType":@(3),
                              @"dataModel":weak_self.mkPernalModel
                          }
                                success:^(id data) {}
                               animated:YES];
        }];
    }return _tipsV_fans;
}

-(TipsV *)tipsV_like{
    if (!_tipsV_like) {
        _tipsV_like = [[TipsV alloc] initWithTitle:@"获赞"
                                        showNumber:@"8787万"];
        [self.view addSubview:_tipsV_like];
        [_tipsV_like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.personalizedSignatureLab.mas_bottom).offset(SCALING_RATIO(5));
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 6, SCALING_RATIO(50)));
            make.right.equalTo(self.view).offset(SCALING_RATIO(-30));
        }];
    }return _tipsV_like;
}

- (MKPersonalnfoModel *)mkPernalModel{
    
    if (!_mkPernalModel) {
        
        _mkPernalModel = [[MKPersonalnfoModel alloc]init];
    }
    return _mkPernalModel;
}

- (ProductionVC *)mkProductVC{
    
    if (!_mkProductVC) {
        
        _mkProductVC = [[ProductionVC alloc]init];
    }
    return _mkProductVC;
}

- (LikedVC *)mkLikedVC{
    
    if (!_mkLikedVC) {
        
        _mkLikedVC = [[LikedVC alloc]init];
    }
    return _mkLikedVC;
}
- (MKPersonView *)mkPersonView{
    
    if (!_mkPersonView) {
        
        _mkPersonView = [[MKPersonView alloc]init];
        
        _mkPersonView.backgroundColor = [UIColor clearColor];
        
        
        [self.view addSubview:_mkPersonView];
        
        [_mkPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.equalTo(@(KDeviceScale * 250));
        }];
        
    }
    return _mkPersonView;
}

@end
