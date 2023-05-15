//
//  Task.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_title forKey:@"title" ];
    [coder encodeObject:_date forKey:@"date" ];
    [coder encodeObject:_desc forKey:@"desc" ];
    [coder encodeObject:_perority forKey:@"perority" ];
    [coder encodeObject:_taskState forKey:@"state"];
}



- (instancetype)initWithCoder:(NSCoder *)coder{
    if((self = [super init])){
        _title = [coder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _date = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
        _desc = [coder decodeObjectOfClass:[NSString class] forKey:@"desc"];
        _perority= [coder decodeObjectOfClass:[NSString class] forKey:@"perority"];
        _taskState=[coder decodeObjectOfClass:[NSString class] forKey:@"state"];
    }
    
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
