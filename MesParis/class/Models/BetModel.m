//
//  BetModel.m
//  MesParis
//
//  Created by Liming on 8/7/14.
//  Copyright (c) 2014 Liming. All rights reserved.
//

#import "BetModel.h"

@implementation BetRecord

@synthesize index, budget, risk, team, item, bet, vic, earn, lost, date, odd;

@end

@implementation BetModel

@synthesize dbHandler;
@synthesize dataArray;

+ (BOOL)createTable:(sqlite3 *)dbHandler {
	NSString* strQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ FLOAT NOT NULL, %@ INTEGER NOT NULL, %@ VARCHAR(%d) NOT NULL,  %@ VARCHAR(%d) NOT NULL, %@ INTEGER NOT NULL, %@ INTEGER NOT NULL, %@ FLOAT NOT NULL, %@ FLOAT NOT NULL, %@ VARCHAR(%d) NOT NULL, %@ FLOAT NOT NULL)",
						  TABLE_BET,
                          FIELD_ID,
						  FIELD_BUDGET,
                          FIELD_RISK,
                          FIELD_TEAM, 64,
                          FIELD_ITEM, 20,
                          FIELD_BET,
                          FIELD_VIC,
                          FIELD_EARN,
                          FIELD_LOST,
                          FIELD_BETDATE, 20,
                          FIELD_ODD];
	if (sqlite3_exec(dbHandler, [strQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK)
		return NO;
	
	return YES;
}

-(id)initWithDBHandler:(sqlite3*)_dbHandler {
	self = [super init];
	
	if (self) {
		self.dbHandler = _dbHandler;
		NSString *strQuery = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@", TABLE_BET, FIELD_ID];
        
		sqlite3_stmt* stmt;
		
		if (sqlite3_prepare_v2(dbHandler, [strQuery UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
			//int userId;
            dataArray = [[NSMutableArray alloc] init];
			while(sqlite3_step(stmt) == SQLITE_ROW) {
                BetRecord * record = [[BetRecord alloc] init];
                record.index = 0;
                record.budget = 0;
                record.risk = 0;
                record.team = @"";
                record.item = @"";
                record.bet = 0;
                record.vic = 0;
                record.earn = 0;
                record.lost = 0;
                record.date = @"";
                record.odd = 0;
				char *team = (char*)sqlite3_column_text(stmt, 3);
                char *item = (char*)sqlite3_column_text(stmt, 4);
				char *date = (char*)sqlite3_column_text(stmt, 9);
				
				if (team != nil)
					record.team = [NSString stringWithUTF8String:team];
                
				if (item != nil)
					record.item = [NSString stringWithUTF8String:item];
                
                if (date != nil)
					record.date = [NSString stringWithUTF8String:date];
				
                record.index = sqlite3_column_int(stmt, 0);
                record.budget = (float)sqlite3_column_double(stmt, 1);
				record.risk = sqlite3_column_int(stmt, 2);
                record.bet = sqlite3_column_int(stmt, 5);
                record.vic = sqlite3_column_int(stmt, 6);
                record.earn = (float)sqlite3_column_double(stmt, 7);
                record.lost = (float)sqlite3_column_double(stmt, 8);
                record.odd = (float)sqlite3_column_double(stmt, 10);
                [dataArray addObject:record];
			}
            sqlite3_finalize(stmt);
		}
	}
	return self;
}

- (BOOL)updateDB {
    NSString *strQuery = [NSString stringWithFormat:@"DELETE FROM %@", TABLE_BET];
    
    if (sqlite3_exec(dbHandler, [strQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK)
        return NO;
    
    for (int i = 0; i < [dataArray count]; i++) {
        BetRecord* record = (BetRecord*)[dataArray objectAtIndex:i];
        strQuery = [NSString stringWithFormat:@"INSERT INTO %@('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') VALUES( %f, %d, '%@', '%@', %d, %d, %f, %f, '%@', %f)",
                    TABLE_BET,
                    FIELD_BUDGET,
                    FIELD_RISK,
                    FIELD_TEAM,
                    FIELD_ITEM,
                    FIELD_BET,
                    FIELD_VIC,
                    FIELD_EARN,
                    FIELD_LOST,
                    FIELD_BETDATE,
                    FIELD_ODD,
                    record.budget,
                    record.risk,
                    record.team,
                    record.item,
                    record.bet,
                    record.vic,
                    record.earn,
                    record.lost,
                    record.date,
                    record.odd];
        
        if (sqlite3_exec(dbHandler, [strQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK)
            return NO;
    }
    
    return YES;
}

- (BOOL) deleteDB {
    NSString *strQuery = [NSString stringWithFormat:@"DELETE FROM %@", TABLE_BET];
    
    if (sqlite3_exec(dbHandler, [strQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK)
        return NO;
    return YES;
}

- (void)updateArray:(BetRecord*)data {
    for (BetRecord* record in dataArray) {
        if (record.index == data.index) {
            record.vic = data.vic;
            record.risk = data.risk;
            record.team = data.team;
            record.index = data.index;
            record.item = data.item;
            record.date = data.date;
            record.budget = data.budget;
            record.earn = data.earn;
            record.lost = data.lost;
            record.odd = data.odd;
            [self updateDB];
            break;
        }
    }
}

- (BOOL)updateRecord:(BetRecord*)data {
    NSString *strQuery = [NSString stringWithFormat:@"UPDATE %@  SET %@= %f WHERE %@ = %d",
                  TABLE_BET,
                  FIELD_BUDGET,
                  data.budget,
                  FIELD_ID,
                  data.index
    ];
    
    if (sqlite3_exec(dbHandler, [strQuery UTF8String], NULL, NULL, NULL) != SQLITE_OK)
        return NO;
    return YES;
}

- (void)dealloc {
	// release memory of resultController instance
}

@end

