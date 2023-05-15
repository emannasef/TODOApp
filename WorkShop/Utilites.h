//
//  Utilites.h
//  WorkShop
//
//  Created by Mac on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilites : NSObject

-(NSArray *) read :(NSString *) key ;

-(void) write :(NSMutableArray  *)arr andKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
