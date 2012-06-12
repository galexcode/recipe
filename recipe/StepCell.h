//
//  StepCell.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/11/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stepIndentifier;
@property (weak, nonatomic) IBOutlet UILabel *stepDescription;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryArrow;

@end
