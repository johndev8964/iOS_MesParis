//
//  HomeViewController.h
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *m_mesParis;
    UITableView *m_menuTable;
    NSMutableArray *m_finishBet;
    UIView      *m_sideMenu;
    UIButton    *m_conn;
    UIView *m_graghView;
    
    UIButton    *m_newBet;
    NSMutableArray *dataForPlot;
}

@property (nonatomic, retain) IBOutlet UILabel     *m_budget;
@property (nonatomic, retain) IBOutlet UITableView *m_mesParis;
@property (nonatomic, retain) IBOutlet UITableView *m_menuTable;
@property (nonatomic, retain) IBOutlet UIButton    *m_conn;
@property (nonatomic, retain) NSMutableArray       *m_finishBet;
@property (nonatomic, retain) IBOutlet UIView      *m_sideMenu;
@property (nonatomic, retain) IBOutlet UIView      *m_mainView;
@property (nonatomic, retain) IBOutlet UIView      *m_graphView;
@property (nonatomic, retain) IBOutlet UIButton    *m_newBet;

@property (nonatomic) int risk;
@property (nonatomic) int budget;
@property (nonatomic) int max_budget;

- (IBAction)goNew:(id)sender;
- (IBAction)goStats:(id)sender;
- (IBAction)gotoSideMenu:(id)sender;
- (IBAction)goLogin:(id)sender;

@end
