//
//  CommentPopUpVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpVC+VM.h"

@implementation CommentPopUpVC (VM)
///GET 初始化用户评论列表
-(void)netWorking_MKCommentQueryInitListGET{
    NSDictionary *easyDict = @{
        @"pageNum":@(self.commentPage),
        @"pageSize":@"10",
        @"videoId":self.videoID
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKCommentQueryInitListGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
//        NSLog(@"%@",response.reqResult);
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                NSArray *array = [MKFirstCommentModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"list"]];
                if (self.commentPage == 1) {
                    [self.tableView.mj_header endRefreshing];
                    self.tableView.mj_footer.hidden = 0;
                    self.commentModel = [MKCommentModel mj_objectWithKeyValues:response.reqResult];
                    [self updateCommentCount:self.commentModel.total.intValue];
//                    self.commentCountLab.text = [NSString stringWithFormat:@"%d条评论",self.commentModel.total.intValue];
//                    self.commentNumStr = self.commentModel.total.stringValue;
//                    NSLog(@"%d",self.commentModel.endRow.intValue);
                    
                    self.commentModel.listMytArr = [MKFirstCommentModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"list"]];
                
                } else {
                    [self.commentModel.listMytArr addObjectsFromArray:array];
                }
                for (MKFirstCommentModel *model in self.commentModel.listMytArr) {
                    model.PreMax = 3;
                    model.isFullShow = NO;
                    model._hasMore = model.child.count > 3 ? YES : NO;
                  
                }
                if (array.count < 10 || self.commentPage == self.commentModel.pages.integerValue) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
                [self dealData];
