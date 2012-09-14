//
//  LISXMLParser.m
//  PhoneBook
//
//  Created by Desktop on 27/04/2012.
//  Copyright (c) 2012 UCLan All rights reserved.
//

#import "LISXMLParser.h"
#import "LISAppDelegate.h"

/**
 Collection Parameters and set to
 
 Course
 
 abstract = "No Data Provided";
 learningOutcome = "No Data Provided";
 assessmentStrategy = "No Data Provided";
 indicativeResource = "No Data Provided";
 lastModified = "No Data Provided";// not used yet
 description = "No Data Provided";
 provid = "No Data Provided";// not used yet
 provtitle = "No Data Provided";
 provuri = "No Data Provided";// not used yet
 provloclat = "No Data Provided";// not used yet
 provloclon = "No Data Provided";// not used yet
 title = "No Data Provided";
 imageuri = "No Data Provided";// not used yet
 type = "No Data Provided";
 qualtitle = "No Data Provided";
 level = "No Data Provided";
 awardedBy = "No Data Provided";
 qualdescription = "No Data provided";
 accreditedBy = "No Data Provided";
 levelControlledTerm = "No Data Provided";
 aim = "No Data Provided";
 syllabus = "No Data Provided";
 careerOutcome = "No Data Provided";
 prerequisites = "No Data Provided";
 leadsTo = "No Data Provided";
 url = "No Data Provided";
 subject = "No Data Provided";
 subjectKeywords = "No Data Provided";// not used yet
 ecstatus = "No Data Provided";// not used yet
 
 Presentations
 
 description = "No Data Provided";
 start = "No Data Provided";
 end = "No Data Provided";
 duration = "No Data Provided";
 cost = "No Data Provided";
 applicationsOpen = "No Data Provided";
 applicationsClose = "No Data Provided";
 applyTo = "No Data Provided";
 enquireTo = "No Data Provided";
 studyMode = "No Data Provided";
 attendanceMode = "No Data Provided";
 attendancePattern = "No Data Provided";
 languageOfAssessment = "No Data Provided";
 languageOfInstruction = "No Data Provided";
 name = "On Campus";
 street = "";
 town = "";
 postcode = "";
 entryRequirements = "No Data Provided";
 
 Credits
 
 scheme = "No Data Provided";
 level = "No Data Provided";
 val = "No Data Provided";
 **/


@implementation LISXMLParser

@synthesize addressParser;
@synthesize appDelegate;
@synthesize catalog, course, items, presentations, map, credits;
@synthesize title;

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

    //if (addressParser)
    
    addressParser = [[NSXMLParser alloc] initWithData:data];
    [addressParser setDelegate:self];
    [addressParser setShouldResolveExternalEntities:YES];
    
    success = [addressParser parse];
    
    if (success == YES) {
       // NSLog(@"B success");
    }
    else {
       //NSLog(@"B fail");
    }
}

-(void)createCourseTemplate {
    
    course = [[NSMutableDictionary alloc] init];
    
    //prepopulate with data to prevent any (null) values
    
    [course setObject:@"No Data Provided" forKey:@"abstract"];
    [course setObject:@"No Data Provided" forKey:@"learningOutcome"];
    [course setObject:@"No Data Provided" forKey:@"assessmentStrategy"];
    [course setObject:@"No Data Provided" forKey:@"indicativeResource"];
    [course setObject:@"No Data Provided" forKey:@"description"];
    [course setObject:@"No Data Provided" forKey:@"provtitle"];
    [course setObject:@"No Data Provided" forKey:@"title"];
    [course setObject:@"No Data Provided" forKey:@"type"];
    [course setObject:@"No Data Provided" forKey:@"qualtitle"];
    [course setObject:@"No Data Provided" forKey:@"level"];
    [course setObject:@"No Data Provided" forKey:@"awardedBy"];
    [course setObject:@"No Data Provided" forKey:@"levelControlledTerm"];
    [course setObject:@"" forKey:@"qualdescription"];
    [course setObject:@"No Data Provided" forKey:@"aim"];
    [course setObject:@"No Data Provided" forKey:@"accreditedBy"];
    [course setObject:@"No Data Provided" forKey:@"syllabus"];
    [course setObject:@"No Data Provided" forKey:@"prerequisites"];
    [course setObject:@"No Data Provided" forKey:@"leadsTo"];
    [course setObject:@"No Data Provided" forKey:@"url"];
    [course setObject:@"No Data Provided" forKey:@"subject"];
    [course setObject:@"No Data Provided" forKey:@"careerOutcome"];
    
}

