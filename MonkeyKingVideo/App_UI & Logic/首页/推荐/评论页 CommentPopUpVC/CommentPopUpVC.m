//
//  CommentPopUpVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpVC.h"
#import "CommentPopUpVC+VM.h"

#import "LoadMoreTBVCell.h"
#import "InfoTBVCell.h"

#import "NonHoveringHeaderView.h"
#import "HoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"
#import "NSString+Extras.h"

@interface CommentPopUpVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UIBarButtonItem *closeItem;
@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,strong)MKFirstCommentModel *firstCommentModel;
@property(nonatomic,strong)MKChildCommentModel *childCommentModel;
@property(nonatomic,strong)NSString *commentId;
@property(nonatomic,strong)NSString *ID;

@property(nonatomic,assign)BOOL isReplyComment;
@property(nonatomic,copy)NSString *cId;
@property(nonatomic,strong)NSString *replyName;

@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger row;


@end

@implementation CommentPopUpVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {
        self.isClickExitBtn = NO;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.botView];
    [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(SCALING_RATIO(62));
    }];
    [self.botView addSubview:self.botIcon];
    [self.botView addSubview:self.botLab];
//    self.field = UITextField.new;
//    self.field.delegate = self;
//    [self.field addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.keyboardTopView addSubview:self.field];
//    self.field.font = [UIFont systemFontOfSize:17];
//    self.field.frame = CGRectMake(57, 0, SCREEN_W-57-13, 62);
//    self.field.returnKeyType = UIReturnKeySend;
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.inputView.alpha = 1;
    self.tableView.alpha = 1;
    self.commentPage = 1;
    [self netWorking_MKCommentQueryInitListGET];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeadImg) name:MKRefreshHeadImgNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)refreshHeadImg {
    [self.botIcon sd_setImageWithURL:[NSURL URLWithString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.headImage]
                   placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
}
#pragma mark --键盘弹出
- (void)keyboardDidShow:(NSNotification *)notification{
        //取出键盘动画的时间(根据userInfo的key----UIKeyboardAnimationDurationUserInfoKey)
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y;
    //执行动画
    self.keyboardTopView.frame = CGRectMake(0, transformY-62, SCREEN_W, 62);
    self.coverKeyboardView.frame = CGRectMake(0, 0,SCREEN_W, self.keyboardTopView.origin.y);
    @weakify(self)
    [UIView animateWithDuration:duration animations:^{
        @strongify(self)
        self.keyboardTopView.alpha = 1;
        self.coverKeyboardView.alpha = 0.2;
    }];

}
#pragma mark --键盘收回
- (void)keyboardDidHide:(NSNotification *)notification{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    @weakify(self)
    [UIView animateWithDuration:duration animations:^{
        @strongify(self)
        self.coverKeyboardView.alpha = 0;
        self.keyboardTopView.alpha = 0;
        [self.coverKeyboardView removeFromSuperview];
    }];
}
//里面包含了网络请求
-(void)likeBtnClickAction:(UIButton *)sender model:(id)model isChild:(BOOL)isChild icon:(UIImageView *)icon countLab:(UILabel *)countLab{
    [self netWorking_MKCommentSetPraisePOSTWithCommentId:self.commentId ID:self.ID model:model isChild:isChild sender:sender icon:icon countLab:countLab];
}

-(void)commentPopUpActionBlock:(MKDataBlock)commentPopUpBlock{
    self.CommentPopUpBlock = commentPopUpBlock;
}

-(void)SureDeleteSelfComment{
    [self netWorking_MKCommentDelCommentPOSTWithCommentId:self.commentId
                                                       ID:self.ID];
}

-(void)Sure{}
//一级标题的：
-(void)Reply{
    [self.field becomeFirstResponder];
//    NSLog(@"%@",self.firstCommentModel.content);
    self.isReplyComment = YES;
    self.cId = self.firstCommentModel.ID;
    self.field.placeholder = [NSString stringWithFormat:@"回复@%@",self.replyName];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.headImage]
    placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
    
}

