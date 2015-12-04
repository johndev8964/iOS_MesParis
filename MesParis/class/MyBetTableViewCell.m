//
//  MyBetTableViewCell.m
//  MesParis
//
//  Created by Liming on 8/11/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "AppDelegate.h"
#import "MyBetTableViewCell.h"
#import "ConfigurationViewController.h"

@implementation MyBetTableViewCell

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

- (IBAction)setVic:(id)sender {
    if (m_vic.on == true) {
        m_vic.enabled = false;
        UIAlertView *vicAlert = [[UIAlertView alloc] initWithTitle:nil
                                                           message:@"Votre pari est-til gagnant?" delegate:self cancelButtonTitle:@"Oui" otherButtonTitles:@"Non", nil];
        [vicAlert show];
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
     BetRecord *updateRecord = [[BetRecord alloc] init];
    for (BetRecord *record in g_BetModel.dataArray) {
        if (record.index == m_vic.tag) {
            updateRecord.index = (int)m_vic.tag;
            updateRecord.budget = record.budget;
            updateRecord.bet = record.bet;
            updateRecord.risk = record.risk;
            updateRecord.date = m_date.text;
            updateRecord.team = m_team.text;
            updateRecord.item = record.item;
            updateRecord.odd = record.odd;
        }
    }
    if (buttonIndex == 0) {
        // do something here...
        updateRecord.vic = 3;
        float earn = updateRecord.bet * updateRecord.odd - updateRecord.bet;
        updateRecord.budget = updateRecord.budget + earn;
        updateRecord.earn = updateRecord.earn + earn;
    } else {
        updateRecord.vic = 0;
        float lost = updateRecord.bet;
        updateRecord.budget = updateRecord.budget - lost;
        updateRecord.lost = updateRecord.lost + lost;
    }
    
    [g_BetModel updateArray:updateRecord];
}

- (void) displayMyBet:(NSString *)date team:(NSString *)team vic:(int)vic index:(int)index{
    [m_date setText:date];
    [m_team setFont:[UIFont boldSystemFontOfSize:13]];
    [m_team setText:team];
    m_vic.tag = index;
    if (vic == 1) {
        //[m_vic isOpaque];
    } else {
        m_vic.on = true;
        m_vic.enabled = false;
    }
}

@end
