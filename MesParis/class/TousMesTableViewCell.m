//
//  TousMesTableViewCell.m
//  MesParis
//
//  Created by Liming on 8/11/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "TousMesTableViewCell.h"

@implementation TousMesTableViewCell

@synthesize m_date;
@synthesize m_team;
@synthesize m_vic;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) displayTousMes:(NSString *)date team:(NSString *)team vic:(int)vic {
    [m_date setText:date];
    [m_team setFont:[UIFont boldSystemFontOfSize:13]];
    [m_team setText:team];
    if(vic == 0) {
        [m_vic setText:@"Perdant"];
        m_vic.textColor = [UIColor redColor];
    }
    else {
        [m_vic setText:@"Gagnant"];
        m_vic.textColor = [UIColor greenColor];
    }
}

@end
