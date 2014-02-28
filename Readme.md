## Purpose
ASFormatterCache is an iOS cache that gives easy access to reusable and auto-updated date formatters. Auto-update is done on any Locale change.

## Supported iOS
iOS 5 and above.

## ARC Compatibility
ASFormatterCache requires ARC.

If you wish to use ASFormatterCache in a non-ARC project, just add the -fobjc-arc compiler flag to the "ASFormatterCache.m" file.

## Use it
Add `pod 'ASFormatterCache'` to your Podfile or copy 'ASFormatterCache.h' and 'ASFormatterCache.m' in your project.

How to create a date formatter ?

    NSDateFormatter *formatter;
    
    formatter = [ASFormatterCache dateFormatterWithBlock:^NSDateFormatter *(NSDateFormatter *dateFormatter) {
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterLongStyle;
        return dateFormatter;
    }];
                                             
Each time the locale is changed, each formatter is removed from the cache. When the formatter is accessed, it is then recreated and the init block is called once again.

Please note that `[ASFormatterCache dateFormatterWithBlock:]`computes a key on each call. If you need to access your formatter really often, this computation might slow down a little bit your operation, then you may whish to use a specific key in this case through `[NSDateFormatter dateFormatterForKey: initBlock:]`.