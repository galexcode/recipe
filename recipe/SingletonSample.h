//
//  SingletonSample.h
//  BigBallOfMud
//
//  Created by Jason Agostoni on 1/22/12.
//

#import <Foundation/Foundation.h>
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"
#import "UserXMLHandler.h"
#import "CategoriesXMLHandler.h"

@protocol SingletonSampleDelegate

@optional
//-(void) didFinishRegisterUser:(__weak User *)registerUser;
-(void) didFinishVerifyUser:(__weak User *)loggedUser;
//-(void) didFinishParsedUser:(__weak User *)user;
-(void) didFinishParsedCategories:(__weak NSMutableDictionary *)categoryDictionary;

@end

@interface SingletonSample : NSObject {
    // Instance variables:
    //   - Declare as usual.  The alloc/sharedIntance.
    __weak User* _user;
    __weak NSMutableDictionary* _categoryDictionary;
    NSString *someData;
    __weak id<SingletonSampleDelegate> _delegate;
}

// Properties as usual
@property (nonatomic, retain) NSString *someData;
@property (nonatomic, weak) id<SingletonSampleDelegate> delegate;


// Required: A method to retrieve the shared instance
+(SingletonSample *) sharedInstance;


// Shared Public Methods:
//   - Using static methods for opertations is a nice convenience
//   - Each method should ensure it is using the above sharedInstance
+(id<SingletonSampleDelegate>) getDelegate;
+(void) setDelegate:(id<SingletonSampleDelegate>)delegate;
+(NSString *) getSomeData;
+(void) setSomeData:(NSString *)someData;

+(void) verifyUser:(__weak User*)loggingUser;
+(void) loadCategories:(__weak NSMutableDictionary*)categoryDictionary;


// Instance Methods: Declare and implement as usual
@end
