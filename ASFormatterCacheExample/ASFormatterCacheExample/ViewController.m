//
//  ViewController.m
//  ASFormatterCacheExample
//
//  Created by Philippe Converset on 13/02/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import "ViewController.h"
#import "ASFormatterCache.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextField *countryTextField;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (void)setup
{
    [self updateAll];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateAll) userInfo:nil repeats:YES];
}

- (void)updateAll
{
    [self updateTime];
    [self updateCountry];
}

- (void)updateCountry
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    self.countryTextField.text = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
}

- (void)updateTime
{
    NSDateFormatter *dateFormatter;
    
    dateFormatter = [ASFormatterCache dateFormatterForKey:@"main.date"
                                                initBlock:^NSDateFormatter *(NSDateFormatter *dateFormatter) {
                                                    NSLog(@"Initializing date formatter.");
                                                    dateFormatter.dateStyle = NSDateFormatterLongStyle;
                                                    dateFormatter.timeStyle = NSDateFormatterLongStyle;
                                                    return dateFormatter;
                                                }];
    
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
}
@end
