//
//  TaskHelper.h
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 22/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskHelper : NSObject

+(void) writeArrayToUserDefualtsForkey:(NSString *) key WithArray:(NSMutableArray *) array;
+(NSMutableArray *) readArrayFromUserDefaultsForKey:(NSString *) key;
+(void) removeArrayFromUserDefaultsForKey:(NSString *) key;

@end

NS_ASSUME_NONNULL_END
