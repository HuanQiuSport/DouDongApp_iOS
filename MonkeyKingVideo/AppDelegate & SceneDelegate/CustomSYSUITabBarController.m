//
//  CustomSYSUITabBarController.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "CustomSYSUITabBarController.h"

#import "HomeVC.h"//首页
#import "TaskVC.h"//任务
#import "PhotoVC.h"//拍照
#import "CommunityVC.h"//社区
#import "MyVC.h"//我
#import "MKMineVC.h"

@interface CustomSYSUITabBarController ()
<
LZBTabBarVCDelegate
>
 
@property(nonatomic,strong)NSMutableArray<UIImage *> *customUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<UIImage *> *customSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *titleStrMutArr;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *viewControllerMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *lottieJsonNameStrMutArr;
@property(nonatomic,strong)NSMutableArray *mutArr;

@end

CGFloat LZB_TABBAR_HEIGHT;

@implementation CustomSYSUITabBarController

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userCenter" object:nil];
}

-(instancetype)init{
    if (self = [super init]) {
    }return self;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    LZB_TABBAR_HEIGHT = isiPhoneX_series() ? (50 + isiPhoneX_seriesBottom) : 49;
    [super viewDidLoad];
    
    self.gk_navigationBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    self.lzb_tabBar.tabBarStyleType = LZBTabBarStyleType_sysNormal;
    self.lzb_tabBar.topLine.alpha = 0;//TabBar顶部分割线
//    self.lzb_tabBar.lottieJsonNameStrMutArr = self.lottieJsonNameStrMutArr;

    [self p_setUpAllChildViewController];
   
    
//    [self Badge];
}
///右上角角标
-(void)Badge{
    LZBTabBarItem *tabBarItem = self.lzb_tabBar.lzbTabBarItemsArr[0];
//    [tabBarItem pp_addBadgeWithText:@"99+"];
    [tabBarItem pp_addBadgeWithNumber:99];
    [tabBarItem pp_moveBadgeWithX:-20 Y:20];
    [tabBarItem pp_decreaseBy:10];
}
///登录流程
-(void)presentLoginVC{
//    @weakify(self)
    
}


- (void)p_setUpAllChildViewController {
    self.delegate = self;
    for (int i = 0; i < self.viewControllerMutArr.count; i ++) {
        [self.mutArr addObject:(UIViewController *)self.viewControllerMutArr[i]];
    }
    self.viewControllers = (NSArray *)self.mutArr;
    for (int i = 0; i <self.customUnselectedImgMutArr.count; i++) {
        [self p_setupCustomTBCWithViewController:self.viewControllerMutArr[i]
                                           Title:self.titleStrMutArr[i]
                                     SelectImage:(UIImage *)self.customSelectedImgMutArr[i]
                                   NnSelectImage:(UIImage *)self.customUnselectedImgMutArr[i]];
    }
    self.lzb_tabBar.backgroundColor = [UIColor blackColor];
    self.isShouldAnimation = YES;
}

-(void)p_setupCustomTBCWithViewController:(UIViewController *)vc
                                    Title:(NSString *)titleStr
                              SelectImage:(UIImage *)selectImage
                            NnSelectImage:(UIImage *)unSelectImage{
    vc.lzb_tabBarItem.selectImage = selectImage;
    vc.lzb_tabBarItem.unSelectImage = unSelectImage;
    vc.lzb_tabBarItem.title = titleStr;//下
    vc.title = titleStr;//上
}
#pragma mark ======== LZBTabBarViewControllerDelegate ======
- (BOOL)lzb_tabBarController:(LZBTabBarVC *)tabBarController
  shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
//改1
//点击的时候进行确认是否登录
- (void)lzb_tabBarController:(LZBTabBarVC *)tabBarController
     didSelectViewController:(UIViewController *)viewController {

    if ([viewController isKindOfClass:[HomeVC class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKHomeNotification object:nil];
       
    } else if ([viewController isKindOfClass:[CommunityVC class]]) {
    
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCommunityNotification object:nil];
    } else if ([viewController isKindOfClass:[PhotoVC class]]) {
  
        [[NSNotificationCenter defaultCenter] postNotificationName:MKShotNotification object:nil];
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
    } else if ([viewController isKindOfClass:[TaskVC class]]) {
  
        [[NSNotificationCenter defaultCenter] postNotificationName:MKLucrativeNotification object:nil];
    } else if ([viewController isKindOfClass:[MyVC class]]) {
    
    }else if ([viewController isKindOfClass:[MKMineVC class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKMineNotification object:nil];
    }
}

- (void)naoziyoubingNotification:(NSNotification *)notification {
    
}

#pragma mark —— lazyLoad
-(NSMutableArray *)mutArr{
    if (!_mutArr) {
        _mutArr = NSMutableArray.array;
    }return _mutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"首页"];
        [_titleStrMutArr addObject:@"社区"];
        [_titleStrMutArr addObject:@""];
        [_titleStrMutArr addObject:@"赚币"];
        [_titleStrMutArr addObject:@"我的"];
    }return _titleStrMutArr;
}

-(NSMutableArray<UIImage *> *)customUnselectedImgMutArr{
    if (!_customUnselectedImgMutArr) {
        _customUnselectedImgMutArr = NSMutableArray.array;
        [_customUnselectedImgMutArr addObject:KIMG(@"Home_unselected")];
        [_customUnselectedImgMutArr addObject:KIMG(@"community_unselected")];
        [_customUnselectedImgMutArr addObject:KIMG(@"Camera")];
        [_customUnselectedImgMutArr addObject:KIMG(@"task_unselected")];
        [_customUnselectedImgMutArr addObject:KIMG(@"My_unselected")];
    }return _customUnselectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)customSelectedImgMutArr{
    if (!_customSelectedImgMutArr) {
        _customSelectedImgMutArr = NSMutableArray.array;
        [_customSelectedImgMutArr addObject:KIMG(@"Home_selected")];
        [_customSelectedImgMutArr addObject:KIMG(@"community_selected")];
        [_customSelectedImgMutArr addObject:KIMG(@"Camera")];
        [_customSelectedImgMutArr addObject:KIMG(@"task_selected")];
        [_customSelectedImgMutArr addObject:KIMG(@"My_selected")];
    }return _customSelectedImgMutArr;
}

-(NSMutableArray<UIViewController *> *)viewControllerMutArr{
    if (!_viewControllerMutArr) {
        _viewControllerMutArr = NSMutableArray.array;
        [_viewControllerMutArr addObject:HomeVC.new];
        [_viewControllerMutArr addObject:CommunityVC.new];
        [_viewControllerMutArr addObject:PhotoVC.new];
        [_viewControllerMutArr addObject:TaskVC.new];
        [_viewControllerMutArr addObject:MKMineVC.new];
    }return _viewControllerMutArr;
}

-(NSMutableArray<NSString *> *)lottieJsonNameStrMutArr{
    if (!_lottieJsonNameStrMutArr) {
        _lottieJsonNameStrMutArr = NSMutableArray.array;
        
//        [_lottieJsonNameStrMutArr addObject:@"首页选中.json"];
//        [_lottieJsonNameStrMutArr addObject:@"首页选中.json"];
//        [_lottieJsonNameStrMutArr addObject:@"首页选中.json"];
//        [_lottieJsonNameStrMutArr addObject:@"首页选中.json"];
//        [_lottieJsonNameStrMutArr addObject:@"首页选中.json"];
        
    }return _lottieJsonNameStrMutArr;
}


@end