-(void)CopyIt{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.firstCommentModel.content;
    
    [MBProgressHUD wj_showPlainText:@"复制成功"
                               view:self.view];
    
}

-(void)Report{
    [MBProgressHUD wj_showPlainText:@"正在开发中" view:self.view];
}

-(void)Cancel{}
//二级标题的：
-(void)reply{
    [self.field becomeFirstResponder];
//    NSLog(@"%@",self.childCommentModel.content);
    self.isReplyComment = YES;
    self.cId = self.childCommentModel.ID;
    self.field.placeholder = [NSString stringWithFormat:@"回复@%@",self.replyName];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.headImage]
    placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
}

-(void)copyIt{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.childCommentModel.content;
    [MBProgressHUD wj_showPlainText:@"复制成功"
                               view:self.view];
}

-(void)report{
    [MBProgressHUD wj_showPlainText:@"正在开发中" view:self.view];
}

-(void)cancel{}
#pragma mark ===================== 下拉刷新===================================
- (void)pullToRefresh {
    self.commentPage = 1;
    DLog(@"下拉刷新");
    if (self.commentModel.listMytArr.count) {
        [self.commentModel.listMytArr removeAllObjects];
    }
    [self netWorking_MKCommentQueryInitListGET];
}
#pragma mark ===================== 上拉加载更多===================================
- (void)loadMore {
    DLog(@"上拉加载更多");
    self.commentPage++;
    [self netWorking_MKCommentQueryInitListGET];
}

-(void)endRefreshing:(BOOL)refreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark --field
- (void)changedTextField:(UITextField *)field {
    self.botLab.text = field.text.length ? field.text : @"我也来骚一下";
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([MKTools mkLoginIsYESWith:self]) {
        if (textField.text.length) {
            if (!self.isReplyComment) {
                [self netWorking_MKCommentVideoPOST];
            } else {
                [self netWorking_MKCommentReplyCommentPOSTWithCommentId:self.commentId ID:self.cId content:textField.text section:self.section row:self.row];
            }
            self.botLab.text = @"我也说几句";
            self.field.text = @"";
            [self.field endEditing:1];
        } else {
            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                          text:@"请输入内容"
                                            dissmissAfterDeley:1.2];
        }
    }
    return YES;
}

