//
//  ASI2HTTPRequest.h
//  recipe
//
//  Created by SaRy on 4/12/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "ASIHTTPRequest.h"

@interface ASI2HTTPRequest : ASIHTTPRequest{
    id		_target;
	SEL		_action;
}

-(void) setTarget: (id)target andAction: (SEL)action;

@end
