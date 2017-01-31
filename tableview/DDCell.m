//
//  DDCell.m
//  tableview
//
//  Created by DengOC on 2017/1/28.
//  Copyright © 2017年 sf. All rights reserved.
//

#import "DDCell.h"

@implementation DDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * v = [UIView new];
        v.backgroundColor = [UIColor brownColor];
        //  self.selected = YES  Cell 显示的颜色
        self.multipleSelectionBackgroundView = v;
        //  self.selected = YES  钩 显示的颜色
        self.tintColor = [UIColor yellowColor];
    }
    return self;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIView * v in self.subviews) {
        if ( [v isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")] ) {
            
            for (UIView * v2  in v.subviews) {
                if ( [v2 isKindOfClass:[UIImageView class]]) {
                    UIImageView *  imgView = (UIImageView *)v2;
                    
                    self.selected ? :[imgView setImage:[UIImage imageNamed:@"weixuanzhong_icon"]] ;
                    
                }
            }
            
        }
    }

    
}
-(void)layoutSubviews
{        for (UIView * v in self.subviews) {
        if ( [v isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")] ) {
            for (UIView * v2  in v.subviews) {
                if ( [v2 isKindOfClass:[UIImageView class]]) {
                    UIImageView *  imgView = (UIImageView *)v2;
                    self.selected ? [imgView setImage:[UIImage imageNamed:@"xuanzhong_icon"]] : [imgView setImage:[UIImage imageNamed:@"weixuanzhong_icon"]];


                }
            }
          
        }
    }
    
    
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
