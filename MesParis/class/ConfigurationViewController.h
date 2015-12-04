//
//  ConfigurationViewController.h
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigurationViewController : UIViewController {
    UITextField *m_budget;
    UIButton    *m_risk;
    UILabel     *m_sel;
}

@property (nonatomic, retain) IBOutlet UITextField *m_budget;
@property (nonatomic, retain) IBOutlet UIButton    *m_risk;
@property (nonatomic, retain) IBOutlet UILabel    *m_sel;
@property (nonatomic) int cnt;
@property (nonatomic) int n_budget;
@property (nonatomic) int n_risk;


- (IBAction)goHome:(id)sender;
- (IBAction)selRisk:(id)sender;

@end
