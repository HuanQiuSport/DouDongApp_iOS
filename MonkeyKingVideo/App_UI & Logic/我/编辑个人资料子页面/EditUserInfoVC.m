//
//  EditUserInfoVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "EditUserInfoVC.h"
#import "EditUserInfoVC+VM.h"
#import "MKEditUserInfoCell.h"
#import "WDAlterSheetView.h"

#import "ClipViewController.h"
#import "UIImage+Crop.h"
@interface EditUserInfoVC ()
<
UITableViewDelegate
,UITableViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property(nonatomic,strong)UIView *tableViewHeaderView;
@property(nonatomic,assign)NSInteger imageHeight;
@property(nonatomic,strong)NSMutableArray *titleMutArr;
@property(nonatomic,strong)NSString *addressStr;
@property(nonatomic,strong)NSString *dateStr;
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,strong)UILabel *changeLabel;

@property (nonatomic, strong) UIImagePickerController * pickerController;
@end

@implementation EditUserInfoVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    EditUserInfoVC *vc = EditUserInfoVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
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
        self.imageHeight = SCALING_RATIO(82);//背景图片的高度
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"个人资料";
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.tableView.alpha = 1;
    self.headerBtn.alpha = 1;
    self.addressPickerView.pickerMode = BRAddressPickerModeProvince;
    self.view.backgroundColor = HEXCOLOR(0xFAFAFA);
    self.gk_navTitleColor = UIColor.blackColor;
    self.gk_navBackgroundColor = UIColor.whiteColor;
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
    if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
        [self netWorking_MKUserInfoGET];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)BRDatePickerViewAction{
    @weakify(self)
    self.datePickerView.doneBlock = ^{
        @strongify(self)
        if (![NSString isNullString:self.dateStr]) {
            [self.detailTitleMutArr insertObject:self.dateStr atIndex:3];
            [self.detailTitleMutArr removeObjectAtIndex:4];
            [self requestWithUserID:self.dateStr
                           WithType:UpdateUserInfoType_Birthday
                              Block:^(id data) {
                
            }];
        }
    };
    
    self.datePickerView.resultBlock = ^(NSDate *selectDate,
                                    NSString *selectValue) {
        @strongify(self)
        NSLog(@"选择的值：%@", selectValue);
        self.dateStr = selectValue;
    };
}

-(void)BRAddressPickerViewAction{
    @weakify(self)
    self.addressPickerView.doneBlock = ^{
        @strongify(self)
        if (![NSString isNullString:self.addressStr]) {
            [self.detailTitleMutArr insertObject:self.addressStr atIndex:4];
            [self.detailTitleMutArr removeObjectAtIndex:5];
            [self requestWithUserID:self.addressStr
                           WithType:UpdateUserInfoType_Area
                              Block:^(id data) {

            }];
        }
    };
    
    self.addressPickerView.resultBlock = ^(BRProvinceModel *province,
                                           BRCityModel *city,
                                           BRAreaModel *area) {
        @strongify(self)
        NSLog(@"选择的值：%@", [NSString stringWithFormat:@"%@-%@-%@", province.name, city.name, area.name]);
        self.addressStr = [NSString stringWithFormat:@"%@%@%@", province.name, city.name, area.name];
    };
}

#pragma mark ——  下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
        [self netWorking_MKUserInfoGET];
    }
}
#pragma mark —— 上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
}

-(void)Photo{
    [self camera:^(id data) { }];
    @weakify(self);
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:UIImage.class]) {
                        UIImage *img = (UIImage *)arg;
                        //拿到了图片进行裁剪压缩等操作
                        [self Tailor:img];
                    }
                }
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];
}
#pragma mark - 调用相册回调
-(void)byPhotoAlbum{
    [self choosePic:TZImagePickerControllerType_1 imagePickerVCBlock:nil];
    @weakify(self)
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:NSArray.class]) {
                        NSArray *arrData = (NSArray *)arg;
                        if ([arrData[0] isKindOfClass:UIImage.class]) {
                            if (arrData.count == 1) {
                                UIImage *img = arrData.firstObject;
                                //拿到了图片进行裁剪压缩等操作
                                [self Tailor:img];
                            }else{
                                [NSObject showSYSAlertViewTitle:@"选择一张相片就够啦"
                                                        message:nil
                                                isSeparateStyle:YES
                                                    btnTitleArr:@[@"好的"]
                                                 alertBtnAction:@[@""]
                                                       targetVC:self
                                                   alertVCBlock:^(id data) {
                                    //DIY
                                }];
                            }
                        }
                    }
                }
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];
}
#pragma mark —— 裁剪图片的方式 TZ一个，imageresizerView一个,YQImageCompressTool一个
//图片裁剪 + 裁剪完成以后进行网络传输
-(void)Tailor:(UIImage *)img{
    [self.headerBtn setBackgroundImage:img
                              forState:UIControlStateNormal];
    @weakify(self)
    [YQImageCompressTool CompressToImageAtBackgroundWithImage:img
                                                     ShowSize:CGSizeMake(80, 80)
                                                     FileSize:200
                                                        block:^(UIImage *resultImage) {
        @strongify(self)
        //网络上传
        [self netWorking_MKUserInfoUploadImagePOST:resultImage];
    }];
}

