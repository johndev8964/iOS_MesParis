//
//  NewViewController.m
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "AppDelegate.h"
#import "NewViewController.h"
#import "MyBetViewController.h"
#import "MyStatsViewController.h"
#import "ConfigurationViewController.h"
#import "AllBetViewController.h"


@implementation NewViewController

@synthesize m_betandrisk;
@synthesize m_bet;
@synthesize m_title;
@synthesize m_item;
@synthesize m_odd;
@synthesize m_menuTable;
@synthesize m_sideMenu;
@synthesize m_mainView;
@synthesize m_conn;
@synthesize m_football;
@synthesize m_basketball;
@synthesize m_tennis;
@synthesize m_multi;
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
    // Do any additional setup after loading the view from its nib.
    int budget = g_AppDelegate.g_budget;
    int risk = g_AppDelegate.g_budget * g_AppDelegate.g_risk / 100;
    NSString *str = [NSString stringWithFormat:@"Mise conseillee:%d€ Bankroll:%d€",risk,budget];
    [m_betandrisk setText:str];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [m_menuTable reloadData];
}

- (IBAction)goHome:(id)sender {
    //[g_AppDelegate.g_tabCtrl setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:NO];
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

- (IBAction)selItem:(id)sender {
    [m_title resignFirstResponder];
    [m_bet resignFirstResponder];
    [m_football setBackgroundImage:[UIImage imageNamed:@"button_menu"] forState:UIControlStateNormal];
    [m_basketball setBackgroundImage:[UIImage imageNamed:@"button_menu"] forState:UIControlStateNormal];
    [m_tennis setBackgroundImage:[UIImage imageNamed:@"button_menu"] forState:UIControlStateNormal];
    [m_multi setBackgroundImage:[UIImage imageNamed:@"button_menu"] forState:UIControlStateNormal];
    [m_football setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]] forState:UIControlStateNormal];
    [m_tennis setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]] forState:UIControlStateNormal];
    [m_basketball setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]] forState:UIControlStateNormal];
    [m_multi setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]] forState:UIControlStateNormal];
    UIButton *itemBtn = (UIButton *)sender;
    switch (itemBtn.tag) {
        case 1:
            m_item = @"FOOTBALL";
            [m_football setBackgroundImage:[UIImage imageNamed:@"button_menu_selected"] forState:UIControlStateNormal];
            [m_football setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 2:
            m_item = @"TENNIS";
            [m_tennis setBackgroundImage:[UIImage imageNamed:@"button_menu_selected"] forState:UIControlStateNormal];
            [m_tennis setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 3:
            m_item = @"BASKETBALL";
            [m_basketball setBackgroundImage:[UIImage imageNamed:@"button_menu_selected"] forState:UIControlStateNormal];
            [m_basketball setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 4:
            m_item = @"MULTISPORT";
            [m_multi setBackgroundImage:[UIImage imageNamed:@"button_menu_selected"] forState:UIControlStateNormal];
            [m_multi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)goParis:(id)sender {
    if (m_bet.text.intValue > 0 && ![m_title.text isEqualToString:@"Titre"] && m_odd.text.floatValue > 0) {
        BetRecord *record = [[BetRecord alloc] init];
        record.budget = g_AppDelegate.g_budget;
        record.risk = g_AppDelegate.g_risk;
        record.team = m_title.text;
        record.item = m_item;
        record.bet = m_bet.text.intValue;
        record.odd = m_odd.text.floatValue;
        record.vic = 1;
        record.earn = 0;
        record.lost = 0;
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"dd/MM/YYYY"];
        NSString *str = [DateFormatter stringFromDate:[NSDate date]];
        record.date = str;
        [g_BetModel.dataArray addObject:record];
        [g_BetModel updateDB];
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
    [g_AppDelegate.g_tabCtrl setSelectedIndex:1];
}

- (IBAction)moveScreen:(id)sender {
    if(sender == m_title) {
        m_title.text = @"";
    }
    else {
        if (sender == m_bet) {
            m_bet.text = @"";
        }
        else {
            m_odd.text = @"";
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [self.view setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 150.0f)];
        [UIView commitAnimations];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* reuseIdentifier = @"Cell";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == m_menuTable) {
        AllBetViewController *allCtrl = [[AllBetViewController alloc] initWithNibName:@"AllBetViewController" bundle:nil];
        switch (indexPath.row) {
            case 0:
                [self.navigationController popToRootViewControllerAnimated:NO];
                break;
            case 1:
                [g_AppDelegate.g_tabCtrl setSelectedIndex:1];
                break;
            case 2:
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
    return 5;
}

- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 40;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [m_title resignFirstResponder];
    [m_bet resignFirstResponder];
    [m_odd resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    [self.view setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [UIView commitAnimations];
}

@end
