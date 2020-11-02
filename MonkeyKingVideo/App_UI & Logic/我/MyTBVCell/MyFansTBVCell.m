//
//  MyFansTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyFansTBVCell.h"

@interface MyFansTBVCell ()

@end

@implementation MyFansTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    MyFansTBVCell *cell = (MyFansTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[MyFansTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:ReuseIdentifier
                                           marginX:3
                                           marginY:10];
        cell.contentView.backgroundColor = kRedColor;
//        [UIView cornerCutToCircleWithView:cell.contentView
//                          AndCornerRadius:5.f];
//        [UIView colourToLayerOfView:cell.contentView
//                         WithColour:kBlackColor
//                     AndBorderWidth:.1f];
    }return cell;
}

-(void)drawRect:(CGRect)rect{

}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCREEN_HEIGHT / 18;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@" "]
                      placeholderImage:KIMG(@"用户头像")];
    self.textLabel.text = @"Test";
    self.detailTextLabel.text = @"test";
}

@end