-(void)changeSex_Boy{
    self.sex = @"0";
    [self changeSex];
}

-(void)changeSex_Girl{
    self.sex = @"1";
    [self changeSex];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    if (indexPath.section == 1) {
        if (indexPath.row == 1 && !self.userInfoModel.phone.length) {
            self.nickName = [MKBindingTelVC ComingFromVC:weak_self
                                             comingStyle:ComingStyle_PUSH
                                       presentationStyle:UIModalPresentationFullScreen
                                           requestParams:@{@"nikcName":self.userInfoModel.nickName}
                                                 success:^(id data) {}
                                                animated:YES];
        }
    } else {
        switch (indexPath.row) {
            case 0:{//昵称
                self.changeNickNameVC = [MKChangeNameController ComingFromVC:weak_self
                                                                 comingStyle:ComingStyle_PUSH
                                                           presentationStyle:UIModalPresentationFullScreen
                                                               requestParams:@{@"nikcName":self.userInfoModel.nickName}
                                                                     success:^(id data) {}
                                                                    animated:YES];

                [self.changeNickNameVC actionChangeNickNameBlock:^(id data) {
                    @strongify(self)
                    if ([data isKindOfClass:UITextField.class]) {
                        UITextField *tf = (UITextField *)data;
                        [self requestWithUserID:tf.text
                                       WithType:UpdateUserInfoType_NickName
                                          Block:^(id data) {
                          
                        }];
                    }
                }];
            }break;
            case 1:{//签名
                self.changePersonalizedSignatureVC = [MKChangePersonalizedSignatureVC ComingFromVC:weak_self
                                                                                       comingStyle:ComingStyle_PUSH
                                                                                 presentationStyle:UIModalPresentationFullScreen
                                                                                     requestParams:self.userInfoModel.remark
                                                                                           success:^(id data) {}
                                                                                          animated:YES];
              
                [self.changePersonalizedSignatureVC actionChangePersonalizedSignatureBlock:^(id data) {
                    @strongify(self)
                    if ([data isKindOfClass:UITextView.class]) {
                        UITextView *tv = (UITextView *)data;
                        [self requestWithUserID:tv.text
                                       WithType:UpdateUserInfoType_Remark
                                          Block:^(id data) {
                              
                        }];
                    }
                }];
          }break;
          case 2:{//性别
//              WDAlterSheetModel *m1 = [WDAlterSheetModel setupWithTitle:@"男"
//                                                             titleColor:UIColor.blackColor
//                                                              titleFont:[UIFont systemFontOfSize:18]
//                                                               subTitle:@""
//                                                          subTitleColor:UIColor.lightGrayColor
//                                                           subTitleFont:[UIFont systemFontOfSize:11]];
//              WDAlterSheetModel *m2 = [WDAlterSheetModel setupWithTitle:@"女"
//                                                             titleColor:UIColor.blackColor
//                                                              titleFont:[UIFont systemFontOfSize:18]
//                                                               subTitle:@""
//                                                          subTitleColor:UIColor.lightGrayColor
//                                                           subTitleFont:[UIFont systemFontOfSize:11]];
//              @weakify(self)
//              [WDAlterSheetView showAlterWithTitleAttItems:@[m1, m2]
//                                                cancelText:@"取消"
//                                               cancelColor:[UIColor blackColor]
//                                            didSelectBlock:^(NSUInteger index) {
//                  @strongify(self)
//                  if (index == 0) {
//                      [self changeSex_Boy];
//                  } else if (index == 1) {
//                      [self changeSex_Girl];
//                  }
//              }];
              SPAlertController *alert = [SPAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:SPAlertControllerStyleActionSheet];

              SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"男" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
                  [self changeSex_Boy];
              }];
              SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"女" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
                  [self changeSex_Girl];
              }];
              SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {}];

              [alert addAction:action1];
              [alert addAction:action2];
              [alert addAction:action3];
              [self presentViewController: alert animated:YES completion:^{}];
          }break;
          case 3:{//生日
              [self.datePickerView show];
              [self BRDatePickerViewAction];
          }break;
          case 4:{//地区
              [self.addressPickerView show];
              [self BRAddressPickerViewAction];
          }break;
          
          default:
              break;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.titleMutArr[section];
    return array.count;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    view.backgroundColor = HEXCOLOR(0xFAFAFA);
    UILabel *lab = UILabel.new;
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17);
        make.top.bottom.offset(0);
    }];
    lab.text = @"账号与安全";
    lab.textColor = HEXCOLOR(0x8F8F94);
    lab.font = [UIFont systemFontOfSize:13];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 29;
    } else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKEditUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKEditUserInfoCell"];
    cell.leftLab.text = self.titleMutArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.rightLab.text = self.userInfoModel.nickName.length ? self.userInfoModel.nickName : @"未填写";
            cell.rightLab.textColor = self.userInfoModel.nickName.length ? UIColor.blackColor : HEXCOLOR(0x999999);
            [cell hideIcon:0];
        } else if (indexPath.row == 1) {
            cell.rightLab.text = self.userInfoModel.remark.length ? self.userInfoModel.remark : @"未填写";
            cell.rightLab.textColor = self.userInfoModel.remark.length ? UIColor.blackColor : HEXCOLOR(0x999999);
            [cell hideIcon:0];
        } else if (indexPath.row == 2) {
            cell.rightLab.text = self.userInfoModel.sex.length ? self.userInfoModel.sex : @"未选择";
            cell.rightLab.textColor = self.userInfoModel.sex.length ? UIColor.blackColor : HEXCOLOR(0x999999);
            [cell hideIcon:0];
        } else if (indexPath.row == 3) {
            cell.rightLab.text = self.userInfoModel.birthday.length ? self.userInfoModel.birthday : @"未选择";
            cell.rightLab.textColor = self.userInfoModel.birthday.length ? UIColor.blackColor : HEXCOLOR(0x999999);
            [cell hideIcon:0];
        } else if (indexPath.row == 4) {
            cell.rightLab.text = self.userInfoModel.area.length ? self.userInfoModel.area : @"未选择";
            cell.rightLab.textColor = self.userInfoModel.area.length ? UIColor.blackColor : HEXCOLOR(0x999999);
            [cell hideIcon:0];
        }
    } else {
        if (indexPath.row == 0) {
            cell.rightLab.text = self.userInfoModel.account.length ? self.userInfoModel.account : @"未绑定";
            cell.rightLab.textColor = @"未绑定".length ? UIColor.blackColor : HEXCOLOR(0xA7A7A7);
            [cell hideIcon:1];
        }else if (indexPath.row == 1) {
            if(self.userInfoModel.phone.length == 0) {
                cell.rightLab.text = @"未绑定";
                cell.rightLab.textColor = HEXCOLOR(0xA7A7A7);
                [cell hideIcon:NO];
            } else {
                NSString *phone =self.userInfoModel.phone;
                if(self.userInfoModel.phone.length > 7) {
                    NSString *frist = [phone substringToIndex:3];
                    NSString *end = [phone substringFromIndex:self.userInfoModel.phone.length - 4];
                    phone = [NSString stringWithFormat:@"%@****%@",frist,end];
                }
                cell.rightLab.text = phone;
                cell.rightLab.textColor = UIColor.blackColor;
                [cell hideIcon:YES];
            }
        } else {
            cell.rightLab.text = @"未绑定";
            cell.rightLab.textColor = HEXCOLOR(0xA7A7A7);
            [cell hideIcon:0];
        }
    }
    return cell;
}