#pragma mark —— 点击事件
-(void)closeBtnClickEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (super.block) {
        super.block(sender);
    }
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[indexPath.section];
    MKChildCommentModel *child = firstCommentModel.child[indexPath.row];
    if (!firstCommentModel._hasMore) {//是全显示
        return [NSString textHitWithStirng:child.contentShow font:15.0 widt:kScreenWidth-88-46] + 20 + 20;
    }else{//不是全显示
        if (!firstCommentModel.isFullShow) {
            if (indexPath.row == 3) {
                return 36;
            } else {
                return [NSString textHitWithStirng:child.contentShow font:15.0 widt:kScreenWidth-88-46] + 20 + 20;
            }
        } else {
            if (indexPath.row == firstCommentModel.child.count) {
                return 36;
            } else {
                return [NSString textHitWithStirng:child.contentShow font:15.0 widt:kScreenWidth-88-46] + 20 + 20;
            }
        }
    }
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:LoadMoreTBVCell.class]) {//加载更多
        MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[indexPath.section];
        firstCommentModel.isFullShow = !firstCommentModel.isFullShow;
        @weakify(tableView)
        [UIView performWithoutAnimation:^{
            @strongify(tableView)
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                             withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:InfoTBVCell.class]){// 有内容
        InfoTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.childCommentModel = cell.childCommentModel;
        self.commentId = self.childCommentModel.commentId;
        self.ID = self.childCommentModel.ID;
        self.replyName = self.childCommentModel.nickname;
        self.section = indexPath.section;
        self.row = indexPath.row;
        
        if(![MKTools mkLoginIsYESWith:self]) {
            return;
        }
        [NSObject checkAuthorityWithType:MKLoginAuthorityType_Conment:^(id data) {
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *f = (NSNumber *)data;
                if (f.boolValue) {
                }else{
                    [NSObject showSYSAlertViewTitle:@"暂时没法使用此功能"
                                            message:@"请联系管理员开启此权限"
                                    isSeparateStyle:NO
                                        btnTitleArr:@[@"我知道了"]
                                     alertBtnAction:@[@""]
                                           targetVC:[SceneDelegate sharedInstance].customSYSUITabBarController
                                       alertVCBlock:^(id data) {
                        
                    }];return;
                }
            }
        }];
        
        if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid isEqualToString:cell.childCommentModel.userId]) {
            [NSObject showSYSActionSheetTitle:nil
                                      message:nil
                              isSeparateStyle:YES
                                  btnTitleArr:@[@"回复",@"复制",@"删除",@"取消"]
                               alertBtnAction:@[@"reply",@"copyIt",@"SureDeleteSelfComment",@"cancel"]
                                     targetVC:self
                                       sender:nil
                                 alertVCBlock:^(id data) {
                //DIY
            }];
        } else {
            [NSObject showSYSActionSheetTitle:nil
                                      message:nil
                              isSeparateStyle:YES
                                  btnTitleArr:@[@"回复",@"复制",@"取消"]
                               alertBtnAction:@[@"reply",@"copyIt",@"cancel"]
                                     targetVC:self
                                       sender:nil
                                 alertVCBlock:^(id data) {

            }];
        }
    }else{}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[section];
    if (firstCommentModel._hasMore) {
        if (firstCommentModel.isFullShow) {
            return firstCommentModel.child.count + 1;
        } else {
            return firstCommentModel.PreMax + 1;
        }
    } else {
        return firstCommentModel.child.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)

    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[indexPath.section];
    MKChildCommentModel *childCommentModel = firstCommentModel.child[indexPath.row];
    if (!firstCommentModel._hasMore) {//是全显示
        InfoTBVCell *cell = [InfoTBVCell cellWith:tableView];
        [cell richElementsInCellWithModel:childCommentModel];   
        cell.btnBlock = ^(UIButton * _Nonnull sender, UILabel * _Nonnull lab, UIImageView * _Nonnull icon) {
            @strongify(self)
            InfoTBVCell *btnCell = (InfoTBVCell *)[[sender superview] superview];
            NSIndexPath *btnIndexPath = [self.tableView indexPathForCell:btnCell];
            MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[btnIndexPath.section];
            MKChildCommentModel *childCommentModel = firstCommentModel.child[btnIndexPath.row];
            self.commentId = childCommentModel.commentId;
            self.ID = childCommentModel.ID;
            [self likeBtnClickAction:sender model:childCommentModel isChild:YES icon:icon countLab:lab];
        };
        cell.headerBlock = ^(NSDictionary * _Nonnull dic) {
            @strongify(self)
            if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid isEqualToString:dic[@"videoid"]]) {
                return;
            }
            MKSingeUserCenterVC *vc = [MKSingeUserCenterVC new];
            vc.requestParams = dic;
            [self.recommendVC.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else{//不是全显示
        NSInteger index;
        if (firstCommentModel.isFullShow)  {
            index = firstCommentModel.child.count;
        } else {
            index = firstCommentModel.PreMax;
        }
        if (indexPath.row == index) {//
            LoadMoreTBVCell *cell = [LoadMoreTBVCell cellWith:tableView];
            if (!firstCommentModel.isFullShow) {
                [cell richElementsInCellWithModel:childCommentModel];
            } else {
                [cell setData];
            }
            return cell;
        }else{
            InfoTBVCell *cell = [InfoTBVCell cellWith:tableView];
            [cell richElementsInCellWithModel:childCommentModel];
            cell.btnBlock = ^(UIButton * _Nonnull sender, UILabel * _Nonnull lab, UIImageView * _Nonnull icon) {
                @strongify(self)
                InfoTBVCell *btnCell = (InfoTBVCell *)[[sender superview] superview];
                NSIndexPath *btnIndexPath = [self.tableView indexPathForCell:btnCell];
                MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[btnIndexPath.section];
                MKChildCommentModel *childCommentModel = firstCommentModel.child[btnIndexPath.row];
                self.commentId = childCommentModel.commentId;
                self.ID = childCommentModel.ID;
                [self likeBtnClickAction:sender model:childCommentModel isChild:YES icon:icon countLab:lab];
            };
            cell.headerBlock = ^(NSDictionary * _Nonnull dic) {
                @strongify(self)
                if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid isEqualToString:dic[@"videoid"]]) {
                    return;
                }
                MKSingeUserCenterVC *vc = [MKSingeUserCenterVC new];
                vc.requestParams = dic;
                [self.recommendVC.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.commentModel.listMytArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[section];
    NSString *string = [NSString stringWithFormat:@"%@ %@",firstCommentModel.content,firstCommentModel.commentDate];
    return 18 + 1 + [NSString textHitWithStirng:string font:15 widt:kScreenWidth-60-46] + 11+10;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView.backgroundColor = [UIColor clearColor];
    //一级标题数据从这里进去
//    NonHoveringHeaderView *header = nil;
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[section];
//    {//第一种创建方式
    NonHoveringHeaderView *header = [[NonHoveringHeaderView alloc]initWithReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)
                                                              withData:firstCommentModel];
    [header setBackgroundColor:[UIColor redColor]];
    [header.backgroundView setBackgroundColor:[UIColor redColor]];
    UIView *backView = [header.subviews firstObject];
    backView.backgroundColor = kClearColor;
    DLog(@"图层数量%@",header.subviews[0]);
        @weakify(self)
        header.headerBlock = ^(NSDictionary *dic) {
            @strongify(self)
            if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid isEqualToString:dic[@"videoid"]]) {
//
                if (super.block) {
                    super.block(self.closeBtn);
                   }
                  [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 4;
                return;
            }
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            NSString *nickName = [userDefault objectForKey:@"nickName"];
//            if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.nickName isEqualToString:nickName]) {

//            } else {
                MKSingeUserCenterVC *vc = [MKSingeUserCenterVC new];
                vc.requestParams = dic;
                [self.recommendVC.navigationController pushViewController:vc animated:YES];
//            }
            
        };
        [header actionBlock:^(id data) {
            @strongify(self)
            if(![MKTools mkLoginIsYESWith:self]) {
                return;
            }
            self.commentId = firstCommentModel.commentId;
            self.ID = firstCommentModel.ID;
            self.replyName = firstCommentModel.nickname;
            if ([data isKindOfClass:NSDictionary.class]) {//
                NSDictionary *dic = (NSDictionary *)data;
                if ([dic[@"sender"] isMemberOfClass:UIControl.class]){
                    if ([MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid.integerValue == firstCommentModel.userId) {
                        self.section = section;
                        self.row = -1;
                        UIControl *control = (UIControl *)dic[@"sender"];
                        self.firstCommentModel = dic[@"model"];
                        [NSObject showSYSActionSheetTitle:nil
                                                  message:nil
                                          isSeparateStyle:YES
                                              btnTitleArr:@[@"回复",@"复制",@"删除",@"取消"]
                                           alertBtnAction:@[@"Reply",@"CopyIt",@"SureDeleteSelfComment",@"Cancel"]
                                                 targetVC:self
                                                   sender:control
                                             alertVCBlock:^(id data) {
                            //DIY
                        }];
                    }else{
                        self.section = section;
                        self.row = -1;
                        UIControl *control = (UIControl *)dic[@"sender"];
                        self.firstCommentModel = dic[@"model"];
                        [NSObject showSYSActionSheetTitle:nil
                                                  message:nil
                                          isSeparateStyle:YES
                                              btnTitleArr:@[@"回复",@"复制",@"取消"]
                                           alertBtnAction:@[@"Reply",@"CopyIt",@"Cancel"]
                                                 targetVC:self
                                                   sender:control
                                             alertVCBlock:^(id data) {
                            //DIY
                        }];
                    }
                }
            }
        }];
        [[header.supportBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.commentId = firstCommentModel.commentId;
            self.ID = firstCommentModel.ID;
            [self likeBtnClickAction:header.supportBtn model:firstCommentModel isChild:NO icon:header.heartIcon countLab:header.countLab];
        }];
//    }

    header.tableView = tableView;
    header.section = section;

    return header;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        [_tableView registerClass:NonHoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)];
        [_tableView registerClass:HoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(HoveringHeaderView.class)];
        _tableView.mj_header = self.tableViewHeader;
        @weakify(self)
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMore];
        }];
        [footer setTitle:@"没有更多评论" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.textColor = HEXCOLOR(0x8391af);
        _tableView.mj_footer = footer;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭


        [self.view addSubview:_tableView];
        extern CGFloat LZB_TABBAR_HEIGHT;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.offset(55);
            make.bottom.equalTo(self.botView.mas_top);
        }];
    }return _tableView;
}

