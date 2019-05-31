//
//  CCPCrashPreventor.m
//  CCPCrashPreventor
//
//  Created by Kenway-Pro on 2019/2/19.
//  Copyright © 2019 Kenway. All rights reserved.
//

#import "CKHCrashPreventor.h"
#import "CKHCrashCFuntions.h"


// 转发的IMPMap类：动态写入方法，避免崩溃
@interface CCPCrashIMPMap : NSObject

@end

@implementation CCPCrashIMPMap


@end

@interface NSArray (CCPCrashPreventor)

@end

@implementation NSArray (CCPCrashPreventor)
//arrayWithObjects:count:
+ (instancetype)CCP_ArrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    for (int i = 0; i<cnt; i++) {
        if (objects[i]) {
            objectsNew[index] = objects[i];
            index++;
        }else{
            NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[%d]",i];
            throwError(errorInfo);
        }
    }
    return [self CCP_ArrayWithObjects:objectsNew count:index];
}

//objectAtIndexedSubscript:
- (id)CCP_objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayI", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return nil;
    }
    return [self CCP_objectAtIndexedSubscript:idx];
}

//objectAtIndex:
- (id)CCP_NSArrayIObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayI", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return nil;
    }
    return [self CCP_NSArrayIObjectAtIndex:index];
}
//objectAtIndex:
- (id)CCP_NSSingleObjectArrayIObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSSingleObjectArrayI", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return nil;
    }
    return [self CCP_NSSingleObjectArrayIObjectAtIndex:index];
}
//objectAtIndex:
- (id)CCP_NSArray0ObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArray0", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return nil;
    }
    return [self CCP_NSArray0ObjectAtIndex:index];
}

@end

@interface NSMutableArray (CCPCrashPreventor)

@end

@implementation NSMutableArray (CCPCrashPreventor)

//objectAtIndex:
- (id)CCP_MArrayObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayM", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return nil;
    }
    return [self CCP_MArrayObjectAtIndex:index];
}

//objectAtIndexedSubscript
- (id)CCP_MArrayobjectAtIndexedSubscript:(NSUInteger)idx{
    if (idx >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayM", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return nil;
    }
    return [self CCP_MArrayobjectAtIndexedSubscript:idx];
}

//removeObjectAtIndex:
- (void)CCP_MArrayRemoveObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayM", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return;
    }
    [self CCP_MArrayRemoveObjectAtIndex:index];
}


- (void)CCP_MArrayRemoveObjectsInRange:(NSRange)range{
    if (range.location+range.length>self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayM", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return;
    }
    [self CCP_MArrayRemoveObjectsInRange:range];
}

//insertObject:atIndex:
- (void)CCP_MArrayInsertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject == nil) {
        NSString *errorInfo = @"\n***  -[__NSArrayM insertObject:atIndex:]: object cannot be nil";
        throwError(errorInfo);
        return;
    }
    if (index > self.count) {
        NSString *errorInfo = beyondErrorInfo(@"__NSArrayM", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return;
    }
    [self CCP_MArrayInsertObject:anObject atIndex:index];
}

- (void)CCP_MArrayInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes{
    if (indexes.firstIndex > self.count) {
        NSString *errorInfo = beyondErrorInfo(@"NSMutableArray", NSStringFromSelector(_cmd), (unsigned long)index,(unsigned long)self.count);
        throwError(errorInfo);
        return;
    }else if (objects.count != (indexes.count)){
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[NSMutableArray insertObjects:atIndexes:]: count of array (%ld) differs from count of index set (%ld)",(unsigned long)objects.count,(unsigned long)indexes.count];
        throwError(errorInfo);
        return;
    }
    [self CCP_MArrayInsertObjects:objects atIndexes:indexes];
}

//replaceObjectAtIndex
- (void)CCP_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (anObject == nil) {
        NSString *errorInfo = @"\n***  -[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil";
        throwError(errorInfo);
        return;
    }
    if (index >= self.count) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSArrayM replaceObjectAtIndex:withObject:]: index %ld beyond bounds [0 .. %ld]",(unsigned long)index,(unsigned long)self.count];
        throwError(errorInfo);
        return;
    }
    [self CCP_replaceObjectAtIndex:index withObject:anObject];
}

