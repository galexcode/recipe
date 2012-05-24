//
//  Step.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Step : NSObject{
    NSString* _stepId;
    NSString* _name;
    NSString* _desc;
    NSString* _note;
    NSString* _imagePath;
    int _order;
}

@property (nonatomic) NSString *stepId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *note;
@property  NSString *imagePath;
@property (nonatomic) int order;

@end