- (UILabel *)commentCountLab {
    if (!_commentCountLab) {
        _commentCountLab = UILabel.new;
        [self.view addSubview:self.countBgImageView];
        [self.view addSubview:_commentCountLab];
        [_commentCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(12);
            make.height.offset(18);
        }];
        _commentCountLab.textColor = UIColor.blackColor;
        _commentCountLab.font = [UIFont systemFontOfSize:15];
        _commentCountLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.offset(0);
            make.height.width.offset(15+18*2);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = COLOR_HEX(0x999999, 1);
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.offset(0);
            make.height.offset(0.5);
            make.top.equalTo(_commentCountLab.mas_bottom).offset(12);
        }];
       
        [self.countBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_commentCountLab.mas_left).offset(0);
            make.height.offset(9);
            make.bottom.equalTo(_commentCountLab.mas_bottom).offset(0);
            make.width.equalTo(@(20));
        }];
        
    }
    return _commentCountLab;
}

-(UIImageView *)countBgImageView {
    if(_countBgImageView == nil) {
        _countBgImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"comment_count_bg"]];
    }
    return _countBgImageView;
}


-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        [_closeBtn setImage:KIMG(@"coment_close_white")
                   forState:UIControlStateNormal];
        [_closeBtn addTarget:self
                      action:@selector(closeBtnClickEvent:)
            forControlEvents:UIControlEventTouchUpInside];

    }return _closeBtn;
}