#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor =  HEXCOLOR(0xFAFAFA);
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
            extern CGFloat LZB_TABBAR_HEIGHT;
            make.bottom.equalTo(self.view).offset(0);
        }];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.tableHeaderView = self.tableViewHeaderView;
        _tableView.mj_footer.hidden = YES;
        [_tableView registerClass:[MKEditUserInfoCell class] forCellReuseIdentifier:@"MKEditUserInfoCell"];
    }return _tableView;
}

-(UIButton *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = UIButton.new;
        [_headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@""]
                                        forState:UIControlStateNormal
                                placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
        @weakify(self)
        [[_headerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

            SPAlertController *alert = [SPAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:SPAlertControllerStyleActionSheet];

            SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"拍照" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
                [self Photo];
                // 打开相机 获取访问权限
//                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//                imagePickerController.delegate = self;
//                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"从相册选择" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
                [self byPhotoAlbum];
                // 打开相册
//                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//                imagePickerController.delegate = self;
//                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {}];

            [alert addAction:action1];
            [alert addAction:action2];
            [alert addAction:action3];
            [self presentViewController: alert animated:YES completion:^{}];
        }];
        
        [self.tableViewHeaderView addSubview:_headerBtn];
      
        [_headerBtn addSubview:self.changeLabel];
        [_headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.centerX.offset(0);
            make.height.width.offset(82);
        }];
        [_changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.equalTo(_headerBtn);
            make.height.mas_equalTo(30);
        }];
        [UIView cornerCutToCircleWithView:_headerBtn
                          AndCornerRadius:82 / 2];
    }return _headerBtn;
}

