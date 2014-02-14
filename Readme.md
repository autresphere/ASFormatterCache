## Purpose
ASFormatterCache is an iOS cache that gives easy access to reusable date formatters and auto-update formatters on locale change.

## Supported iOS
iOS 5 and above.

## ARC Compatibility
ASFormatterCache requires ARC. If you wish to use ASFormatterCache in a non-ARC project, just add the -fobjc-arc compiler flag to the "ASFormatterCache.m" file.

## Use it
Add `pod 'ASFormatterCache'` to your Podfile or copy 'ASFormatterCache.h' and 'ASFormatterCache.m' in your project.

How to create a date formatter:
```objc
NSDateFormatter *formatter;

formatter = [ASFormatterCache dateFormatterForKey:@"main.date"
                                        initBlock:^NSDateFormatter *(NSDateFormatter *dateFormatter) {
                                            dateFormatter.dateStyle = NSDateFormatterLongStyle;
                                            dateFormatter.timeStyle = NSDateFormatterLongStyle;
                                            return dateFormatter;
                                        }];
```