- (void)CCP_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects{
    if (indexes.lastIndex >= self.count||indexes.firstIndex >= self.count) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSArrayM replaceObjectsInRange:withObjects:count:]: range {%ld, %ld} extends beyond bounds [0 .. %ld]",(unsigned long)indexes.firstIndex,(unsigned long)indexes.count,(unsigned long)self.count];
        throwError(errorInfo);
    }else{
        [self CCP_replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

-(void)CCP_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray{
    if (range.location+range.length > self.count) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[NSMutableArray replaceObjectsInRange:withObjectsFromArray:]: range {%ld, %ld} extends beyond bounds [0 .. %ld]",(unsigned long)range.location,(unsigned long)range.length,(unsigned long)self.count];
        throwError(errorInfo);
    }else{
        [self CCP_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
}

@end


@interface NSDictionary (CCPCrashPreventor)

@end
@implementation NSDictionary (CCPCrashPreventor)

+ (instancetype)CCP_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    return [self CCP_dictionaryWithObjects:objects forKeys:keys count:cnt];
}

+ (instancetype)CCP_dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys{
    if (objects.count != keys.count) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[NSDictionary initWithObjects:forKeys:]: count of objects (%ld) differs from count of keys (%ld)",(unsigned long)objects.count,(unsigned long)keys.count];
        throwError(errorInfo);
        return nil;
    }
    NSUInteger index = 0;
    id _Nonnull objectsNew[objects.count];
    id <NSCopying> _Nonnull keysNew[keys.count];
    for (int i = 0; i<keys.count; i++) {
        if (objects[i] && keys[i]) {
            objectsNew[index] = objects[i];
            keysNew[index] = keys[i];
            index ++;
        }else{
            NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]",i];
            throwError(errorInfo);
        }
    }
    return [self CCP_dictionaryWithObjects:[NSArray arrayWithObjects:objectsNew count:index] forKeys: [NSArray arrayWithObjects:keysNew count:index]];
}

- (instancetype)CCP_initWithObjects:(NSArray *)objects forKeys:(NSArray<NSCopying> *)keys{
    if (objects.count != keys.count) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[NSDictionary initWithObjects:forKeys:]: count of objects (%ld) differs from count of keys (%ld)",(unsigned long)objects.count,(unsigned long)keys.count];
        throwError(errorInfo);
        return nil;
    }
    NSUInteger index = 0;
    id _Nonnull objectsNew[objects.count];
    id <NSCopying> _Nonnull keysNew[keys.count];
    for (int i = 0; i<keys.count; i++) {
        if (objects[i] && keys[i]) {
            objectsNew[index] = objects[i];
            keysNew[index] = keys[i];
            index ++;
        }else{
            NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]",i];
            throwError(errorInfo);
        }
    }
    return [self CCP_initWithObjects:[NSArray arrayWithObjects:objectsNew count:index] forKeys:[NSArray arrayWithObjects:keysNew count:index]];
}

- (instancetype)CCP_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    id <NSCopying> _Nonnull keysNew[cnt];
    for (int i = 0; i<cnt; i++) {
        if (objects[i] && keys[i]) {
            objectsNew[index] = objects[i];
            keysNew[index] = keys[i];
            index ++;
        }else{
            NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]",i];
            throwError(errorInfo);
        }
    }
    return [self CCP_initWithObjects:objectsNew forKeys:keysNew count:index];
}

- (instancetype)CCP_initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag{
    if ([otherDictionary isKindOfClass:[NSDictionary class]]) {
        return [self CCP_initWithDictionary:otherDictionary copyItems:flag];
    }else if(otherDictionary == nil){
        return [self CCP_initWithDictionary:@{} copyItems:flag];
    } else{
        NSString *errInfo = [NSString stringWithFormat:@"\n*** -[NSDictionary initWithDictionary:copyItems:]: dictionary argument <%@ is class of %@> is not an NSDictionary",otherDictionary,[otherDictionary class]];
        throwError(errInfo);
        return [self CCP_initWithDictionary:@{} copyItems:flag];
    }
}

