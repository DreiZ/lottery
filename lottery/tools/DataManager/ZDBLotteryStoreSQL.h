//
//  ZDBLotteryStoreSQL.h
//
//
//  Created by ZZZ on 16/3/13.
//  Copyright © 2016年 ZZZ. All rights reserved.
//

#ifndef ZDBLotteryStoreSQL_h
#define ZDBLotteryStoreSQL_h

#define     LOTTERY_TABLE_NAME              @"lottery"

#define     SQL_CREATE_LOTTERY_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
                                            lid TEXT,\
                                            serial_num TEXT,\
                                            num1 TEXT,\
                                            num2 TEXT,\
                                            num3 TEXT,\
                                            date TEXT,\
                                            ext1 TEXT,\
                                            ext2 TEXT,\
                                            ext3 TEXT,\
                                            ext4 TEXT,\
                                            ext5 TEXT,\
                                            PRIMARY KEY(lid))"


#define     SQL_ADD_LOTTERY                 @"REPLACE INTO %@ ( lid, serial_num, num1, num2, num3, date, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"


#define     SQL_SELECT_LOTTERY_PAGE         @"SELECT * FROM %@ WHERE date < '%@' order by date desc LIMIT '%ld'"
#define     SQL_SELECT_LAST_LOTTERY         @"SELECT * FROM %@ WHERE date = ( SELECT MAX(date) FROM %@)"


#define     SQL_DELETE_LOTTERY_ID           @"DELETE FROM %@ WHERE lid = '%@'"
#define     SQL_DELETE_LOTTERY_DATE         @"DELETE FROM %@ WHERE date < '%@' and date > '%@'"
#define     SQL_DELETE_LOTTERY_ALL          @"DELETE FROM %@ WHERE lid > 0"

#endif /* ZDBLotteryStoreSQL_g */