//                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
            }
        } else {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            if (self.commentPage > 1) {
                self.commentPage -- ;
            }
        }
    }];
}
- (void)dealData {
    for (int i = 0;i < self.commentModel.listMytArr.count;i++) {
        MKFirstCommentModel *first = self.commentModel.listMytArr[i];
        for (MKChildCommentModel *child in first.child) {
            if (child.toReplyUserId == first.userId) {
                child.toReplyUserName = @"";
            }
            NSString *replyString = child.toReplyUserName.length ? @"回复 " : @"";
            NSString *nameString = child.toReplyUserName.length ? [NSString stringWithFormat:@"%@:",child.toReplyUserName] : @"";
            NSString *contentString = child.content;
            NSString *dateString = child.commentDate;
            child.contentShow = [NSString stringWithFormat:@"%@%@%@ %@",replyString,nameString,contentString,dateString];
        }
    }
}
///POST 评论视频
-(void)netWorking_MKCommentVideoPOST{//
    NSDictionary *easyDict = @{
        @"content":self.field.text,//内容
        @"videoId":self.videoID//视频id
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKCommentVideoPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            self.commentNumStr = @"";
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                self.commentVideoModel = [MKCommentVideoModel mj_objectWithKeyValues:response.reqResult];
                MKFirstCommentModel *firstCommentModel = MKFirstCommentModel.new;
                firstCommentModel.commentDate = self.commentVideoModel.commentDate;
                firstCommentModel.commentId = self.commentVideoModel.commentId;
                firstCommentModel.content = self.commentVideoModel.content;
                firstCommentModel.headImg = self.commentVideoModel.headImg;
                firstCommentModel.ID = self.commentVideoModel.ID;
                firstCommentModel.isPraise = self.commentVideoModel.isPraise;
                firstCommentModel.nickname = self.commentVideoModel.nickname;
                firstCommentModel.parentId = self.commentVideoModel.parentId;
                firstCommentModel.praiseNum = self.commentVideoModel.praiseNum;
                firstCommentModel.replyNum = self.commentVideoModel.replyNum;
                firstCommentModel.userId = self.commentVideoModel.userId.integerValue;
                firstCommentModel.videoId = self.commentVideoModel.videoId;
                firstCommentModel.isVip = self.commentVideoModel.isVip;
                [self.commentModel.listMytArr insertObject:firstCommentModel
                                                   atIndex:0];
                if (self.commentModel.listMytArr.count) {
                    [self.tableView ly_hideEmptyView];
                }else{
                    [self.tableView ly_showEmptyView];
                }
                [self dealData];
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                self.tableView.mj_footer.hidden = YES;
//                self.commentCountLab.text = [NSString stringWithFormat:@"%ld条评论",self.commentCountLab.text.integerValue + 1];
                [self updateCommentCount:self.commentCountLab.text.intValue + 1];
                [[NSNotificationCenter defaultCenter] postNotificationName:MKRefreshCommentNotification object:@"1"];
                
                if (self.CommentPopUpBlock) {
                    self.CommentPopUpBlock(@(self.commentCountLab.text.integerValue));
                }
            }else if([response.reqResult isKindOfClass:NSString.class]){
                
                [WHToast showMessage:response.reqResult
                            duration:1
                       finishHandler:nil];
                
            }
        }
    }];
}
///POST 回复评论
-(void)netWorking_MKCommentReplyCommentPOSTWithCommentId:(NSString *)commentId
                                                      ID:(NSString *)ID
                                                 content:(NSString *)content section:(NSInteger)section row:(NSInteger)row{//
    NSDictionary *easyDict = @{
        @"commentId":commentId,//第一级评论id
        @"id":ID,//当前节点id
        @"content":content
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKCommentReplyCommentPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            self.commentNumStr = @"";
            MKChildCommentModel *child = [MKChildCommentModel mj_objectWithKeyValues:response.reqResult];
            MKFirstCommentModel *fModel = self.commentModel.listMytArr[section];
            if (child.toReplyUserId == fModel.userId) {
                child.toReplyUserName = @"";
            }
            NSString *replyString = child.toReplyUserName.length ? @"回复 " : @"";
            NSString *nameString = child.toReplyUserName.length ? [NSString stringWithFormat:@"%@:",child.toReplyUserName] : @"";
            NSString *contentString = child.content;
            NSString *dateString = child.commentDate;
            child.contentShow = [NSString stringWithFormat:@"%@%@%@ %@",replyString,nameString,contentString,dateString];
            if (row == -1) {
                //回复评论
                if (!fModel.child) {
                    fModel.child = NSMutableArray.new;
                }
                [fModel.child insertObject:child atIndex:0];
            } else {
                //回复回复
                [fModel.child insertObject:child atIndex:row + 1];
            }
            
            @weakify(self)
            [UIView performWithoutAnimation:^{
                @strongify(self)
                [self.tableView reloadSection:section withRowAnimation:UITableViewRowAnimationNone];
            }];
            
//            self.commentCountLab.text = [NSString stringWithFormat:@"%ld条评论",self.commentCountLab.text.integerValue + 1];
            [self updateCommentCount:self.commentCountLab.text.intValue + 1];
            [[NSNotificationCenter defaultCenter] postNotificationName:MKRefreshCommentNotification object:@"1"];
            
            if (self.CommentPopUpBlock) {
                self.CommentPopUpBlock(@(self.commentCountLab.text.integerValue));
            }
        }else if([response.reqResult isKindOfClass:NSString.class]){
            
            [WHToast showMessage:response.reqResult
                        duration:1
                   finishHandler:nil];
        }
    }];
}
///POST 删除评论
-(void)netWorking_MKCommentDelCommentPOSTWithCommentId:(NSString *)commentId
                                                    ID:(NSString *)ID{

    NSDictionary *easyDict = @{
        @"commentId":commentId,//第一级评论id
        @"id":ID,//被删除的当前评价id
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKCommentDelCommentPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            int r = 0;
            NSArray *arr_1 = [NSArray arrayWithArray:self.commentModel.listMytArr];
            for (MKFirstCommentModel *firstCommentModel in arr_1) {
                if ([firstCommentModel.ID isEqualToString:ID]) {
                    [self.commentModel.listMytArr removeObjectAtIndex:r];
                }
                r++;
                int t = 0;
                NSArray *arr_2 = [NSArray arrayWithArray:firstCommentModel.child];
                for (MKChildCommentModel *childCommentModel in arr_2) {
                    if ([childCommentModel.ID isEqualToString:ID]) {
                        [firstCommentModel.child removeObjectAtIndex:t];
                    }
                    t++;
                }
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = YES;
            
            NSInteger sum = 0;
            for (MKFirstCommentModel *first in self.commentModel.listMytArr) {
                if (first){
                    sum += first.child.count + 1;
                }
            }
//            self.commentCountLab.text = [NSString stringWithFormat:@"%ld条评论",sum];
            [self updateCommentCount:sum];
            [[NSNotificationCenter defaultCenter] postNotificationName:MKRefreshCommentNotification object:@"-1"];
            [[NSNotificationCenter defaultCenter] postNotificationName:MKRefreshCommentNotification object:self.commentNumStr];
            
            if (self.CommentPopUpBlock) {
                self.CommentPopUpBlock(@(sum));
            }
        }
    }];
}
///POST 点赞或取消点赞
-(void)netWorking_MKCommentSetPraisePOSTWithCommentId:(NSString *)commentId
                                                   ID:(NSString *)ID model:(id)model isChild:(BOOL)isChild sender:(UIButton *)sender icon:(UIImageView *)icon countLab:(UILabel *)countLab{
    ///
    if(![MKTools mkLoginIsYESWith:self]) {
        return;
    }
    NSDictionary *easyDict = @{
        @"commentId":commentId,//第一级评论id
        @"id":ID,
    };
    sender.userInteractionEnabled = 0;
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKCommentSetPraisePOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
//            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!1--%@",response.reqResult);
            sender.userInteractionEnabled = YES;//防止多次点击
            NSNumber *operateType = response.reqResult[@"operateType"];//"operateType": 1,  —操作类型，0点赞 1取消点赞
            NSNumber *praiseNum = response.reqResult[@"praiseNum"];//"praiseNum": 1  —总点赞数
//            sender.thumpNum = praiseNum.intValue;
//            [sender setThumbWithSelected:!operateType.boolValue
//                                thumbNum:praiseNum.intValue
//                               animation:YES];
            icon.image = KIMG(operateType.boolValue ? @"喜欢-白心" : @"喜欢-红心");
            countLab.text = [NSString stringWithFormat:@"%ld",praiseNum.integerValue];
            if (isChild) {
                MKChildCommentModel *child = (MKChildCommentModel *)model;\
                child.praiseNum = praiseNum;
                child.isPraise = [NSNumber numberWithBool:!operateType.boolValue];
            } else {
                MKFirstCommentModel *first = (MKFirstCommentModel *)model;
                first.praiseNum = praiseNum;
                first.isPraise = [NSNumber numberWithBool:!operateType.boolValue];
            }
        }
    }];
}

-(void)updateCommentCount:(int)count {
    self.commentCountLab.text  = [NSString stringWithFormat:@"%d条评论",count];
    NSString *contStr = [NSString stringWithFormat:@"%d",count];
    CGRect rect = [contStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    CGFloat bgWidth = MAX(rect.size.width, 15);
    [self.countBgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(bgWidth));
    }];
}

@end
