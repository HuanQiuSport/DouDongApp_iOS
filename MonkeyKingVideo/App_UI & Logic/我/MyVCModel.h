//
//  MyVCModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/22.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EnjoyVideoListModel : NSObject

@end

@interface PubLishVideoListModel : NSObject

@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *authorId;
@property(nonatomic,strong)NSNumber *commentNum;
@property(nonatomic,strong)NSString *headImage;
@property(nonatomic,strong)NSNumber *playNum;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSNumber *publishTime;
@property(nonatomic,strong)NSNumber *videoId;
@property(nonatomic,strong)NSString *videoIdcUrl;
@property(nonatomic,strong)NSString *videoImg;
@property(nonatomic,strong)NSNumber *videoSize;
@property(nonatomic,strong)NSNumber *videoTime;
@property(nonatomic,strong)NSString *videoTitle;

@end

@interface MyVCModel : BaseModel

@property(nonatomic,strong)NSNumber *account;
@property(nonatomic,strong)NSString *accountNo;
@property(nonatomic,strong)NSNumber *age;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSNumber *balance;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *constellation;
@property(nonatomic,strong)NSNumber *createTime;
@property(nonatomic,strong)NSNumber *Delete;
@property(nonatomic,strong)NSString *education;
@property(nonatomic,strong)NSMutableArray <EnjoyVideoListModel *>*enjoyVideoListMutArr;//
@property(nonatomic,strong)NSNumber *fansNum;
@property(nonatomic,strong)NSNumber *focusNum;
@property(nonatomic,strong)NSNumber *goldNumber;
@property(nonatomic,strong)NSString *headImage;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSString *idCard;
@property(nonatomic,strong)NSString *idName;
@property(nonatomic,strong)NSString *inviteCode;
@property(nonatomic,strong)NSNumber *lastLoginTime;
@property(nonatomic,strong)NSNumber *monIncome;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSNumber *originType;
@property(nonatomic,strong)NSNumber *phone;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSMutableArray <PubLishVideoListModel *>*pubLishVideoListMutArr;//
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSNumber *sex;
@property(nonatomic,strong)NSNumber *updateUser;
@property(nonatomic,strong)NSNumber *valid;
@property(nonatomic,strong)NSNumber *walletId;
@property(nonatomic,strong)NSNumber *msgNum;
@end

NS_ASSUME_NONNULL_END

//{
//    author = "窦英韶620";
//    authorId = 1288735278600605698;
//    commentNum = 0;
//    headImage = "http://www.akixr.top:9000/bucket1-uat/IMAGES/app-user/headimg/n1@2x.png";
//    playNum = 0;
//    praiseNum = 1;
//    publishTime = 1596169607000;
//    videoId = 1288680931422425090;
//    videoIdcUrl = "http://www.akixr.top:9000/bucket1-uat/VIDEOS/2020073011/1288474681849995266/mp4/WASDF.mp4";
//    videoImg = "http://www.akixr.top:9000/bucket1-uat/VIDEOS/2020073011/1288474681849995266/mp4/WASDF.jpeg";
//    videoSize = 7234003;
//    videoTime = 40;
//    videoTitle = "磨磨叽叽o○";
//}
//
//{
//    account = 13408031107;
//    accountNo = "";
//    age = 11;
//    area = "浙江省-杭州市-建德市";
//    balance = 0;
//    birthday = "2008-10-30";
//    constellation = "";
//    createTime = 1596097103000;
//    delete = 0;
//    education = "";
//    enjoyVideoList =     (
//    );
//    fansNum = 0;
//    focusNum = 2;
//    goldNumber = 0;
//    headImage = "http://www.akixr.top:9000/bucket1-uat/IMAGES/2020073115/1288750775283011585/jpg/senba_empty_20200731141429_0.jpg";
//    id = 1288750775283011585;
//    idCard = "";
//    idName = "";
//    inviteCode = 7B209B;
//    lastLoginTime = 1596179574000;
//    monIncome = "";
//    nickname = 45112;
//    originType = 0;
//    phone = 13408031107;
//    praiseNum = 0;
//    pubLishVideoList =     (
//                {
//            author = "窦英韶620";
//            authorId = 1288735278600605698;
//            commentNum = 0;
//            headImage = "http://www.akixr.top:9000/bucket1-uat/IMAGES/app-user/headimg/n1@2x.png";
//            playNum = 0;
//            praiseNum = 1;
//            publishTime = 1596169607000;
//            videoId = 1288680931422425090;
//            videoIdcUrl = "http://www.akixr.top:9000/bucket1-uat/VIDEOS/2020073011/1288474681849995266/mp4/WASDF.mp4";
//            videoImg = "http://www.akixr.top:9000/bucket1-uat/VIDEOS/2020073011/1288474681849995266/mp4/WASDF.jpeg";
//            videoSize = 7234003;
//            videoTime = 40;
//            videoTitle = "磨磨叽叽o○";
//        }
//    );
//    remark = "546-4126";
//    sex = 2;
//    updateUser = 0;
//    valid = 1;
//    walletId = 1288750775308177410;
//}
