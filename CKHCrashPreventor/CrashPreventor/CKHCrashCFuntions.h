//
//  CKHCrashCFuntions.h
//  CKHCrashPreventor
//
//  Created by Kenway-Pro on 2019/2/19.
//  Copyright © 2019 Kenway. All rights reserved.
//

#import <objc/runtime.h>

#ifndef CKHCrashCFuntions_h
#define CKHCrashCFuntions_h

static NSString * const kCrashLogDirName = @"CCPCrashLog";

static inline void CCP_exchangeInstanceMethod(Class _originalClass ,SEL _originalSel,Class _targetClass ,SEL _targetSel){
    Method methodOriginal = class_getInstanceMethod(_originalClass, _originalSel);
    Method methodNew = class_getInstanceMethod(_targetClass, _targetSel);
    BOOL didAddMethod = class_addMethod(_originalClass, _originalSel, method_getImplementation(methodNew), method_getTypeEncoding(methodNew));
    if (didAddMethod) {
        class_replaceMethod(_originalClass, _targetSel, method_getImplementation(methodOriginal), method_getTypeEncoding(methodOriginal));
    }else{
        method_exchangeImplementations(methodOriginal, methodNew);
    }
}

static inline void CCP_exchangeClassMethod(Class _class ,SEL _originalSel,SEL _exchangeSel){
    Method methodOriginal = class_getClassMethod(_class, _originalSel);
    Method methodNew = class_getClassMethod(_class, _exchangeSel);
    method_exchangeImplementations(methodOriginal, methodNew);
}

static inline id impEmpty(id self, SEL aSel, ...){
    return nil;
}

#pragma mark - log -

NSString * pathForCrashLog(){
    NSString *tempPath = NSTemporaryDirectory();
    NSString *crashLogPath = [tempPath stringByAppendingPathComponent:kCrashLogDirName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:crashLogPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:crashLogPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return crashLogPath;
}
void throwError(NSString *errorInfo){
    NSDate *date = [NSDate date];
    NSTimeInterval interval = 8 * 60 * 60;
    NSDate *today = [NSDate dateWithTimeInterval:interval sinceDate:date];
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    NSString *crashReason = [NSString stringWithFormat:@"\n\n%@ Crash Reason:%@\n%@",today,errorInfo,callStackSymbolsArr];
    //保存日志
    NSString *crashLogPath = pathForCrashLog();
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString *crashLogFileName = [formatter stringFromDate:date];
    NSString *crashLogFilePath = [crashLogPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.log",crashLogFileName]];
    NSError *error = nil;
    NSString *log = [NSString stringWithContentsOfFile:crashLogFilePath encoding:NSUTF8StringEncoding error:&error];
    if (log) {
        log = [log stringByAppendingFormat:@"\n%@",crashReason];
    }else{
        log = crashReason;
    }
    if (log) {
        [log writeToFile:crashLogFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
#ifdef DEBUG
    //debug 模式打印日志
    NSLog(@"%@",crashReason);
#endif
}

NSString * beyondErrorInfo(NSString * type,NSString *method, unsigned long idx, unsigned long count){
    return [NSString stringWithFormat:@"\n*** -[%@ %@]: index %ld beyond bounds [0 .. %ld]",type,method,idx,count];
}

#endif /* CKHCrashCFuntions_h */