-(NSMutableArray<MKFirstCommentModel *> *)firstCommentModelMutArr{
    if (!_firstCommentModelMutArr) {
        _firstCommentModelMutArr = NSMutableArray.array;
    }return _firstCommentModelMutArr;
}

- (UIView *)keyboardTopView {
    if (!_keyboardTopView) {
        _keyboardTopView = UIView.new;
        _keyboardTopView.backgroundColor = HEXCOLOR(0xFFFFFF);
        _keyboardTopView.alpha = 0;
        
        // 阴影颜色
        _keyboardTopView.layer.shadowColor = UIColor.grayColor.CGColor;
           // 阴影偏移，默认(0, -3)
        _keyboardTopView.layer.shadowOffset = CGSizeMake(0,0);
           // 阴影透明度，默认0
        _keyboardTopView.layer.shadowOpacity = 0.2;
           // 阴影半径，默认3
        _keyboardTopView.layer.shadowRadius = 2;
        
//        if (self.isRecommend) {
//            [self.homeVC.view addSubview:_keyboardTopView];
//        } else {
//            [self.view addSubview:_keyboardTopView];
//        }
        [UIApplication.sharedApplication.keyWindow addSubview:_keyboardTopView];
        self.icon = UIImageView.new;
        [_keyboardTopView addSubview:self.icon];
        self.icon.frame = CGRectMake(13, 14, 34, 34);
        self.icon.layer.cornerRadius = 17;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.headImage]
        placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
        self.icon.layer.masksToBounds = 1;

    }
    return _keyboardTopView;
}

