//
//  MyBetTableViewCell.h
//  MesParis
//
//  Created by Liming on 8/11/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBetTableViewCell : UITableViewCell <UIAlertViewDelegate>{
    UILabel *m_date;
    UILabel *m_team;
    UISwitch *m_vic;
}

@property (nonatomic, retain) IBOutlet UILabel *m_date;
@property (nonatomic, retain) IBOutlet UILabel *m_team;
@property (nonatomic, retain) IBOutlet UISwitch *m_vic;

- (IBAction)setVic:(id)sender;

- (void) displayMyBet:(NSString *) date team:(NSString *) team vic:(int) vic index:(int) index;

@end
