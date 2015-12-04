//
//  AllBetViewController.h
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBetViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    UITableView *m_tousParis;
    NSMutableArray *m_finishBet;
    UITableView *m_menuTable;
    UIView      *m_sideMenu;
    UIButton    *m_conn;
}

@property (nonatomic, retain) IBOutlet UITableView *m_tousParis;
@property (nonatomic, retain) NSMutableArray       *m_finishBet;
@property (nonatomic, retain) IBOutlet UITableView *m_menuTable;
@property (nonatomic, retain) IBOutlet UIView      *m_sideMenu;
@property (nonatomic, retain) IBOutlet UIButton    *m_conn;
@property (nonatomic, retain) IBOutlet UIView      *m_mainView;
- (IBAction)goNew:(id)sender;
- (IBAction)goLogin:(id)sender;
@end
