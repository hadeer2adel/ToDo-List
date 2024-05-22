//
//  Task.m
//  WorkShop
//
//  Created by Hadeer Adel Ahmed on 21/04/2024.
//

#import "Task.h"

@implementation Task

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self != nil) {
        self.title = [coder decodeObjectForKey:@"title"];
        self.descriptionT = [coder decodeObjectForKey:@"description"];
        self.priority = [coder decodeIntForKey:@"priority"];
        self.status = [coder decodeIntForKey:@"status"];
        self.date = [coder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.descriptionT forKey:@"description"];
    [coder encodeInt:self.priority forKey:@"priority"];
    [coder encodeInt:self.status forKey:@"status"];
    [coder encodeObject:self.date forKey:@"date"];
}

@end
