//
//  TaskHelper.m
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 22/04/2024.
//

#import "TaskHelper.h"

@implementation TaskHelper

+(void) writeArrayToUserDefualtsForkey:(NSString *) key WithArray:(NSMutableArray *) array{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}
+(NSMutableArray *) readArrayFromUserDefaultsForKey:(NSString *) key{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(array == nil)
        array = [NSMutableArray new];
    return array;
}
+(void) removeArrayFromUserDefaultsForKey:(NSString *) key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
