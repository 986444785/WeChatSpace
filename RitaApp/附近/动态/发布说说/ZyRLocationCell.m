//
//  ZyRLocationCell.m
//  SuiYu
//
//  Created by BBC on 16/3/30.
//  Copyright © 2016年 陈伟滨. All rights reserved.
//

#import "ZyRLocationCell.h"

@implementation ZyRLocationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchbtnClick:(id)sender {

    UISwitch * switchbtn = (UISwitch *)sender;
    if (switchbtn.on) { 

        ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];
        if (single.nearInfo) {
            self.locationLable.text = single.nearInfo;
        }else if (single.district){
            self.locationLable.text = [NSString stringWithFormat:@"%@ %@",single.city,single.district];
        }else{
            self.locationLable.text = @"";
        }
 
    }else{
    self.locationLable.text = @"显示位置";
    }

    NSLog(@"选择位置");

}

@end
