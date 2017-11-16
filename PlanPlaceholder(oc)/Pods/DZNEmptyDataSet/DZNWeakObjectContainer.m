//
//  DZNWeakObjectContainer.m
//  DZNEmptyDataSet
//
//  Created by anan on 2017/11/15.
//

#import "DZNWeakObjectContainer.h"

@implementation DZNWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object
{
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}
@end
