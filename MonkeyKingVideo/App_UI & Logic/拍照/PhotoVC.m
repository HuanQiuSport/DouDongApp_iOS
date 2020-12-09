//
//  PhotoVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PhotoVC.h"
#import "MKUploadingVC.h"//上传

#import "SDVideoConfig.h"
#import "MKVideoController.h"

#import "SDVideoCameraController.h"

@interface PhotoVC ()<JXCategoryTitleViewDataSource,JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>

@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;
@property(nonatomic,strong)MKUploadingVC *uploadingVC;
@property(nonatomic,strong) UIButton *cameraBtn;
@property(nonatomic,strong) UIButton *uploadBtn;
@property(nonatomic,strong)UIImage *__block image;

@end

@implementation PhotoVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (void)loadView {
    [super loadView];
    
    [self.categoryView addSubview:self.cameraBtn];
    [self.categoryView addSubview:self.uploadBtn];
    [self eventResponce];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.categoryView.alpha = 1;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
  
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
    self.gk_navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)eventResponce {
    
    [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.categoryView).offset(-20*MAINSCREEN_WIDTH/375);
           make.centerY.equalTo(self.categoryView);
           make.width.mas_equalTo(50*MAINSCREEN_WIDTH/375);
           make.height.equalTo(self.categoryView.mas_height);
     }];
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryView);
        make.centerY.equalTo(self.categoryView);
        make.width.mas_equalTo(50*MAINSCREEN_WIDTH/375);
        make.height.equalTo(self.categoryView.mas_height);
    }];
    @weakify(self)
    [[self.cameraBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        SDVideoConfig *config = [[SDVideoConfig alloc] init];
        config.returnViewController = self;
        config.returnBlock = ^(NSString *mergeVideoPathString) {
//            NSLog(@"合成路径 %@",mergeVideoPathString);
        };
        config.previewTagImageNameArray = @[@"circle_add_friend_icon",@"circle_apply_friend_icon"];
        
        SDVideoCameraController *videoController = [[SDVideoCameraController alloc] initWithCameraConfig:config];
//        [self presentViewController:videoController animated:YES completion:nil];
        [self.navigationController pushViewController:videoController animated:YES];
    }];
    
}

-(void)Cancel{
    [self.categoryView selectItemAtIndex:1];
    [self.listContainerView didClickSelectedItemAtIndex:1];
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
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    return self.childVCMutArr[index];
}
#pragma mark JXCategoryViewDelegate
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
     [self.listContainerView didClickSelectedItemAtIndex:index];
   
}

- (void)categoryView:(JXCategoryBaseView *)categoryView
didScrollSelectedItemAtIndex:(NSInteger)index{
    if (index) {//1
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
        self.gk_navigationBar.hidden = NO;
//        [self.shootVC.gpuImageTools.videoCamera resumeCameraCapture];
    }else{//0
        // 停止实况采样节约能耗
//        [self.shootVC.gpuImageTools.videoCamera stopCameraCapture];
//        //重新拍摄
//        switch (self.shootVC.gpuImageTools.vedioShootType) {
//            case VedioShootType_on://开始录制
//            case VedioShootType_suspend://暂停录制
//            case VedioShootType_continue:{//继续录制
////                [NSObject showSYSAlertViewTitle:@"丢弃掉当前拍摄的作品？"
////                                        message:nil
////                                isSeparateStyle:NO
////                                    btnTitleArr:@[@"确认",@"手滑了"]
////                                 alertBtnAction:@[@"",@"Cancel"]
////                                       targetVC:self
////                                   alertVCBlock:^(id data) {
////                    //DIY
////                }];
//            } break;
//            default:
//                break;
//        }
//
       
        
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
        self.gk_navigationBar.hidden = YES;
    }
}
#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@""];
//        [_titleMutArr addObject:@"拍摄"];
    }return _titleMutArr;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [self.childVCMutArr addObject:self.uploadingVC];
//        [self.childVCMutArr addObject:self.videoShoot];
    }return _childVCMutArr;
}

-(MKUploadingVC *)uploadingVC{
    if (!_uploadingVC) {
        _uploadingVC = MKUploadingVC.new;
    }return _uploadingVC;
}

//-(MKShootVC *)shootVC{
//    if (!_shootVC) {
//        _shootVC = MKShootVC.new;
//        @weakify(self)
//        [_shootVC ActionMKShootVCBlock:^(id data) {
//            @strongify(self)
//            if ([data isKindOfClass:NSNumber.class]) {
//                NSNumber *num = (NSNumber *)data;
//                if (num.boolValue) {//进来
//                    [UIView animateWithDuration:0.25f
//                                     animations:^{
//                        [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(self.view);
//                            make.right.equalTo(self.view.mas_centerX);
//                            make.height.mas_equalTo(SCALING_RATIO(0));
//                            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar());
//                        }];
//                    } completion:^(BOOL finished) {
//
//                    }];
//                }else{//出去
//                    [UIView animateWithDuration:0.25f
//                                     animations:^{
//                        [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(self.view);
//                            make.right.equalTo(self.view.mas_centerX);
//                            make.height.mas_equalTo(SCALING_RATIO(50));
//                            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar());
//                        }];
//                    } completion:^(BOOL finished) {
//
//                    }];
//                }
//            }else if ([data isKindOfClass:NSString.class]){
//                NSString *str = (NSString *)data;
//                if ([str isEqualToString:@"exit"] ||
//                    [str isEqualToString:@"gpuImageTools"]) {
//                    [self.categoryView selectItemAtIndex:0];
//                    [self.listContainerView didClickSelectedItemAtIndex:0];
//                }else{}
//            }else if ([data isKindOfClass:UIImage.class]){
//                NSLog(@"");
//                self.image  = (UIImage *)data;
//
//            }else{}
//            if (data != nil) {
//                self.uploadingVC.img = self.image;
//            }
//
//        }];
//    }return _shootVC;
//}

-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView
                                                                      delegate:self];
        _listContainerView.defaultSelectedIndex = 0;//默认从第二个开始显示
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _listContainerView.scrollView.scrollEnabled = NO;
        [self.view layoutIfNeeded];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = kClearColor;
        _lineView.indicatorHeight = 4;
        _lineView.indicatorWidthIncrement = 10;
        _lineView.verticalMargin = 0;
    }return _lineView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = kClearColor;
        _categoryView.titleSelectedColor = kWhiteColor;
        _categoryView.titleColor = [UIColor colorWithHexString:@"c4c1c1"];
        _categoryView.titleFont = [UIFont systemFontOfSize:14];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:18];
        _categoryView.delegate = self;
        _categoryView.titleLabelZoomScale = -20;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[self.lineView];//
        _categoryView.defaultSelectedIndex = 0;//默认从第二个开始显示
        _categoryView.cellSpacing = -20;
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;//
        _categoryView.contentScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(55);
            make.right.equalTo(self.view.mas_centerX);
            make.height.mas_equalTo(50);
            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar()-5);
        }];
        
        
        
        [self.view layoutIfNeeded];
    }return _categoryView;
}

- (UIButton *)cameraBtn {
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setTitle:@"拍摄" forState:UIControlStateNormal];
        _cameraBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cameraBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    }
    return _cameraBtn;
}

- (UIButton *)uploadBtn {
    if (!_uploadBtn) {
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
          [_uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
            _uploadBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            [_uploadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _uploadBtn;
}

@end
