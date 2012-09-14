//
//  LISXMLParser.h
//  PhoneBook
//
//  Created by Desktop on 27/04/2012.
//  Copyright (c) 2012 UCLan All rights reserved.
//

#import <Foundation/Foundation.h>
 
@class LISAppDelegate;

@interface LISXMLParser : NSObject <NSXMLParserDelegate> {

    NSXMLParser *addressParser;
    
    LISAppDelegate *appDelegate;
    
    NSMutableArray *catalog;
    NSMutableArray *presentations;
    NSMutableArray *credits;
    
    NSMutableDictionary *course;
    NSMutableDictionary *map;
    
    NSMutableString *items;
    NSString *title;
    
    NSString *docsDirectory;
    
    BOOL switchBool;
    BOOL isString;
    BOOL maps;
    BOOL pres;
    BOOL cred;
}

-(id)initWithDelegate:(LISAppDelegate*)appDel;

@property (nonatomic, retain) LISAppDelegate *appDelegate;

@property (nonatomic, retain) NSXMLParser *addressParser;
@property (nonatomic, retain) NSMutableArray *catalog;
@property (nonatomic, retain) NSMutableArray *presentations;
@property (nonatomic, retain) NSMutableArray *credits;
@property (nonatomic, retain) NSMutableDictionary *course;
@property (nonatomic, retain) NSMutableDictionary *map;

@property (nonatomic, retain) NSMutableString *items;
@property (nonatomic, retain) NSString *title;

-(void)parseXMLURL:(NSString *)URL;

@end
