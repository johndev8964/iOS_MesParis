//
//  AppDelegate.h
//  MesParis
//
//  Created by Liming on 7/29/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBHandler.h"
#import "BetModel.h"
#import "ConfigurationViewController.h"


@class DataModel;
@class BetModel;
@class DBHandler;
@class ConfigurationViewController;
@class ViewController;
@class TheSidebarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *g_tabCtrl;
@property (nonatomic, retain) UINavigationController *navHome;
@property (nonatomic, retain) UINavigationController *navBet;
@property (nonatomic, retain) UINavigationController *navStats;
@property (nonatomic, retain) NSMutableArray         *sideMenu;
@property (nonatomic, retain) NSMutableArray         *sideIcon;

@property (nonatomic)         float      g_budget;
@property (nonatomic)         int      g_risk;
@property (nonatomic)         int      g_badgeNum;
- (void) goSideMenu;
- (void) showRootNavigation:(UINavigationController*)_navCtrl;
- (void) changeRoot;
- (void) initRootViewController;
- (void) initDB;
@end

extern AppDelegate *g_AppDelegate;
extern DBHandler *g_DBHandler;
extern BetModel  *g_BetModel;

