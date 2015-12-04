//
//  AppDelegate.m
//  MesParis
//
//  Created by Liming on 7/29/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MyBetViewController.h"
#import "MyStatsViewController.h"
#import "NewViewController.h"
#import "ConfigurationViewController.h"
#import "DBHandler.h"
#import "BetModel.h"

AppDelegate *g_AppDelegate;
DBHandler *g_DBHandler = nil;
BetModel  *g_BetModel = nil;

@implementation AppDelegate

@synthesize g_tabCtrl;
@synthesize navHome;
@synthesize navBet;
@synthesize navStats;
@synthesize sideMenu;
@synthesize sideIcon;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    g_AppDelegate = self;
    [self initRootViewController];
    g_DBHandler = [DBHandler connectDB];
	sqlite3* dbHandler = [g_DBHandler getDbHandler];
    g_BetModel = [[BetModel alloc] initWithDBHandler:dbHandler];
    
    sideMenu = [[NSMutableArray alloc] initWithObjects:@"Bankroll",@"Mes Paris",@"Tous mes paris",@"Enregister un paris",@"Mes stats", nil];
    sideIcon = [[NSMutableArray alloc] initWithObjects:@"menu_icon1.png", @"menu_icon2.png", @"menu_icon2.png", @"menu_icon3.png", @"menu_icon4.png", nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ConfigurationViewController *confCtrl = [[ConfigurationViewController alloc] initWithNibName:@"ConfigurationViewController" bundle:nil];
    self.window.rootViewController = confCtrl;
 
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) initRootViewController {
     g_tabCtrl = [[UITabBarController alloc] init];
    HomeViewController *homeCtrl = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    navHome = [[UINavigationController alloc] initWithRootViewController:homeCtrl];
    UIImage *home = [UIImage imageNamed:@"tab_icon1.png"];
    [navHome.tabBarItem setImage:home];
    navHome.tabBarItem.title = @"Acueil";
    navHome.navigationBarHidden = true;
    
    MyBetViewController *betCtrl = [[MyBetViewController alloc] initWithNibName:@"MyBetViewController" bundle:nil];
    navBet = [[UINavigationController alloc] initWithRootViewController:betCtrl];
    UIImage *bet = [UIImage imageNamed:@"tab_icon2.png"];
    [navBet.tabBarItem setImage:bet];
    navBet.tabBarItem.title = @"Mes Paris";
    navBet.navigationBarHidden = true;
    
    MyStatsViewController *statsCtrl = [[MyStatsViewController alloc] initWithNibName:@"MyStatsViewController" bundle:nil];
    navStats = [[UINavigationController alloc] initWithRootViewController:statsCtrl];
    UIImage *stats = [UIImage imageNamed:@"tab_icon3.png"];
    [navStats.tabBarItem setImage:stats];
    navStats.tabBarItem.title = @"Mes Stats";
    navStats.navigationBarHidden = true;
    
    [g_tabCtrl addChildViewController:navHome];
    [g_tabCtrl addChildViewController:navBet];
    [g_tabCtrl addChildViewController:navStats];
    
    g_tabCtrl.delegate = self;
    self.window.rootViewController = g_tabCtrl;

}

- (void) initDB {
    [g_BetModel deleteDB];
}

- (void) goSideMenu {
    
}

- (void) changeRoot {
    g_tabCtrl.delegate = self;
    self.window.rootViewController = g_tabCtrl;
    [g_tabCtrl setSelectedIndex:0];
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self showRootNavigation:g_tabCtrl.navigationController];
}

- (void) showRootNavigation:(UINavigationController*)_navCtrl
{
    [g_AppDelegate.navHome popToRootViewControllerAnimated:NO];
    [g_AppDelegate.navBet popToRootViewControllerAnimated:NO];
    [g_AppDelegate.navStats popToRootViewControllerAnimated:NO];
    
    [_navCtrl popToRootViewControllerAnimated:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
