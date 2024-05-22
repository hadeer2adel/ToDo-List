//
//  Task.h
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property NSString * title;
@property NSString * descriptionT;
@property int priority;
@property int status;
@property NSDate * date;

@end

NS_ASSUME_NONNULL_END
