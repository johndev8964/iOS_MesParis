//
//  MyBetViewController.m
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "MyBetViewController.h"
#import "AppDelegate.h"
#import "NewViewController.h"
#import "AllBetViewController.h"
#import "MyBetTableViewCell.h"
#import "ConfigurationViewController.h"

@interface MyBetViewController ()

@end

@implementation MyBetViewController
@synthesize m_menuTable;
@synthesize m_sideMenu;
@synthesize m_mainView;
@synthesize m_conn;
@synthesize mybetList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [mybetList reloadData];
    [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [m_menuTable reloadData];
    g_DBHandler = [DBHandler connectDB];
	sqlite3* dbHandler = [g_DBHandler getDbHandler];
    g_BetModel = [[BetModel alloc] initWithDBHandler:dbHandler];
}


- (IBAction)goNew:(id)sender {
    NewViewController *newCtrl = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [g_AppDelegate.navBet pushViewController:newCtrl animated:YES];
}

- (IBAction)goTous:(id)sender {
    AllBetViewController *allCtrl = [[AllBetViewController alloc] initWithNibName:@"AllBetViewController" bundle:nil];
    [g_AppDelegate.navBet pushViewController:allCtrl animated:YES];
}

- (IBAction)goLogin:(id)sender{
    [g_AppDelegate initDB];
    ConfigurationViewController *confCtrl = [[ConfigurationViewController alloc] initWithNibName:@"ConfigurationViewController" bundle:nil];
    g_AppDelegate.window.rootViewController = confCtrl;
    [self presentViewController:confCtrl animated:YES completion:nil];
}

- (IBAction) gotoSideMenu:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    if (self.m_mainView.center.x > 270) {
        [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    }
    else {
        [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2 + 270.0f, self.view.frame.size.height/2)];
    }
    [UIView commitAnimations];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"Cell";
    if (tableView == mybetList) {
        MyBetTableViewCell *cell = (MyBetTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyBetTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        
        if (g_BetModel.dataArray.count != 0) {
            int index = (int)([g_BetModel.dataArray count] - indexPath.row - 1);
            BetRecord *record = [g_BetModel.dataArray objectAtIndex:index];
            [cell displayMyBet:record.date team:record.team vic:record.vic index:record.index];
        }
        
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        UIImage *img = [UIImage imageNamed:[g_AppDelegate.sideIcon objectAtIndex:indexPath.row]];
        cell.imageView.image = img;
        
        cell.textLabel.numberOfLines = 0;
        NSString *cellText = [g_AppDelegate.sideMenu objectAtIndex:indexPath.row];
        cell.textLabel.text = cellText;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        if(indexPath.row == 1) {
            if(g_AppDelegate.g_badgeNum>0) {
                UIImageView *badgeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"badge.png"]];
                
                UILabel *badgeLabel;
                
                badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 46, 24)];
                
                
                badgeLabel.text = [NSString stringWithFormat:@"%d", g_AppDelegate.g_badgeNum];
                badgeLabel.textAlignment = UITextAlignmentCenter;
                
                badgeLabel.textColor = [UIColor whiteColor];
                badgeLabel.backgroundColor = [UIColor clearColor];
                [badgeView addSubview:badgeLabel];
                
                cell.accessoryView = badgeView;
            }
            
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == m_menuTable) {
        NewViewController *newCtrl = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
        AllBetViewController *allCtrl = [[AllBetViewController alloc] initWithNibName:@"AllBetViewController" bundle:nil];
        switch (indexPath.row) {
            case 0:
                [g_AppDelegate.g_tabCtrl setSelectedIndex:0];
                break;
            case 1:
                [g_AppDelegate.g_tabCtrl setSelectedIndex:1];
                break;
            case 2:
                [self.navigationController pushViewController:newCtrl animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:allCtrl animated:YES];
                break;
            case 4:
                [g_AppDelegate.g_tabCtrl setSelectedIndex:2];
                break;
            default:
                break;
        }
        
        [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == mybetList) {
        return [g_BetModel.dataArray count];
    }
    else {
        return 5;
    }
}

- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 40;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