-(void)createMapTemplate {
    
    map = [[NSMutableDictionary alloc] init];
    
    //prepopulate with data to prevent any (null) values
    
    if (pres == true) {
        [map setObject:@"" forKey:@"description"];
        [map setObject:@"No Data Provided" forKey:@"start"];
        [map setObject:@"No Data Provided" forKey:@"end"];
        [map setObject:@"No Data Provided" forKey:@"duration"];
        [map setObject:@"No Data Provided" forKey:@"cost"];
        [map setObject:@"No Data Provided" forKey:@"applicationsOpen"];
        [map setObject:@"No Data Provided" forKey:@"applicationsClose"];
        [map setObject:@"No Data Provided" forKey:@"applyTo"];
        [map setObject:@"No Data Provided" forKey:@"enquireTo"];
        [map setObject:@"No Data Provided" forKey:@"studyMode"];
        [map setObject:@"No Data Provided" forKey:@"attendancePattern"];
        [map setObject:@"No Data Provided" forKey:@"attendanceMode"];
        [map setObject:@"No Data Provided" forKey:@"languageOfAssessment"];
        [map setObject:@"No Data Provided" forKey:@"languageOfInstruction"];
        [map setObject:@"On Campus" forKey:@"name"];
        [map setObject:@"" forKey:@"street"];
        [map setObject:@"" forKey:@"town"];
        [map setObject:@"" forKey:@"postcode"];
        [map setObject:@"" forKey:@"entryRequirements"];
    }
    
    if (cred == true) {
        [map setObject:@"No Data Provided" forKey:@"scheme"];
        [map setObject:@"No Data Provided" forKey:@"level"];
        [map setObject:@"No Data Provided" forKey:@"val"];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
	NSString * errorString = [NSString stringWithFormat:@"Unable to download data (Error code %i )",[parseError code]];
    NSLog(@"%@", errorString);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  //  NSLog(@"startDoc");
    
    catalog = [[NSMutableArray alloc] init];

    //set bool to false;
   // switchBool = FALSE;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict  {
    // NSLog(@"startElement %@", elementName);
    
    //create an object to check for
    id obj;
    
    //total items
    if ([elementName isEqualToString:@"totalHits"]) {
        
        items = [[NSMutableString alloc] init];
    }
    
    //start the course entry
    if ([elementName isEqualToString:@"source"]) {
        
        [self createCourseTemplate];
        
        //set variables
        switchBool = FALSE;
        isString = FALSE;
        maps = FALSE;
        pres = FALSE;
        cred = FALSE;
    }
    
    if ([elementName isEqualToString:@"entry"]) {
        // if (items) 
        items = [[NSMutableString alloc] init];
    }
    
    if ([elementName isEqualToString:@"string"]) {
        isString = TRUE;
    }
    
    if ([elementName isEqualToString:@"map"]) {
        maps = TRUE;
        [self createMapTemplate];
        //   NSLog(@"set map");
    }
    
    //used for duplicate title and description
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"qual"]) {
        switchBool = TRUE;
        // NSLog(@"switching");
    }
    
    //multiple options
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"presentations"]) {
        pres = TRUE;
        cred = FALSE;
        presentations = [[NSMutableArray alloc] init];
        // NSLog(@"set presentations");
    }
    
    if ([[attributeDict objectForKey:@"key"] isEqualToString:@"credits"]) {
        cred = TRUE;
        pres = FALSE;
        credits = [[NSMutableArray alloc] init];
    }
    
    if ((obj=[attributeDict objectForKey:@"key"])) {
        
        if (!([attributeDict objectForKey:@"key"] == NULL)) {
            
            if ([[attributeDict objectForKey:@"key"] isEqualToString:@"title"]) {
                if (switchBool == TRUE) {
                    title = @"qualtitle";
                    // NSLog(@"change title %@", title);
                }
                else {
                    title = [attributeDict objectForKey:@"key"];
                    // NSLog(@"original title %@", title);
                }
                
            }
            
            else if ([[attributeDict objectForKey:@"key"] isEqualToString:@"description"]) {
                if (switchBool == TRUE) {
                    title = @"qualdescription";
                }
                else {
                    title = [attributeDict objectForKey:@"key"];
                }
                //  NSLog(@"change title");
            }
            
            else {
                
                title = [attributeDict objectForKey:@"key"];
                // NSLog(@"name %@", title);
            }
            //NSLog(@"%@",providerName);
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (isString == TRUE) {
        [items appendFormat:@" %@,", string]; //apend the items if the data is in a string
    }
    else {
        [items appendFormat:string]; //apend the items 
    }
    
    //  NSLog(@"items = %@", items);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // NSLog(@"endElement %@", elementName);
    
    if ([elementName isEqualToString:@"totalHits"]) {
       // NSLog(@"total = %@",items);
        appDelegate.totalResults = items;
    }
    
    if ([elementName isEqualToString:@"entry"]) {
        
        if (maps == TRUE) {
            [map setObject:[items copy] forKey:title];
            //  NSLog(@"adding map item");
        }
        
        else {
            if (items.length > 0) {
                
                [course setObject:[items copy] forKey:title];
            }
            // NSLog(@"adding to course");
        }
        //  NSLog(@"title = %@, value = %@",title, items);
    }
    
    if ([elementName isEqualToString:@"map"]) {
        //  NSLog(@"map = %@", map);
        if (pres == TRUE) {
            [presentations addObject:map];
        }
        else if (cred == TRUE) {
            [credits addObject:map];
        }
        maps = FALSE;
    }
    
    //end the course entry
    if ([elementName isEqualToString:@"source"]) {
        [course setObject:presentations forKey:@"presentations"];
        [course setObject:credits forKey:@"credits"];
        [catalog addObject:course];
        
        pres = FALSE;
        cred = FALSE;
    }
    
    //string elements
    if ([elementName isEqualToString:@"string"]) {
        isString = FALSE;
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
  //NSLog(@"endDoc"); 
    
    //write the whole Array to file and release
    [catalog writeToFile:@"/tmp/catalog.plist" atomically:YES];
}

@end
