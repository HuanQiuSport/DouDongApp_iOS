//
//  MKWithdrawSucessView.m
//  MonkeyKingVideo
//
//  Created by george on 2020/9/23.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKWithdrawSucessView.h"

@interface MKWithdrawSucessView()

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *moneyabel;

@end

@implementation MKWithdrawSucessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeLabel = [[UILabel alloc]init];
        self.moneyabel = [[UILabel alloc]init];
        
       [self setupSelf];
    }
    return self;
}

- (void)setModel:(SuccessBalanceModel *)model{
    _model = model;
    NSLog(@"%@",model.arriveDate);
    NSLog(@"%@",model.money);
    self.timeLabel.text = [NSString stringWithFormat:@"预计到账时间%@",model.arriveDate];
    self.moneyabel.text = [NSString stringWithFormat:@"¥ %@",model.money];
}

-(void) setupSelf{
    //上方
    UIView *statusView =
    [self statusViewWithy:20
                imageName:@"withdraw_money"
                  desText:@"提现申请已提交"
                 desLabel:nil
                superView:self];
    
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(MAINSCREEN_WIDTH / 2 - 78, statusView.maxY + 5, 1, 31);
    line.backgroundColor = COLOR_RGB(76 ,82 , 95, 1);
    [self addSubview:line];
    
    UIView *timeView =
    [self statusViewWithy:line.maxY + 5
                imageName:@"withdraw_time"
                  desText:@"预计到账时间9月10日"
                 desLabel:self.timeLabel
                superView:self];
    
    //中间
    UIView *moneyView = [[UIView alloc]init];
    moneyView.backgroundColor = kBlackColor;
    moneyView.layer.cornerRadius = 5.0f;
    moneyView.layer.shadowColor = [UIColor blackColor].CGColor;
    moneyView.layer.shadowOpacity = 0.6f;
    moneyView.layer.shadowOffset = CGSizeMake(2.0f,5.0f);
    moneyView.layer.shadowRadius = 15.0f;
    moneyView.layer.masksToBounds = NO;
    moneyView.frame = CGRectMake(20, timeView.maxY + 40, MAINSCREEN_WIDTH - 40, 120);
    [self addSubview:moneyView];
    
    UIView *detailsMoneyView =
    [self detailViewWithy:25
                titleText:@"提现金额："
                  desText:@"¥ 3.00"
                 desLabel:self.moneyabel
                superView:moneyView];
    
    [self detailViewWithy:detailsMoneyView.maxY+28
                titleText:@"提现方式："
                  desText:@"支付宝"
                 desLabel:nil
                superView:moneyView];
    
    //底部
    UILabel *promptLab1 = [[UILabel alloc]init];
    promptLab1.text = @"到账查询";
    promptLab1.font = kFontSize(12.3);
    promptLab1.textColor = kWhiteColor;
    promptLab1.frame = CGRectMake(20, moneyView.maxY+20, 200,20);
    [self addSubview:promptLab1];
    
    UILabel *promptLab2 = [[UILabel alloc]init];
    promptLab2.text = @"请查询绑定的支付宝是否到账";
    promptLab2.font = kFontSize(11.5);
    promptLab2.textColor = kWhiteColor;
    promptLab2.alpha = 0.6;
    promptLab2.frame = CGRectMake(20 , promptLab1.maxY+5, 200, 20);
    [self addSubview:promptLab2];
}

- (UIView *)statusViewWithy:(CGFloat) y
                  imageName:(NSString *)imageName
                    desText:(NSString *)desText
                   desLabel:(UILabel *)desLabel
                  superView:(UIView *)superView {
    
    UIView *statusView = [[UIView alloc]init];
    statusView.frame = CGRectMake(0, y, MAINSCREEN_WIDTH, 44);
    
    UIImageView *img = [[UIImageView alloc]initWithImage:KIMG(imageName)];
    img.frame = CGRectMake(MAINSCREEN_WIDTH / 2 - 100, 0, statusView.height, statusView.height);
    [statusView addSubview:img];
    
    UILabel *desLab = [[UILabel alloc]init];
    desLab.text = desText;
    desLab.font = kFontSize(16.8);
    desLab.textColor = kWhiteColor;
    desLab.frame = CGRectMake(img.maxX + 15, 0, 250, statusView.height);
    [statusView addSubview:desLab];
    
    if(desLabel){
        self.timeLabel = desLab;
    }
    
    [superView addSubview:statusView];
    
    return  statusView;
}

- (UIView *)detailViewWithy:(CGFloat) y
                  titleText:(NSString *)titleText
                    desText:(NSString *)desText
                   desLabel:(UILabel *)desLabel
                  superView:(UIView *)superView{
    
    NSLog(@"%@",desLabel);
    UIView *detailView = [[UIView alloc]init];
    detailView.backgroundColor = kBlackColor;
    detailView.frame = CGRectMake(0, y, MAINSCREEN_WIDTH - 40, 20);
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = titleText;
    titleLab.font = kFontSize(16.8);
    titleLab.textColor = kWhiteColor;
    titleLab.frame = CGRectMake(17, 0, 200, detailView.height);
    [detailView addSubview:titleLab];
    
    UILabel *desLab = [[UILabel alloc]init];
    desLab.text = desText;
    desLab.textAlignment = NSTextAlignmentRight;
    desLab.font = kFontSize(16.8);
    desLab.textColor = COLOR_HEX(0x929292, 1);
    desLab.frame = CGRectMake(detailView.width - 117 , 0, 100, detailView.height);
    [detailView addSubview:desLab];
    
    if(desLabel){
        self.moneyabel = desLab;
    }
    
    [superView addSubview:detailView];
    
    return detailView;
}

@end
