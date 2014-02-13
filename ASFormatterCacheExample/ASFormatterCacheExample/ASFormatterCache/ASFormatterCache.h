//
//  ASFormatterCache.h
//  ASFormatterCache
//
//  Created by Philippe Converset on 13/02/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASFormatterCache : NSObject

+ (ASFormatterCache *)sharedCache;

+ (NSDateFormatter *)dateFormatterForKey:(NSString *)key initBlock:(NSDateFormatter *(^)(NSDateFormatter *dateFormatter))block;

@end
