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

+ (void)removeDateFormatterWithKey:(NSString *)key
{
    [[self sharedCache] removeDateFormatterWithKey:key];
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

+ (NSDateFormatter *)dateFormatterWithInitBlock:(NSDateFormatter *(^)(NSDateFormatter *dateFormatter))block
{
    NSString *callerDescription;
    NSCharacterSet *separators;
    NSMutableArray *symbols;
    NSString *key;
    
    // Forge a unique key depending on the caller stack trace.
    callerDescription = [NSThread callStackSymbols][1];
    separators = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    symbols = [NSMutableArray arrayWithArray:[callerDescription componentsSeparatedByCharactersInSet:separators]];
    [symbols removeObject:@""];
    
    key = [NSString stringWithFormat:@"%@-%@-%@-%@", symbols[1], symbols[3], symbols[4], symbols[5]];

    return [[self sharedCache] dateFormatterForKey:key initBlock:block];
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

- (void)removeDateFormatterWithKey:(NSString *)key
{
    [self.cache removeObjectForKey:key];
}

- (void)currentLocaleDidChangeNotification:(NSNotification *)notification
{
    [self.cache removeAllObjects];
}

@end