@end

@interface NSMutableDictionary (CCPCrashPreventor)

@end

@implementation NSMutableDictionary (CCPCrashPreventor)

- (void)CCP_dictionaryMSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject == nil || aKey == nil) {
        NSString * errorInfo = @"\n*** setObjectForKey: object or key cannot be nil";
        throwError(errorInfo);
    }else{
        [self CCP_dictionaryMSetObject:anObject forKey:aKey];
    }
}

- (void)CCP_dictionaryMRemoveObjectForKey:(id)aKey{
    if (aKey == nil) {
        NSString *errorInfo = @"\n*** -[__NSDictionaryM removeObjectForKey:]: key cannot be nil";
        throwError(errorInfo);
    }else{
        [self CCP_dictionaryMRemoveObjectForKey:aKey];
    }
}

@end

@interface NSString (CCPCrashPreventor)

@end

@implementation NSString (CCPCrashPreventor)
/*
 - (unichar)characterAtIndex:(NSUInteger)index;
 - (NSString *)substringFromIndex:(NSUInteger)from;
 - (NSString *)substringToIndex:(NSUInteger)to;
 - (NSString *)substringWithRange:(NSRange)range;
 */

- (unichar)CCP_characterAtIndex:(NSUInteger)index{
    if (index >= self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFConstantString characterAtIndex:]: Range or index %ld out of bounds",(unsigned long)index];
        throwError(errorInfo);
        return 0;
    }
    return [self CCP_characterAtIndex:index];
}

- (NSString *)CCP_substringFromIndex:(NSUInteger)from{
    if (from < 0 || from > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFConstantString substringFromIndex:]: Index %ld out of bounds; string length %ld",(unsigned long)from,(unsigned long)self.length];
        throwError(errorInfo);
        return @"";
    }
    return [self CCP_substringFromIndex:from];
}

- (NSString *)CCP_substringToIndex:(NSUInteger)to{
    if (to > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFConstantString substringToIndex:]: Index %ld out of bounds; string length %ld",(unsigned long)to,(unsigned long)self.length];
        throwError(errorInfo);
        NSUInteger fixTo = self.length;
        if (fixTo >= 0) {
            return [self CCP_substringToIndex:fixTo];
        }else{
            return @"";
        }
    }
    return [self CCP_substringToIndex:to];
}

- (NSString *)CCP_substringWithRange:(NSRange)range{
    if (range.location + range.length > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFConstantString substringWithRange:]: Range {%ld, %ld} out of bounds; string length %ld",(unsigned long)range.location,(unsigned long)range.length,(unsigned long)self.length];
        throwError(errorInfo);
        if (range.location < self.length) {
            NSRange fixRange = NSMakeRange(range.location, self.length - range.location);
            return [self CCP_substringWithRange:fixRange];
        }else{
            return @"";
        }
    }else{
        return [self CCP_substringWithRange:range];
    }
}


@end

@interface NSMutableString (CCPCrashPreventor)

@end

@implementation NSMutableString (CCPCrashPreventor)
/**
 - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
 - (void)deleteCharactersInRange:(NSRange)range;
 - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
 */
- (void)CCP_insertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (loc > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFString insertString:atIndex:]: Range or index %ld out of bounds",(unsigned long)loc];
        throwError(errorInfo);
    }else{
        [self CCP_insertString:aString atIndex:loc];
    }
    
}

- (void)CCP_deleteCharactersInRange:(NSRange)range{
    if (range.location + range.length > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFString deleteCharactersInRange:]: Range or index (%ld,%ld) out of bounds",(unsigned long)range.location,(unsigned long)range.length];
        throwError(errorInfo);
        if (range.location < self.length) {
            NSRange fixRange = NSMakeRange(range.location, self.length - range.location);
            [self CCP_deleteCharactersInRange:fixRange];
        }
    }else{
        [self CCP_deleteCharactersInRange:range];
    }
}

