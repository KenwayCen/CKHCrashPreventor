//
//  ViewController.m
//  CKHCrashPreventor
//
//  Created by Kenway-Pro on 2019/2/19.
//  Copyright © 2019 Kenway. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVPlayerViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"ABCDEFGHIJKLMN"];
    [str1 replaceCharactersInRange:NSRangeFromString(@"(2,20)") withString:@"呜呜呜呜呜"];
    NSLog(@"%@",str1);
    [str1 insertString:@"222222" atIndex:30];
    [str1 deleteCharactersInRange:NSRangeFromString(@"(6,2)")];
    NSLog(@"%@",str1);
    
    NSMutableArray *dd = [NSMutableArray arrayWithObjects:@"dd",@"33", nil];
    [dd insertObject:@"544" atIndex:3];
    
    
    NSDictionary *dic = @{@"num":@(10),@"array":@[@"11",@"22",@"33"]};
    NSLog(@"%d",[dic[@"num"] isEqualToString:@"10"]);
    NSLog(@"%@",[dic[@"array"] objectForKey:@"oo"]);
    
}


@end