- (UITextField *)field{
    if(!_field){
        _field = UITextField.new;
        _field.backgroundColor = COLOR_HEX(0xEFEFF4, 1);
        _field.textColor = HEXCOLOR(0x000000);
        _field.delegate = self;
        [_field addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
        _field.font = [UIFont systemFontOfSize:13];
        _field.layer.cornerRadius = 17;
        _field.frame = CGRectMake(64, 14, SCREEN_W-64-20, 34);
        _field.returnKeyType = UIReturnKeySend;
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"我也说几句" attributes:@{NSForegroundColorAttributeName:HEXCOLOR(0x999999),
                                   NSFontAttributeName:_field.font
        }];
        _field.attributedPlaceholder = attrString;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 34)];
        label.text = @"    ";
        _field.leftView = label;
        _field.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _field;
}

- (UIView *)botView {
    if (!_botView) {
        _botView = UIView.new;
        _botView.backgroundColor = HEXCOLOR(0xFFFFFF);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alertField)];
        [_botView addGestureRecognizer:tap];
        
        // 阴影颜色
        _botView.layer.shadowColor = UIColor.grayColor.CGColor;
           // 阴影偏移，默认(0, -3)
        _botView.layer.shadowOffset = CGSizeMake(0,0);
           // 阴影透明度，默认0
        _botView.layer.shadowOpacity = 0.2;
           // 阴影半径，默认3
        _botView.layer.shadowRadius = 2;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(64, SCALING_RATIO(14), SCREEN_WIDTH-64-20, SCALING_RATIO(34))];
        view.backgroundColor = COLOR_HEX(0xEFEFF4, 1);
        view.layer.cornerRadius = SCALING_RATIO(17);
        [_botView addSubview:view];
    }
    return _botView;
}
- (UIImageView *)botIcon {
    if (!_botIcon) {
        _botIcon = UIImageView.new;
        _botIcon.frame = CGRectMake(13, SCALING_RATIO(14), SCALING_RATIO(34), SCALING_RATIO(34));
        _botIcon.layer.cornerRadius = SCALING_RATIO(17);
        _botIcon.userInteractionEnabled = 1;
        [_botIcon sd_setImageWithURL:[NSURL URLWithString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.headImage]
         placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
        _botIcon.layer.masksToBounds = 1;
    }
    return _botIcon;
}
- (UILabel *)botLab {
    if (!_botLab) {
        _botLab = UILabel.new;
        _botLab.textColor = HEXCOLOR(0x999999);
        _botLab.text = @"我也说几句";
        _botLab.font = [UIFont systemFontOfSize:13];
        _botLab.frame = CGRectMake(87, 0, SCREEN_W - 87-13, SCALING_RATIO(62));
    }
    return _botLab;
}
- (UIView *)coverKeyboardView {
    if (!_coverKeyboardView) {
        _coverKeyboardView = UIView.new;
        _coverKeyboardView.backgroundColor = UIColor.whiteColor;
        _coverKeyboardView.alpha = 0;
//        if (self.isRecommend) {
//            [self.homeVC.view addSubview:_coverKeyboardView];
//        } else {
//            [self.recommendVC.view addSubview:_coverKeyboardView];
//        }
        [UIApplication.sharedApplication.keyWindow addSubview:_coverKeyboardView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverKeyboardView)];
        [_coverKeyboardView addGestureRecognizer:tap];
    }
    return _coverKeyboardView;
}
- (void)tapCoverKeyboardView {
    [self.field endEditing:1];
}
- (void)alertField {
    self.isReplyComment = NO;
    self.field.placeholder = @"我也说几句";
    if ([MKTools mkLoginIsYESWith:self]) {
        [self.field becomeFirstResponder];
    }
}
@end
