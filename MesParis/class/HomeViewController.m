//
//  HomeViewController.m
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "NewViewController.h"
#import "MyBetViewController.h"
#import "MyStatsViewController.h"
#import "ConfigurationViewController.h"
#import "TousMesTableViewCell.h"
#import "AllBetViewController.h"
#import "LineChartView.h"

@implementation HomeViewController

@synthesize budget, risk;
@synthesize m_budget;
@synthesize m_mesParis;
@synthesize m_menuTable;
@synthesize m_finishBet;
@synthesize m_sideMenu;
@synthesize m_mainView;
@synthesize m_conn;
@synthesize m_graphView;
@synthesize m_newBet;
@synthesize max_budget;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        budget = 0;
        risk = 5;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_newBet.titleLabel.textAlignment = UITextAlignmentCenter;
    m_newBet.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    [m_newBet setTitle:@"Enregister\nun paris" forState:UIControlStateNormal];
}

- (IBAction)goNew:(id)sender {
    NewViewController *newCtrl = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [g_AppDelegate.navHome pushViewController:newCtrl animated:YES];
}

- (IBAction) gotoSideMenu:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    if (self.m_mainView.center.x > 250) {
        [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    }
    else {
        [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2 + 270.0f, self.view.frame.size.height/2)];
    }
    [UIView commitAnimations];
}

- (IBAction)goStats:(id)sender {

    [g_AppDelegate.g_tabCtrl setSelectedIndex:2];

}

- (IBAction) goLogin:(id)sender {
    [g_AppDelegate initRootViewController];
    [g_AppDelegate initDB];
    ConfigurationViewController *confCtrl = [[ConfigurationViewController alloc] initWithNibName:@"ConfigurationViewController" bundle:nil];
    g_AppDelegate.window.rootViewController = confCtrl;
    [self presentViewController:confCtrl animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
     max_budget = 0;
    g_DBHandler = [DBHandler connectDB];
	sqlite3* dbHandler = [g_DBHandler getDbHandler];
    g_BetModel = [[BetModel alloc] initWithDBHandler:dbHandler];
    m_finishBet = [[NSMutableArray alloc] init];
    for(BetRecord *record in g_BetModel.dataArray) {
        if (record.vic != 1) {
            [m_finishBet addObject:record];
        }
    }
    
    g_AppDelegate.g_badgeNum = (int)g_BetModel.dataArray.count - (int)m_finishBet.count;
    // Do any additional setup after loading the view from its nib.
    if(m_finishBet.count != 0) {
        BetRecord *temp_record = g_BetModel.dataArray.lastObject;
        g_AppDelegate.g_budget = temp_record.budget;
    }
    
    NSString *budget_str = [NSString stringWithFormat:@"%.0f€", g_AppDelegate.g_budget];
    [m_budget setText:budget_str];
    [self.m_mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [m_mesParis reloadData];
    [m_menuTable reloadData];
    
    LineChartView *lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 0, 280, 140)];
   
    NSMutableArray *pointArr = [[NSMutableArray alloc] init];
    [pointArr removeAllObjects];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(40*0, 0)]];
    
    //横轴
    NSMutableArray *hArr = [[NSMutableArray alloc]initWithCapacity:6];
    [hArr removeAllObjects];
    if(m_finishBet.count < 6) {
        [hArr addObject:@"1"];
        [hArr addObject:@"2"];
        [hArr addObject:@"3"];
        [hArr addObject:@"4"];
        [hArr addObject:@"5"];
        [hArr addObject:@"6"];
        int i = 0;
        for (BetRecord *_record in self.m_finishBet) {
            i++;
            int temp_budget = _record.budget;
            if (temp_budget > max_budget) {
                max_budget = temp_budget;
            }
            if(i > 5) {
                continue;
            }
            [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(40*i, (_record.budget-(int)(max_budget/1000) * 1000)/40)]];
        }
    }
    else {
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_finishBet.count - 3]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_finishBet.count - 2]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_finishBet.count - 1]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_finishBet.count]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_finishBet.count + 1]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_finishBet.count + 2]];
        
       
        for (int i = (int)m_finishBet.count - 4; i <= m_finishBet.count; i++) {
            BetRecord *_record = [m_finishBet objectAtIndex:i-1];
            int temp_budget = _record.budget;
            if (temp_budget > max_budget) {
                max_budget = temp_budget;
            }
            [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(40*(i - m_finishBet.count + 5), (_record.budget-(int)(max_budget/1000) * 1000)/40)]];
        }
    }
    int average_budget = (int)(max_budget/1000) * 1000 ;
    //竖轴
    NSMutableArray *vArr = [[NSMutableArray alloc]initWithCapacity:100];
    [vArr removeAllObjects];
    for (int i=average_budget; i<average_budget + 900; i+=100) {
        [vArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [lineChartView setHDesc:hArr];
    [lineChartView setVDesc:vArr];
    [lineChartView setArray:pointArr];
    lineChartView.backgroundColor = [UIColor clearColor];
    
    NSArray* subViews = [self.m_graphView subviews];
    for (UIView* subView in subViews) {
        if (subView && [subView isKindOfClass:[UIView class]])
            [subView removeFromSuperview];
    }
    
    [self.m_graphView addSubview:lineChartView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* reuseIdentifier = @"Cell";
    if(tableView == m_mesParis) {
        TousMesTableViewCell *cell = (TousMesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TousMesTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        BetRecord *record = [m_finishBet objectAtIndex:indexPath.row];
        [cell displayTousMes:record.date team:record.team vic:record.vic];
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
	if (tableView == m_mesParis) {
        return [m_finishBet count];
    }
    else {
        return 5;
    }
}

- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 40;
}


@end
