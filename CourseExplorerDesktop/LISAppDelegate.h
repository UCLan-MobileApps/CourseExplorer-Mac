//
//  LISAppDelegate.h
//  Course Compare
//
//  Created by Desktop on 09/05/2012.
//  Copyright (c) 2012 UCLan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LISXMLParser;
@class LISAppSetup;

@interface LISAppDelegate : NSObject <NSApplicationDelegate, NSXMLParserDelegate> {
    
    LISXMLParser *xmlParser;
    LISAppSetup *appSetup;    
    
    int offset;
    int totalHits;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *courseName;
@property (assign) IBOutlet NSTextField *postcode;

@property (assign) IBOutlet NSWindow *aboutWindow;
@property (assign) IBOutlet NSWindow *resultsWindow;
@property (assign) IBOutlet NSDrawer *detailsDrawer;

@property (nonatomic, retain) LISXMLParser *xmlParser;
@property (nonatomic, retain) LISAppSetup *appSetup;

@property (nonatomic, retain) NSMutableArray *providerArray;
@property (nonatomic, retain) NSMutableArray *qualificationsArray;
@property (nonatomic, retain) NSMutableArray *distanceArray;
@property (nonatomic, retain) NSMutableArray *dunitArray;
@property (nonatomic, retain) NSMutableArray *orderArray;
@property (nonatomic, retain) NSMutableArray *studymodeArray;

@property (assign) IBOutlet NSPopUpButton *provider;
@property (assign) IBOutlet NSPopUpButton *qualifications;
@property (assign) IBOutlet NSPopUpButton *distance;
@property (assign) IBOutlet NSPopUpButton *dunit;
@property (assign) IBOutlet NSPopUpButton *order;
@property (assign) IBOutlet NSPopUpButton *studymode;

@property (weak) IBOutlet NSButton *loadMore;
@property (weak) IBOutlet NSTextField *results;
@property (strong) NSString *totalResults;

@property (weak) IBOutlet NSTableView *resultsTable;
@property (unsafe_unretained) IBOutlet NSTextView *courseText;
@property (strong) NSArray *resultsArray;
@property (assign) NSInteger rowNumber;

@property (weak) IBOutlet NSTextField *courseTitle;
@property (weak) IBOutlet NSButton *previousPage;
@property (weak) IBOutlet NSButton *nextPage;

- (IBAction)search:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)about:(id)sender;

- (IBAction)loadMoreResults:(id)sender;
- (IBAction)loadLessResults:(id)sender;

- (IBAction)subject:(id)sender;
- (IBAction)qualification:(id)sender;
- (IBAction)prerequisites:(id)sender;
- (IBAction)description:(id)sender;
- (IBAction)abstract:(id)sender;
- (IBAction)careeroutcome:(id)sender;
- (IBAction)url:(id)sender;
- (IBAction)provider:(id)sender;
- (IBAction)aim:(id)sender;
- (IBAction)credits:(id)sender;
- (IBAction)presentations:(id)sender;
- (IBAction)assessmentstratergy:(id)sender;
- (IBAction)learningoutcome:(id)sender;
- (IBAction)indicativeresources:(id)sender;
- (IBAction)syllabus:(id)sender;
- (IBAction)leadsto:(id)sender;

-(void)setupMenus;
-(void)displayResults;

@end
