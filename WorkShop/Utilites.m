//
//  Utilites.m
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import "Utilites.h"
#import "Task.h"

@implementation Utilites

- (void)write:(NSMutableArray *)arr andKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSError *error ;
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&error];
    
    [defaults setObject:archiveData forKey:key];
    
}

- (NSArray *)read:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSError *error;
    
    NSData *savedData = [defaults objectForKey:key];
    
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[Task class]]];
    
    NSArray<Task*> *taskArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&error];
    
    return taskArray;
}

@end
