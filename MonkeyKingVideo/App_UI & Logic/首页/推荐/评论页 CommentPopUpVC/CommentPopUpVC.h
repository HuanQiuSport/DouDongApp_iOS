//
//  CommentPopUpVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"
#import "RecommendVC.h"
#import "HomeVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentPopUpVC : PopUpVC
@property(nonatomic,strong)UILabel *commentCountLab;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *videoID;
@property(nonatomic,strong)NSString *commentNumStr;
@property(nonatomic,assign)BOOL isClickExitBtn;
@property(nonatomic,strong)NSMutableArray <MKFirstCommentModel *>*firstCommentModelMutArr;
@property(nonatomic,copy)MKDataBlock CommentPopUpBlock;
@property(nonatomic,strong)MKCommentModel *commentModel;
@property(nonatomic,strong)MKCommentVideoModel *commentVideoModel;
@property(nonatomic,assign)NSInteger commentPage;
@property(nonatomic,strong)UIView *keyboardTopView;
@property(nonatomic,strong)UITextField *field;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIView *botView;
@property(nonatomic,strong)UIImageView *botIcon;
@property(nonatomic,strong)UILabel *botLab;
@property(nonatomic,strong)UIView *coverKeyboardView;
@property(nonatomic,strong) UIImageView *countBgImageView;


@property(nonatomic,weak)RecommendVC *recommendVC;
@property(nonatomic,weak)HomeVC *homeVC;
@property (nonatomic, assign) BOOL isRecommend;
-(void)commentPopUpActionBlock:(MKDataBlock)commentPopUpBlock;//在VM里面

@end

NS_ASSUME_NONNULL_END
