//
//  NSObject+LISAppSetup.m
//  Course Compare
//
//  Created by Desktop on 15/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import "LISAppSetup.h"
#import "LISAppDelegate.h"

@implementation LISAppSetup

@synthesize addressParser;
@synthesize appDelegate;
@synthesize currentArray;
@synthesize studymode, qualification, order, dunit, distance, provider;
@synthesize text, providerName;

-(id)initWithDelegate:(LISAppDelegate*)appDel {
	if(self = [super init]){
        appDelegate = appDel;
    }
	return self;
}

-(void)parseXMLURL:(NSString *)URL {
    
    BOOL success;
    
    NSURL *xmlURL = [NSURL URLWithString:URL];
    
    NSString *xmlFeedStr = [[NSString alloc] initWithContentsOfURL:xmlURL];
    
    NSData *data =[xmlFeedStr dataUsingEncoding:NSUTF8StringEncoding];

    addressParser = [[NSXMLParser alloc] initWithData:data];
    [addressParser setDelegate:self];
    [addressParser setShouldResolveExternalEntities:YES];
    
    success = [addressParser parse];
    
    if (success == YES) {
      //  NSLog(@"success");
        if (appDelegate) 
        [appDelegate setupMenus];
    }
    else {
        NSLog(@"fail");
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
	NSString * errorString = [NSString stringWithFormat:@"Unable to download data (Error code %i )",[parseError code]];
    NSLog(@"%@", errorString);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
   //  NSLog(@"startDoc");
    
    //initalise the current array
    currentArray = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSError *anError;
    
    //remove all old files
    [fileManager removeItemAtPath:@"/tmp/dunits.plist" error:&anError];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict  {
    // NSLog(@"startElement %@", elementName);
    
    //create an object to check for
    id obj;
    
    //create the lists
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"studyMode"]) {
        studymode = [[NSMutableArray alloc] init];
        currentArray = studymode;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"qualification"]) {
        [currentArray writeToFile:@"/tmp/studymodes.plist" atomically:YES];
       // NSLog(@"1 written file");
        qualification = [[NSMutableArray alloc] init];
        currentArray = qualification;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"order"]) {
        [currentArray writeToFile:@"/tmp/qualifications.plist" atomically:YES];
       //  NSLog(@"2 written file");
        order = [[NSMutableArray alloc] init];
        currentArray = order;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"distance"]) {
        [currentArray writeToFile:@"/tmp/orders.plist" atomically:YES];
       //  NSLog(@"3 written file");
        distance = [[NSMutableArray alloc] init];
        currentArray = distance;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"dunit"]) {
        [currentArray writeToFile:@"/tmp/distances.plist" atomically:YES];
        // NSLog(@"4 written file");
        dunit = [[NSMutableArray alloc] init];
        currentArray = dunit;
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"provider"]) {
        
        NSFileManager *fileManger = [[NSFileManager alloc] init];
        NSString *path = [NSString stringWithFormat:@"/tmp/dunits.plist"];
        
        if ([fileManger fileExistsAtPath:path]) {
          //  NSLog(@"dont write");
        }
             else {
                 
        [currentArray writeToFile:@"/tmp/dunits.plist" atomically:YES];
        // NSLog(@"5 written file");
             }
        provider = [[NSMutableArray alloc] init];
        currentArray = provider;
             //}
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"hits"]) {
        [currentArray writeToFile:@"/tmp/providers.plist" atomically:YES];
       //  NSLog(@"6 written file");
       // [currentArray release];
    }
    
    //write the objects
    if ((obj=[attributeDict objectForKey:@"key"])) {
        if (!(currentArray == provider)) {
            [currentArray addObject:[attributeDict objectForKey:@"key"]];
        }
        if (!([attributeDict objectForKey:@"key"] == NULL)) {
            
        providerName = [attributeDict objectForKey:@"key"];
           // NSLog(@"%@",providerName);
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  //   NSLog(@"foundCharacters = %@", string);
    
    //add string for providers only
    if (currentArray == provider) {
      //  if (text) 
        text = [[NSMutableString alloc] init];
        [text appendString:string];
       // NSLog(@"text = %@", text);
        
        NSDictionary *tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:text, @"Code", providerName, @"Name", nil];
        [currentArray addObject:tempDict];
       // NSLog(@"name = %@",currentArray);
    }

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // NSLog(@"endElement %@", elementName);

}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
   //  NSLog(@"endDoc"); 
}

@end
