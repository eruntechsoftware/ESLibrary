//
//  SQLiteDatabase.m
//  Eruntech
//
//  Created by 杜明悦 on 13-2-25.
//
//

#import "SQLiteDatabase.h"

@implementation SQLiteDatabase
@synthesize database=_database;
@synthesize sql=_sql;
@synthesize collectors=_collectors;
@synthesize releasers=_releasers;


/**
 初始化数据库访问对象
 @return 数据库对象
 */
-(id) initDatabase
{
    self = [super init];
    if (self) {
        _collectors = [NSMutableArray arrayWithCapacity:1];
        _releasers = [NSMutableArray arrayWithCapacity:1];
        if (_database==nil) {
            _database = [[Database alloc] initDatabase];
        }
    }
    return self;
}

/**
 执行Sql语句
 @return 是否执行成功
 */
-(BOOL) execute
{
    @try
    {
        if (_sql!=nil)
        {
            DataCollection *params = [[DataCollection alloc]initWithCapacity:1];
            id collector = [_collectors objectAtIndex:0] ;
            params = [collector collect];
            _sql=[SQLExpression formatWithSql:[SQLExpression readSqlFile:_sql] params:params];
            return [_database execute:_sql];
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
    return FALSE;
}

/**
 执行Sql语句，并返回数据集
 @return DataTable数据集
 */
-(DataTable*) executeTable
{
    @try
    {
        if (_sql!=nil)
        {
            DataCollection *params = (DataCollection*)[NSMutableArray arrayWithCapacity:1];
            id collector = [_collectors objectAtIndex:0] ;
            params = [collector collect];
            _sql=[SQLExpression formatWithSql:[SQLExpression readSqlFile:_sql] params:params];
            DataTable *dataTable = [_database executeTable:_sql];
            if(dataTable!=nil && dataTable.count>0){
                [[self.releasers objectAtIndex:0] release:dataTable];
            }
            
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        
    }
}

/**
 执行数据集发布
 */
-(void)executeTable:(DataTable*)dataTable
{
    if (dataTable!=NULL && [dataTable count]>0) {
        NSInteger size = [[self releasers] count];

        for (int i=0;i<size; i++) {
            [[[self releasers] objectAtIndex:i] release:dataTable];
        }
    }
}
@end