-(UIView *)tableViewHeaderView{
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = UIView.new;
        _tableViewHeaderView.backgroundColor = UIColor.whiteColor;
        _tableViewHeaderView.frame = CGRectMake(0,
                                                0,
                                                SCREEN_WIDTH,
                                                _imageHeight+20 + 20);
//        UIView *botView = UIView.new;
//        [_tableViewHeaderView addSubview:botView];
//        [botView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.bottom.left.offset(0);
//            make.height.offset(7);
//        }];
//        botView.backgroundColor = HEXCOLOR(0x20242F);
    }
    return _tableViewHeaderView;
}

- (UILabel *)changeLabel {
    if (!_changeLabel) {
        _changeLabel = [UILabel new];
        _changeLabel.text = @"更换头像";
        _changeLabel.textAlignment = NSTextAlignmentCenter;
        _changeLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        _changeLabel.textColor = [UIColor whiteColor];
        _changeLabel.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.5];
    }
    return _changeLabel;
}

-(NSMutableArray *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        NSMutableArray *array = [NSMutableArray new];
        [array addObject:@"昵称"];
        [array addObject:@"签名"];
        [array addObject:@"性别"];
        [array addObject:@"生日"];
        [array addObject:@"地区"];
        [_titleMutArr addObject:array];
        NSMutableArray *array1 = [NSMutableArray new];
        [array1 addObject:@"我的账号"];
        [array1 addObject:@"手机号"];
        [_titleMutArr addObject:array1];
        
    }return _titleMutArr;
}

-(NSMutableArray *)detailTitleMutArr{
    if (!_detailTitleMutArr) {
        _detailTitleMutArr = NSMutableArray.array;
        NSMutableArray *array = [NSMutableArray new];
        [array addObject:@"未填写"];
        [array addObject:@"未填写"];
        [array addObject:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.sex];
        [array addObject:@"未选择"];
        [array addObject:@"未选择"];
     
        [_detailTitleMutArr addObject:array];
        NSMutableArray *array1 = [NSMutableArray new];
        [array1 addObject:@"未绑定"];
        [_detailTitleMutArr addObject:array1];
        
    }return _detailTitleMutArr;
}
#pragma mark - 头像剪辑
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image =  [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = image.size.height * (width/image.size.width);
        UIImage *orImage = [image resizeImageWithSize:CGSizeMake(width, height)];
        ClipViewController * con = [[ClipViewController alloc] initWithImage:orImage delegate:self];
        con.ovalClip = YES;
        [self.navigationController pushViewController:con animated:YES];
    }];
}
#pragma mark -- CropImageDelegate
- (void)cropImageDidFinishedWithImage:(UIImage *)image {
//    [_headButton setBackgroundImage:image forState:UIControlStateNormal];
    //拿到了图片进行裁剪压缩等操作
//    UIImage *img = [self fixOrientation:image];
    [self Tailor:image];
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}
// 解决图片自动旋转90度的问题
- (UIImage *)fixOrientation:(UIImage *)aImage {
    if (!aImage) return aImage;
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
#pragma mark - UIStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
@end
