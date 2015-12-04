//
//  ConfigurationViewController.m
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "NewViewController.h"


@implementation ConfigurationViewController
@synthesize m_budget;
@synthesize m_risk;
@synthesize m_sel;
@synthesize cnt;
@synthesize n_budget;
@synthesize n_risk;

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
}

- (void) viewWillAppear:(BOOL)animated {
    cnt = 0;
    n_budget = 0;
    n_risk = 5;
}



- (IBAction)goHome:(id)sender {
    //if (g_AppDelegate.g_budget > 0) {
    [m_budget resignFirstResponder];
    n_budget = m_budget.text.intValue;
    if ([m_sel.text isEqualToString:@"Safe"]) {
        n_risk = 5;
    } else if ([m_sel.text isEqualToString:@"Normal"]) {
        n_risk = 7;
    } else {
        n_risk = 11;
    }
    
    g_AppDelegate.g_budget = (float) n_budget;
    g_AppDelegate.g_risk = n_risk;
    
    for(BetRecord *record in g_BetModel.dataArray) {
        if (record == g_BetModel.dataArray.lastObject) {
            BetRecord *_record = [[BetRecord alloc] init];
            _record.index = record.index;
            _record.budget = record.budget + g_AppDelegate.g_budget;
            _record.risk = record.risk;
            _record.bet = record.bet;
            _record.team = record.team;
            _record.item = record.item;
            _record.vic = record.vic;
            _record.earn = record.earn;
            _record.lost = record.lost;
            _record.date = record.date;
            [g_BetModel updateRecord:_record];
        }
    }

    [g_AppDelegate changeRoot];
    //}
    //else {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter bankroll!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    //}
}

- (IBAction)selRisk:(id)sender {
    [m_budget resignFirstResponder];
    if(cnt == 3) {
        cnt = 0;
    }
    cnt++;
    switch (cnt) {
        case 1:
            m_sel.text = @"Normal";
            break;
        case 2:
            m_sel.text = @"Agressive";
            break;
        case 3:
            m_sel.text = @"Safe";
            break;
        default:
            break;
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [m_budget resignFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
