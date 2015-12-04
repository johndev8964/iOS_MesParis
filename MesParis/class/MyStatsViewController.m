//
//  MyStatsViewController.m
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "AppDelegate.h"
#import "MyStatsViewController.h"
#import "NewViewController.h"
#import "ConfigurationViewController.h"
#import "AllBetViewController.h"
#import "LineChartView.h"

@interface MyStatsViewController ()

@end

@implementation MyStatsViewController

@synthesize verticalScroll;
@synthesize m_title;
@synthesize m_allNum;
@synthesize m_avgOdd;
@synthesize m_perBasketball;
@synthesize m_perBenifit;
@synthesize m_perFootball;
@synthesize m_perInvest;
@synthesize m_perMulti;
@synthesize m_perSuccess;
@synthesize m_perTennis;
@synthesize m_startBankroll;
@synthesize m_totalBid;
@synthesize m_bankRoll;
@synthesize m_mainView;
@synthesize m_menuTable;
@synthesize m_sideMenu;
@synthesize m_conn;
@synthesize m_statsBet;
@synthesize m_newButton;

@synthesize m_graphView;
@synthesize max_budget;
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
    self.verticalScroll.contentSize = CGSizeMake(320, 840);
    m_newButton.titleLabel.textAlignment = UITextAlignmentCenter;
    m_newButton.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    [m_newButton setTitle:@"Enregister\nun paris" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    max_budget = 0;
    [self.verticalScroll setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [m_menuTable reloadData];
    int allSuccess = 0 , allfootball = 0, alltennis = 0, allbasketball = 0, allmulti = 0, footballSuccess = 0, basketballSuccess = 0, tennisSuccess = 0, multiSuccess = 0;
    
    g_DBHandler = [DBHandler connectDB];
	sqlite3* dbHandler = [g_DBHandler getDbHandler];
    g_BetModel = [[BetModel alloc] initWithDBHandler:dbHandler];
    m_statsBet = [[NSMutableArray alloc] init];
    
    int allBet = 0;
    float allearn = 0, alllost = 0, allodd = 0;
    for(BetRecord *record in g_BetModel.dataArray) {
        if (record.vic != 1) {
            [m_statsBet addObject:record];
            allBet += record.bet;
            allearn += record.earn;
            alllost += record.lost;
            allodd += record.odd;
        }
    }
    
    
    for (BetRecord *record in m_statsBet) {
        if (record.vic == 3) {
            allSuccess ++;
        }
        if ([record.item isEqualToString:@"FOOTBALL"]) {
            if (record.vic == 3) {
                footballSuccess ++;
            }
            allfootball ++;
        }
        if ([record.item isEqualToString:@"BASKETBALL"]) {
            if (record.vic == 3) {
                basketballSuccess ++;
            }
            allbasketball ++;
        }
        if ([record.item isEqualToString:@"TENNIS"]) {
            if (record.vic == 3) {
                tennisSuccess ++;
            }
            alltennis ++;
        }
        if ([record.item isEqualToString:@"MULTISPORT"]) {
            if (record.vic == 3) {
                multiSuccess ++;
            }
            allmulti ++;
        }
    }
    if (m_statsBet.count != 0) {
        allSuccess = allSuccess *100 / m_statsBet.count;
    }
    NSString *percent = @"%";
    m_perSuccess.text = [NSString stringWithFormat:@"%d%@",allSuccess,percent];
    
    if(allfootball == 0) {
        allfootball = 1;
    }
    if(allbasketball == 0) {
        allbasketball = 1;
    }
    if(alltennis == 0) {
        alltennis = 1;
    }
    if(allmulti == 0) {
        allmulti = 1;
    }
    m_perFootball.text = [NSString stringWithFormat:@"%d%@ Football",footballSuccess *100 / allfootball,percent];
    m_perBasketball.text = [NSString stringWithFormat:@"%d%@ Basketball", basketballSuccess * 100 / allbasketball,percent];
    m_perTennis.text = [NSString stringWithFormat:@"%d%@ Tennis", tennisSuccess * 100 / alltennis, percent];
    m_perMulti.text = [NSString stringWithFormat:@"%d%@ Multisport", multiSuccess * 100 / allmulti,percent];
    
    BetRecord *endBet = m_statsBet.lastObject;
    if (m_statsBet.count == 1) {
       endBet = m_statsBet.firstObject;
    }
    
    NSString *budget_str = [NSString stringWithFormat:@"%.0f€", endBet.budget];
    [m_bankRoll setText:budget_str];
    if (allearn - alllost >= 0) {
        m_perBenifit.text = [NSString stringWithFormat:@"+%.0f€", allearn - alllost];
    }
    else {
        m_perBenifit.text = [NSString stringWithFormat:@"-%.0f€", alllost - allearn];
    }
    
    BetRecord *startBet = m_statsBet.firstObject;
    if(startBet.earn >= 0) {
        m_startBankroll.text = [NSString stringWithFormat:@"%.0f€", startBet.budget - startBet.earn];
    }
    else {
        m_startBankroll.text = [NSString stringWithFormat:@"%.0f€", startBet.budget - startBet.lost];
    }
        
    int statsBet = (int) m_statsBet.count;
    m_allNum.text = [NSString stringWithFormat:@"%d", statsBet];
    float avgOdd = 0;
    if (m_statsBet.count == 0) {
        avgOdd = 0;
    }
    else {
        avgOdd = allodd/m_statsBet.count;
    }
    m_avgOdd.text = [NSString stringWithFormat:@"%.1f", avgOdd];
    
    m_totalBid.text = [NSString stringWithFormat:@"%d", allBet];
    if (allBet != 0) {
        m_perInvest.text = [NSString stringWithFormat:@"%.0f%@", allearn * 100/allBet, percent];
    }
    else {
        m_perInvest.text = [NSString stringWithFormat:@"%d%@", 0, percent];
    }
    
    LineChartView *lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 0, 280, 140)];
    
    NSMutableArray *pointArr = [[NSMutableArray alloc] init];
    [pointArr removeAllObjects];
    [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(40*0, 0)]];
    
    //横轴
    NSMutableArray *hArr = [[NSMutableArray alloc]initWithCapacity:6];
    [hArr removeAllObjects];
    if(m_statsBet.count < 6) {
        [hArr addObject:@"1"];
        [hArr addObject:@"2"];
        [hArr addObject:@"3"];
        [hArr addObject:@"4"];
        [hArr addObject:@"5"];
        [hArr addObject:@"6"];
        int i = 0;
        for (BetRecord *_record in self.m_statsBet) {
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
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_statsBet.count - 3]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_statsBet.count - 2]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_statsBet.count - 1]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_statsBet.count]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_statsBet.count + 1]];
        [hArr addObject:[NSString stringWithFormat:@"%lu",m_statsBet.count + 2]];
        
        
        for (int i = (int)m_statsBet.count - 4; i <= m_statsBet.count; i++) {
            BetRecord *_record = [m_statsBet objectAtIndex:i-1];
            int temp_budget = _record.budget;
            if (temp_budget > max_budget) {
                max_budget = temp_budget;
            }
            [pointArr addObject:[NSValue valueWithCGPoint:CGPointMake(40*(i - m_statsBet.count + 5), (_record.budget-(int)(max_budget/1000) * 1000)/40)]];
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

- (IBAction)goNew:(id)sender {
    NewViewController *newCtrl = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [g_AppDelegate.navStats pushViewController:newCtrl animated:YES];
}

- (IBAction)goParis:(id)sender {
    [g_AppDelegate.g_tabCtrl setSelectedIndex:1];
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
        
        [self.verticalScroll setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
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

@end
