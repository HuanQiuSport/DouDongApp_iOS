//
//  RuleItemCell.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/5.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "RuleItemCell.h"

@interface RuleItemCell()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation RuleItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.countLabel.layer.cornerRadius = 8.5;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.backgroundColor = COLOR_HEX(0xFFB0CA, 0.2);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setContent:(NSString *)content index:(NSInteger)index {
    self.countLabel.text = [NSString stringWithFormat:@"%ld",index];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.minimumLineHeight = 13;
    paraStyle.maximumLineHeight = 13;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                          NSForegroundColorAttributeName: HEXCOLOR(0x6F6F7A),
                          NSParagraphStyleAttributeName: paraStyle};
    
    self.contentLabel.attributedText = [[NSAttributedString alloc] initWithString:content attributes:dic];
}

@end
