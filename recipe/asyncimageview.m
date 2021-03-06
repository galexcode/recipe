//
//  AsyncImageView.m
//  Postcard
//
//  Created by markj on 2/18/09.
//  Copyright 2009 Mark Johnson. You have permission to copy parts of this code into your own projects for any use.
//  www.markj.net
//

#import "AsyncImageView.h"
//#import "ipcGlobal.h"


// This class demonstrates how the URL loading system can be used to make a UIView subclass
// that can download and display an image asynchronously so that the app doesn't block or freeze
// while the image is downloading. It works fine in a UITableView or other cases where there
// are multiple images being downloaded and displayed all at the same time. 

@implementation AsyncImageView
@synthesize delegate = _delegate;

- (void)loadImageFromURL:(NSURL*)url forButton:(UIButton *)button {
	if (connection!=nil) { connection = nil; } //in case we are downloading a 2nd image
	if (data!=nil) { data = nil; }
	cbutton = button;
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
	//TODO error handling, what if connection is nil?
}

- (void)loadImageFromURL:(NSURL*)url forButtonIndex:(NSInteger)cindex {
	if (connection!=nil) { connection = nil; } //in case we are downloading a 2nd image
	if (data!=nil) { data = nil; }
	index = cindex;
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
	//TODO error handling, what if connection is nil?
}

//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//so self data now has the complete image 
	connection=nil;
	
	image = [UIImage imageWithData:data];

	data=nil;
    
    if (_delegate != nil)
        [_delegate didFinishLoadingImage:image forButtonIndex:index];
}

//just in case you want to get the image directly, here it is in subviews
- (UIImage*) getsImage {
	return image;
}

@end