- (void)CCP_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString{
    if (range.location + range.length > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"\n*** -[__NSCFString replaceCharactersInRange:withString:]: Range or index (%ld,%ld) out of bounds",(unsigned long)range.location,(unsigned long)range.length];
        throwError(errorInfo);
        if (range.location < self.length) {
            NSRange fixRange = NSMakeRange(range.location, self.length - range.location);
            [self CCP_replaceCharactersInRange:fixRange withString:aString];
        }
    }else{
        [self CCP_replaceCharactersInRange:range withString:aString];
    }
}

@end

@interface NSNumber (CCPCrashPreventor)

@end
@implementation NSNumber (CCPCrashPreventor)
- (BOOL)isEqualToString:(NSString *)aString{
    NSString *str = self.stringValue;
    return [str isEqualToString:aString];
}

@end




@interface NSObject (CCPUnrecognized)

@end

@implementation NSObject (CCPUnrecognized)

- (id)CCP_forwardingTargetForSelector:(SEL)aSelector{
    if (![self overideForwardingMethods] || [self isEqual:[NSNull null]]) {
        NSString *errorInfo = [[NSString alloc]initWithFormat:@"\n*** -[%@ %@]: unrecognized selector sent to instance %p",NSStringFromClass(self.class),NSStringFromSelector(aSelector),self];
        throwError(errorInfo);
        // 将实现转出去到一个处理类中：但是这个实现会被置空（impEmpty）
        class_addMethod([CCPCrashIMPMap class], aSelector, (IMP)impEmpty, "v@:");
        return [[CCPCrashIMPMap alloc]init];
    }
    return [self CCP_forwardingTargetForSelector:aSelector];
}

/**
 判断forwardInvocation 和 forwardingTargetForSelector
 方法是否有被重写，有重写则直接转发,调用当前类重写过的forwardInvocation和forwardingTargetForSelector,不做任何其他处理
 可以直接通过 IMP是否相等来判断是否有被重写
 => 只要调用forwardingTargetForSelector 方法或forwardInvocation方法，表示self 目前没有能力转发
 */
- (BOOL)overideForwardingMethods{
    BOOL overide = NO;
    overide = (class_getMethodImplementation([NSObject class], @selector(forwardInvocation:)) != class_getMethodImplementation([self class], @selector(forwardInvocation:))) ||
    (class_getMethodImplementation([NSObject class], @selector(forwardingTargetForSelector:)) != class_getMethodImplementation([self class], @selector(forwardingTargetForSelector:)));
    return overide;
}

@end

@implementation CKHCrashPreventor

+ (void)openCrashPreventor{
    [self exchangeMethodsForNSArray];
    [self exchangeMethodsForNSMutableArray];
    [self exchangeMethodsForNSDictionary];
    [self exchangeMethodsForNSMutableDictionary];
    [self exchangeMethodsForNSString];
    [self exchangeMethodsForNSMutableString];
    [self exchangeForwardingTargetForSelector];
}

+ (void)exchangeMethodsForNSArray{
    Class NSArray_ = NSClassFromString(@"NSArray");
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");
    Class __NSArray0 = NSClassFromString(@"__NSArray0");
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
    
    CCP_exchangeClassMethod(NSArray_, @selector(arrayWithObjects:count:), @selector(CCP_ArrayWithObjects:count:));
    CCP_exchangeInstanceMethod(__NSArrayI, @selector(objectAtIndexedSubscript:), __NSArrayI, @selector(CCP_objectAtIndexedSubscript:));
    CCP_exchangeInstanceMethod(__NSArrayI, @selector(objectAtIndex:), __NSArrayI, @selector(CCP_NSArrayIObjectAtIndex:));
    CCP_exchangeInstanceMethod(__NSSingleObjectArrayI, @selector(objectAtIndex:), __NSSingleObjectArrayI, @selector(CCP_NSSingleObjectArrayIObjectAtIndex:));
    CCP_exchangeInstanceMethod(__NSArray0, @selector(objectAtIndex:), __NSArray0, @selector(CCP_NSArray0ObjectAtIndex:));
}

