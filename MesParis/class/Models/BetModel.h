//
//  BetModel.h
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define TABLE_BET		@"tbl_bet"

#define FIELD_ID            @"id"
#define FIELD_BUDGET		@"budget"
#define FIELD_RISK			@"risk"
#define FIELD_TEAM			@"team"
#define FIELD_ITEM		    @"item"
#define FIELD_BET           @"bet"
#define FIELD_VIC			@"vic"
#define FIELD_EARN			@"earn"
#define FIELD_LOST		    @"lost"
#define FIELD_BETDATE       @"betdate"
#define FIELD_ODD           @"odd"

@interface BetRecord : NSObject {
    int index;
    float budget;
    int risk;
    NSString *team;
    NSString *item;
    int bet;
    int vic;
    float earn;
    float lost;
    NSString *date;
    int num;
}

@property (nonatomic) int index;
@property (nonatomic, retain) NSString* team;
@property (nonatomic, retain) NSString* item;
@property (nonatomic, retain) NSString* date;
@property (nonatomic) float budget;
@property (nonatomic) int risk;
@property (nonatomic) int bet;
@property (nonatomic) int vic;
@property (nonatomic) float earn;
@property (nonatomic) float lost;
@property (nonatomic) float odd;

@end

@interface BetModel : NSObject {
	sqlite3         *dbHandler;
    NSMutableArray  *dataArray;
}

@property (nonatomic)           sqlite3         *dbHandler;
@property (nonatomic, retain)   NSMutableArray  *dataArray;

+ (BOOL)createTable:(sqlite3 *)dbHandler;
- (id)initWithDBHandler:(sqlite3*)dbHandler;
- (BOOL)updateDB;
- (BOOL)deleteDB;
- (void)updateArray:(BetRecord*)data;
- (BOOL)updateRecord:(BetRecord *)data;

@end

