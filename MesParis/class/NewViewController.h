//
//  NewViewController.h
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UITableView *m_menuTable;
    UIView      *m_sideMenu;
    UIButton    *m_conn;
    UIButton    *m_football;
    UIButton    *m_busketball;
    UIButton    *m_tennisball;
    UIButton    *m_multi;
}

@property (nonatomic, retain) IBOutlet UILabel *m_betandrisk;
@property (nonatomic, retain) IBOutlet UITextField *m_bet;
@property (nonatomic, retain) IBOutlet UITextField *m_title;
@property (nonatomic, retain) IBOutlet UITextField *m_odd;
@property (nonatomic, retain) IBOutlet UITableView *m_menuTable;
@property (nonatomic, retain) IBOutlet UIView      *m_sideMenu;
@property (nonatomic, retain) IBOutlet UIButton    *m_conn;
@property (nonatomic, retain) IBOutlet UIView      *m_mainView;
@property (nonatomic, retain) NSString *m_item;

@property (nonatomic, retain) IBOutlet UIButton    *m_football;
@property (nonatomic, retain) IBOutlet UIButton    *m_basketball;
@property (nonatomic, retain) IBOutlet UIButton    *m_tennis;
@property (nonatomic, retain) IBOutlet UIButton    *m_multi;

- (IBAction)goHome:(id)sender;
- (IBAction)selItem:(id)sender;
- (IBAction)moveScreen:(id)sender;
- (IBAction)goLogin:(id)sender;


@end