+ (void)exchangeMethodsForNSMutableArray{
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    CCP_exchangeInstanceMethod(arrayMClass, @selector(objectAtIndex:), arrayMClass, @selector(CCP_MArrayObjectAtIndex:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(objectAtIndexedSubscript:), arrayMClass, @selector(CCP_MArrayobjectAtIndexedSubscript:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(removeObjectAtIndex:), arrayMClass, @selector(CCP_MArrayRemoveObjectAtIndex:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(removeObjectsInRange:), arrayMClass, @selector(CCP_MArrayRemoveObjectsInRange:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(insertObject:atIndex:), arrayMClass, @selector(CCP_MArrayInsertObject:atIndex:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(insertObjects:atIndexes:), arrayMClass, @selector(CCP_MArrayInsertObjects:atIndexes:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(replaceObjectAtIndex:withObject:), arrayMClass, @selector(CCP_replaceObjectAtIndex:withObject:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(replaceObjectsAtIndexes:withObjects:), arrayMClass, @selector(CCP_replaceObjectsAtIndexes:withObjects:));
    CCP_exchangeInstanceMethod(arrayMClass, @selector(replaceObjectsInRange:withObjectsFromArray:), arrayMClass, @selector(CCP_replaceObjectsInRange:withObjectsFromArray:));
}

+ (void)exchangeMethodsForNSDictionary{
    Class dictionary = NSClassFromString(@"NSDictionary");
    Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
    CCP_exchangeClassMethod(dictionary, @selector(dictionaryWithObjects:forKeys:count:), @selector(CCP_dictionaryWithObjects:forKeys:count:));
    CCP_exchangeInstanceMethod(__NSPlaceholderDictionary, @selector(initWithObjects:forKeys:count:), __NSPlaceholderDictionary, @selector(CCP_initWithObjects:forKeys:count:));
    CCP_exchangeInstanceMethod(dictionary, @selector(initWithObjects:forKeys:), dictionary, @selector(CCP_initWithObjects:forKeys:));
    CCP_exchangeInstanceMethod(dictionary, @selector(initWithDictionary:copyItems:), dictionary, @selector(CCP_initWithDictionary:copyItems:));
}

+ (void)exchangeMethodsForNSMutableDictionary{
    Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
    CCP_exchangeInstanceMethod(dictionaryM, @selector(setObject:forKey:), dictionaryM, @selector(CCP_dictionaryMSetObject:forKey:));
    CCP_exchangeInstanceMethod(dictionaryM, @selector(removeObjectForKey:), dictionaryM, @selector(CCP_dictionaryMRemoveObjectForKey:));
}

+ (void)exchangeMethodsForNSString{
    Class _NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
    CCP_exchangeInstanceMethod(_NSCFConstantString, @selector(characterAtIndex:), _NSCFConstantString, @selector(CCP_characterAtIndex:));
    CCP_exchangeInstanceMethod(_NSCFConstantString, @selector(substringFromIndex:), _NSCFConstantString, @selector(CCP_substringFromIndex:));
    CCP_exchangeInstanceMethod(_NSCFConstantString, @selector(substringToIndex:), _NSCFConstantString, @selector(CCP_substringToIndex:));
    CCP_exchangeInstanceMethod(_NSCFConstantString, @selector(substringWithRange:), _NSCFConstantString, @selector(CCP_substringWithRange:));
}

+ (void)exchangeMethodsForNSMutableString{
    Class _NSCFNSString = NSClassFromString(@"__NSCFString");
    CCP_exchangeInstanceMethod(_NSCFNSString, @selector(insertString:atIndex:), _NSCFNSString, @selector(CCP_insertString:atIndex:));
    CCP_exchangeInstanceMethod(_NSCFNSString, @selector(deleteCharactersInRange:), _NSCFNSString, @selector(CCP_deleteCharactersInRange:));
    CCP_exchangeInstanceMethod(_NSCFNSString, @selector(replaceCharactersInRange:withString:), _NSCFNSString, @selector(CCP_replaceCharactersInRange:withString:));
}

+ (void)exchangeForwardingTargetForSelector{
    CCP_exchangeInstanceMethod([NSObject class], @selector(forwardingTargetForSelector:), [NSObject class], @selector(CCP_forwardingTargetForSelector:));
}


@end
