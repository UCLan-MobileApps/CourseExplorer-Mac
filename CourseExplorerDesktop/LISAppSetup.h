//
//  LISAppSetup.h
//  Course Compare
//
//  Created by Desktop on 15/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LISAppDelegate;

@interface LISAppSetup : NSObject <NSXMLParserDelegate> {
    
    NSXMLParser *addressParser;
    
    LISAppDelegate *appDelegate;
    
    NSMutableArray *currentArray;
    
    NSMutableArray *studymode;
    NSMutableArray *qualification;
    NSMutableArray *order;
    NSMutableArray *distance;
    NSMutableArray *dunit;
    NSMutableArray *provider;
    
    NSMutableString *text;
    NSString *providerName;

}
-(id)initWithDelegate:(LISAppDelegate*)appDel;

@property (nonatomic, retain) NSXMLParser *addressParser;
@property (nonatomic, retain) LISAppDelegate *appDelegate;

@property (nonatomic, retain) NSMutableArray *currentArray;

@property (nonatomic, retain) NSMutableArray *studymode;
@property (nonatomic, retain) NSMutableArray *qualification;
@property (nonatomic, retain) NSMutableArray *order;
@property (nonatomic, retain) NSMutableArray *distance;
@property (nonatomic, retain) NSMutableArray *dunit;
@property (nonatomic, retain) NSMutableArray *provider;

@property (nonatomic, retain) NSMutableString *text;
@property (nonatomic, retain) NSString *providerName;

-(void)parseXMLURL:(NSString *)URL;

@end
