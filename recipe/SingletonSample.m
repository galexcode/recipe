//
//  SingletonSample.m
//  BigBallOfMud
//
//  Created by Jason Agostoni on 1/22/12.
//

#import "SingletonSample.h"



@implementation SingletonSample

@synthesize someData;
@synthesize delegate = _delegate;

#pragma mark Singleton Implementation
static SingletonSample *sharedObject;
+ (SingletonSample*)sharedInstance
{
    if (sharedObject == nil) {
        sharedObject = [[super allocWithZone:NULL] init];
    }
    return sharedObject;
}



/* Pre iOS 5 ARC - Implement for iOS 4 and earlier
+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}
*/


#pragma mark Shared Public Methods
+(NSString *) getSomeData {
    // Ensure we are using the shared instance
    SingletonSample *shared = [SingletonSample sharedInstance];
    return shared.someData;
}

+(void) setSomeData:(NSString *)someData {
    // Ensure we are using the shared instance
    SingletonSample *shared = [SingletonSample sharedInstance];
    shared.someData = someData;
}
+(id<SingletonSampleDelegate>) getDelegate
{
    SingletonSample *shared = [SingletonSample sharedInstance];
    return [shared delegate];
}
+(void) setDelegate:(id<SingletonSampleDelegate>)delegate
{
    SingletonSample *shared = [SingletonSample sharedInstance];
    [shared setDelegate:delegate];
}

+(void) verifyUser: (__weak User*)loggingUser
{
    SingletonSample *shared = [SingletonSample sharedInstance];
    [shared verifyUser:loggingUser];
}

-(void) verifyUser:(__weak User *)loggingUser
{
    _user = loggingUser;
    
    //    [_user setUserId:@"1"];
    //    [_user setName:@"my name"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/login.xml"];
    
    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    //    [request setPostValue:[loggingUser name] forKey:@"u"];
    //    [request setPostValue:[loggingUser password] forKey:@"p"];
    
    [request setTarget:self andAction:@selector(gotLoggingUserByRequest:)];
    
    [request startAsynchronous];
    //[self gotLoggingUserByRequest:nil];
}

-(void) gotLoggingUserByRequest:(ASI2HTTPRequest *)request
{
    //NSLog(@"%d", request.responseStatusCode);
    if (request.responseStatusCode == 200) {
        UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
        [handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser)];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
        parser.delegate = handler;
        [parser parse];
    } else {
        SingletonSample *shared = [SingletonSample sharedInstance];
        [[shared delegate] didFinishVerifyUser:nil];
    }
    
    //[self didParsedLoggingUser];
}

-(void) didParsedLoggingUser
{
    SingletonSample *shared = [SingletonSample sharedInstance];
    [[shared delegate] didFinishVerifyUser:_user];
}

#pragma mark load Categories
+(void) loadCategories:(__weak NSMutableDictionary*)categoryDictionary
{
    SingletonSample *shared = [SingletonSample sharedInstance];
    [shared loadCategories:categoryDictionary];
}

-(void) loadCategories:(__weak NSMutableDictionary*)categoryDictionary
{
    _categoryDictionary = categoryDictionary;
    
    NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/categories.xml"];
    
    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    //    [request setPostValue:@"1" forKey:@"rw_app_id"];
    //    [request setPostValue:@"test" forKey:@"code"];
    //    [request setPostValue:@"test" forKey:@"device_id"];
    
    [request setTarget:self andAction:@selector(gotCategoriesByRequest:)];
    
    [request startAsynchronous];
}

-(void) gotCategoriesByRequest:(ASI2HTTPRequest *)request
{
    if (request.responseStatusCode == 200) {
        CategoriesXMLHandler* handler = [[CategoriesXMLHandler alloc] initWithCategoryDictionary:_categoryDictionary];
        [handler setEndDocumentTarget:self andAction:@selector(didParsedCategories)];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
        parser.delegate = handler;
        [parser parse];
    }
    else {
        SingletonSample *shared = [SingletonSample sharedInstance];
        [[shared delegate] didFinishParsedCategories:nil];
    }
    
    
}

-(void) didParsedCategories{
    SingletonSample *shared = [SingletonSample sharedInstance];
    [[shared delegate] didFinishParsedCategories:_categoryDictionary];
}

@end
