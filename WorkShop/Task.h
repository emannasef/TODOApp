//
//  Task.h
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject<NSCoding , NSSecureCoding>

@property NSString *title;
@property NSDate *date;
@property NSString *perority;
@property NSString *desc;
@property NSString *taskState;

-(void) encodeWithCoder:(NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
