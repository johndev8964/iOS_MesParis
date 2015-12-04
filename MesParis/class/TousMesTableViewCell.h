//
//  TousMesTableViewCell.h
//  MesParis
//
//  Created by Liming on 8/11/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TousMesTableViewCell : UITableViewCell {
    UILabel *m_date;
    UILabel *m_team;
    UILabel *m_vic;
}

@property (nonatomic, retain) IBOutlet UILabel *m_date;
@property (nonatomic, retain) IBOutlet UILabel *m_team;
@property (nonatomic, retain) IBOutlet UILabel *m_vic;

- (void) displayTousMes:(NSString *) date team:(NSString *) team vic:(int) vic;

@end
