//
//  DZNWeakObjectContainer.h
//  DZNEmptyDataSet
//
//  Created by anan on 2017/11/15.
//

#import <Foundation/Foundation.h>

@interface DZNWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;

- (instancetype)initWithWeakObject:(id)object;
@end
