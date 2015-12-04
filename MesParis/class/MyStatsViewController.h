//
//  MyStatsViewController.h
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStatsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UIScrollView *verticalScroll;
    UILabel *m_title;
    UILabel *m_perSucceess;
    UILabel *m_perFootball;
    UILabel *m_perBasketball;
    UILabel *m_perTennis;
    UILabel *m_perMulti;
    UILabel *m_perBefinit;
    UILabel *m_startBankroll;
    UILabel *m_allNum;
    UILabel *m_avgOdd;
    UILabel *m_perInvest;
    UILabel *m_totalBid;
    UILabel *m_bankRoll;
    
    UIView      *m_mainView;
    UITableView *m_menuTable;
    UIView      *m_sideMenu;
    UIButton    *m_conn;
    NSMutableArray *m_statsBet;
    
    UIView *m_graghView;
    
    UIButton    *m_newButton;
}

@property (nonatomic, retain) IBOutlet UIScrollView *verticalScroll;
@property (nonatomic, retain) IBOutlet UILabel *m_title;
@property (nonatomic, retain) IBOutlet UILabel *m_perSuccess;
@property (nonatomic, retain) IBOutlet UILabel *m_perFootball;
@property (nonatomic, retain) IBOutlet UILabel *m_perBasketball;
@property (nonatomic, retain) IBOutlet UILabel *m_perTennis;
@property (nonatomic, retain) IBOutlet UILabel *m_perMulti;
@property (nonatomic, retain) IBOutlet UILabel *m_perBenifit;
@property (nonatomic, retain) IBOutlet UILabel *m_startBankroll;
@property (nonatomic, retain) IBOutlet UILabel *m_allNum;
@property (nonatomic, retain) IBOutlet UILabel *m_avgOdd;
@property (nonatomic, retain) IBOutlet UILabel *m_perInvest;
@property (nonatomic, retain) IBOutlet UILabel *m_totalBid;
@property (nonatomic, retain) IBOutlet UILabel *m_bankRoll;

@property (nonatomic, retain) IBOutlet UIView      *m_mainView;
@property (nonatomic, retain) IBOutlet UITableView *m_menuTable;
@property (nonatomic, retain) IBOutlet UIView      *m_sideMenu;
@property (nonatomic, retain) IBOutlet UIButton    *m_conn;
@property (nonatomic, retain) NSMutableArray       *m_statsBet;

@property (nonatomic, retain) IBOutlet UIView *m_graphView;
@property (nonatomic, retain) IBOutlet UIButton    *m_newButton;

@property (nonatomic) int max_budget;

- (IBAction)goNew:(id)sender;
- (IBAction)goParis:(id)sender;
- (IBAction)goLogin:(id)sender;

@end
