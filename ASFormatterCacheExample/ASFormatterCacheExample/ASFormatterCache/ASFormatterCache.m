//
//  ASFormatterCache.m
//  ASFormatterCache
//
//  Created by Philippe Converset on 13/02/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import "ASFormatterCache.h"

@interface ASFormatterCache ()
@property (nonatomic, strong) NSMutableDictionary *cache;
@end

@implementation ASFormatterCache

+ (ASFormatterCache *)sharedCache
{
    static ASFormatterCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[ASFormatterCache alloc] init];
    });
    
    return sharedCache;
}

+ (NSDateFormatter *)dateFormatterForKey:(NSString *)key initBlock:(NSDateFormatter *(^)(NSDateFormatter *dateFormatter))block
{
    return [[self sharedCache] dateFormatterForKey:key initBlock:block];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cache = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(currentLocaleDidChangeNotification:)
                                                     name:NSCurrentLocaleDidChangeNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSCurrentLocaleDidChangeNotification
                                                  object:nil];
}

- (NSDateFormatter *)dateFormatterForKey:(NSString *)key initBlock:(NSDateFormatter *(^)(NSDateFormatter *dateFormatter))block
{
    NSDateFormatter *dateFormatter;
    
    dateFormatter = (NSDateFormatter *)self.cache[key];
    if(dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        if(block != nil)
        {
            dateFormatter = block(dateFormatter);
        }
        
        if(dateFormatter != nil)
        {
            self.cache[key] = dateFormatter;
        }
    }
    
    return dateFormatter;
}

- (void)currentLocaleDidChangeNotification:(NSNotification *)notification
{
    [self.cache removeAllObjects];
}

@end
