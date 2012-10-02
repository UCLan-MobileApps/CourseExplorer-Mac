//
//  LISAppDelegate.m
/*
Copyright 2012 UCLan (University of Central Lancashire)

Licenced under the BSD 2-Clause Licence.
You may not use this file except in compliance with the License.
You may obtain a copy of the License at:

       http://opensource.org/licenses/bsd-license.php

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#import "LISAppDelegate.h"
#import "LISXMLParser.h"
#import "LISAppSetup.h"

@implementation LISAppDelegate
@synthesize courseText;
@synthesize previousPage;
@synthesize nextPage;
@synthesize courseName, courseTitle;
@synthesize totalResults;

@synthesize window = _window;
@synthesize postcode;
@synthesize aboutWindow;
@synthesize resultsWindow;
@synthesize detailsDrawer;
@synthesize xmlParser;
@synthesize appSetup;
@synthesize provider;
@synthesize qualifications;
@synthesize distance;
@synthesize dunit;
@synthesize order;
@synthesize studymode;
@synthesize loadMore;
@synthesize results;
@synthesize resultsTable, resultsArray, rowNumber;

@synthesize providerArray, qualificationsArray, dunitArray, distanceArray, orderArray, studymodeArray;

-(id)init {
	if(self = [super init]) {
        xmlParser = [[LISXMLParser alloc] initWithDelegate:self];
        appSetup = [[LISAppSetup alloc] initWithDelegate:self];
    }
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    //first load a blank request to determine the parameter lists
    [appSetup parseXMLURL:@"http://coursedata.k-int.com/discover/?adv=&q=blank&provider=&qualification=*&studymode=*&distance=25&dunit=miles&order=distance&location=&format=xml"];
    
    //offset for the number of items searched
    offset = 0;
    
    //table details
    [resultsTable setTarget:self];
    
    //results list
    resultsArray = [NSArray arrayWithContentsOfFile:@"/tmp/catalog.plist"];
    
    //text for the course
    courseText.font = [NSFont systemFontOfSize:14];

}

- (IBAction)search:(id)sender {
    
    //need to remove blank spaces
    NSString *a = courseName.stringValue;
    NSString *course = [a stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    //check for null keyword
    if (course.length == 0) {
        //display alert
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert setMessageText:@"Alert"];
        [alert setInformativeText:@"You need to enter a keyword"];
        [alert beginSheetModalForWindow:_window modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    else {
        
    NSString *institution = @"7e1643a5-457e-4b5a-8fa8-e7c755a03031"; //change for your code, sample OU
    
    NSString *c = qualifications.titleOfSelectedItem;
    NSString *qual = [c stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
    NSString *d = distance.titleOfSelectedItem;
    NSString *dist = [d stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    
    NSString *e = dunit.titleOfSelectedItem;
    NSString *unit = [e stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    
    NSString *f = order.titleOfSelectedItem;
    NSString *ordering = [f stringByReplacingOccurrencesOfString:@" " withString:@""];
 
    
    NSString *g = studymode.titleOfSelectedItem;
    NSString *study = [g stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
    NSString *h = postcode.stringValue; 
    NSString *location = [h stringByReplacingOccurrencesOfString:@" " withString:@"+"];


    //change All / Any to * and headings to *
    if ([qual isEqualToString:@"Qualifications"] || [qual isEqualToString:@"All"]) {
        qual = [NSString stringWithFormat:@"*"];
    }
    if ([study isEqualToString:@"Attendance"] || [study isEqualToString:@"Any"]) {
        study = [NSString stringWithFormat:@"*"];
    }
    if ([dist isEqualToString:@"Distance"]) {
        dist = [NSString stringWithFormat:@"250"];
    }
    if ([ordering isEqualToString:@"OrderBy"] || [ordering isEqualToString:@"Distance(Closest)"]) {
        ordering = [NSString stringWithFormat:@"distance"];
    }
    
    //set the search path
    NSString *searchPath = [NSString stringWithFormat:@"http://coursedata.k-int.com/discover/?adv=true&q=%@&provider=%@&qualification=%@&studyMode=%@&distance=%@&dunit=%@&order=%@&location=%@&max=1000&offset=%i&format=xml", course, institution, qual, study, dist, unit, ordering, location, offset];
    
    //do the search
    [xmlParser parseXMLURL:searchPath];
        
    //get the total number of results
    totalHits = [totalResults intValue];
     
    //update the display
    [self displayResults];
    }
    
}

- (IBAction)about:(id)sender {
    //load about window
    [NSApp beginSheet:aboutWindow modalForWindow:_window modalDelegate:self didEndSelector:nil contextInfo:NULL];
    
    [NSApp runModalForWindow:aboutWindow];
    [NSApp endSheet:aboutWindow];
    [aboutWindow orderOut:self];
}

- (IBAction)loadMoreResults:(id)sender {

    offset = offset+100;
    [self search:self];
}

- (IBAction)loadLessResults:(id)sender {
    
    offset = offset-100;
    [self search:self];
}

//course details
//load the various course details
- (IBAction)subject:(id)sender {

    courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"subject"]];
}

- (IBAction)qualification:(id)sender {
    
    NSString *qualTitle = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"qualtitle"]];
    NSString *awardedBy = [NSString stringWithFormat:@"Awarded By: %@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"awardedBy"]];
    NSString *level = [NSString stringWithFormat:@"Level: %@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"level"]];
    NSString *qualDescription = [NSString stringWithFormat:@"%@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"qualdescription"]];
    NSString *type = [NSString stringWithFormat:@"Type: %@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"type"]];
    NSString *accreditedBy = [NSString stringWithFormat:@"Accredited By: %@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"accreditedBy"]];
    NSString *levelControlledTerm = [NSString stringWithFormat:@"Level Controlled Term: %@", [[resultsArray objectAtIndex:rowNumber] objectForKey:@"levelControlledTerm"]];
    
    courseText.string = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ ", qualTitle, qualDescription, level, type, awardedBy, accreditedBy, levelControlledTerm]; 
}

- (IBAction)prerequisites:(id)sender {
    
    courseText.string = [NSString stringWithFormat: [[resultsArray objectAtIndex:rowNumber] objectForKey:@"prerequisites"]];
}

- (IBAction)description:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"description"]];
}

- (IBAction)abstract:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"abstract"]];
}

- (IBAction)careeroutcome:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"careerOutcome"]];
}

- (IBAction)url:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"url"]];
}

- (IBAction)provider:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"provtitle"]];
}

- (IBAction)aim:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"aim"]];
}

- (IBAction)credits:(id)sender {
    
    NSMutableString *credit = [[NSMutableString alloc] init];
    
    NSArray *creditsArray = [[NSArray alloc] initWithArray:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"credits"]];
    
    for (int x = 0; x < creditsArray.count; x++) {
        
        NSString *level = [NSString stringWithFormat:@"Level = %@", [[creditsArray objectAtIndex:x] objectForKey:@"level"]];
        NSString *scheme = [NSString stringWithFormat:@"Scheme = %@", [[creditsArray objectAtIndex:x] objectForKey:@"scheme"]];
        NSString *val = [NSString stringWithFormat:@"Value = %@", [[creditsArray objectAtIndex:x] objectForKey:@"val"]];
        
        NSString *credits = [NSString stringWithFormat:@"Credit %i \n \n%@ \n%@ \n%@ \n\n", x+1, level, scheme, val];
        
        [credit appendFormat:credits];
    }
    
    courseText.string = [NSString stringWithFormat:credit];
}

- (IBAction)presentations:(id)sender {
    
    NSMutableString *presentations = [[NSMutableString alloc] init];
    
    NSArray *presentationsArray = [[NSArray alloc] initWithArray:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"presentations"]];
    
    for (int x = 0; x < presentationsArray.count; x++) {
        
        NSString *description = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"description"]];
        NSString *studyMode = [NSString stringWithFormat:@"Study Mode: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"studyMode"]];
        NSString *attendancePattern = [NSString stringWithFormat:@"Attendance Pattern: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"attendancePattern"]];
        NSString *entryRequirements = [NSString stringWithFormat:@"Entry Requirements: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"entryRequirements"]];
        NSString *attendanceMode = [NSString stringWithFormat:@"Attendance Mode: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"attendanceMode"]];
        NSString *languageOfInstruction = [NSString stringWithFormat:@"Language of Instruction: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"languageOfInstruction"]];
        NSString *languageOfAssessment = [NSString stringWithFormat:@"Language of Assessment: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"languageOfAssessment"]];
        NSString *start = [NSString stringWithFormat:@"Start: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"start"]];
        NSString *end = [NSString stringWithFormat:@"End: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"end"]];
        NSString *duration = [NSString stringWithFormat:@"Duration: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"duration"]];            
        NSString *cost = [NSString stringWithFormat:@"Cost: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"cost"]];
        NSString *applicationsOpen = [NSString stringWithFormat:@"Applications Open: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"applicationsOpen"]];
        NSString *applicationsClose = [NSString stringWithFormat:@"Applications Close: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"applicationsClose"]];
        NSString *applyTo = [NSString stringWithFormat:@"Apply To: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"applyTo"]];
        NSString *enquireTo = [NSString stringWithFormat:@"Enquire To: %@", [[presentationsArray objectAtIndex:x] objectForKey:@"enquireTo"]];
        NSString *name = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"name"]];
        NSString *street = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"street"]];
        NSString *town = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"town"]];
        NSString *postcode2 = [NSString stringWithFormat:@"%@", [[presentationsArray objectAtIndex:x] objectForKey:@"postcode"]];
        
        NSString *presentation = [NSString stringWithFormat:@"Presentation \n \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n Venue \n \n%@ \n%@ \n%@ \n%@ \n\n", description, studyMode, attendancePattern, entryRequirements, attendanceMode, languageOfInstruction, languageOfAssessment, start, end, duration, cost, applicationsOpen, applicationsClose, applyTo, enquireTo, name, street, town, postcode2];
        
        [presentations appendFormat:presentation];
    }
    
    courseText.string = [NSString stringWithFormat:presentations];

}

- (IBAction)assessmentstratergy:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"assessmentStrategy"]];
}

- (IBAction)learningoutcome:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"learningOutcome"]];
}

- (IBAction)indicativeresources:(id)sender {
    
    courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"indicativeResource"]];
}

- (IBAction)syllabus:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"syllabus"]];
}

- (IBAction)leadsto:(id)sender {
    
     courseText.string = [NSString stringWithFormat:[[resultsArray objectAtIndex:rowNumber] objectForKey:@"leadsTo"]];
}


-(IBAction)close:(id)sender {
    
    [NSApp stopModal];
}

-(void)setupMenus {
    
    //create the headings
    NSString *quals = [NSString stringWithFormat:@"Qualifications"];
    
    //load array
    qualificationsArray = [[NSMutableArray alloc] initWithContentsOfFile:@"/tmp/qualifications.plist"];
    
    //set the heading
    [qualificationsArray replaceObjectAtIndex:0 withObject:quals];
    
    //remove old items and load with array items
    [qualifications removeAllItems];
    [qualifications addItemsWithTitles:qualificationsArray];
    
    //create the headings
    NSString *dist = [NSString stringWithFormat:@"Distance"];
    
    //load array
    distanceArray = [[NSMutableArray alloc] initWithContentsOfFile:@"/tmp/distances.plist"];
    
    //set the heading
    [distanceArray replaceObjectAtIndex:0 withObject:dist];
    
    //remove old items and load with array items
    [distance removeAllItems];
    [distance addItemsWithTitles:distanceArray];
    
    //load array
    dunitArray = [[NSMutableArray alloc] initWithContentsOfFile:@"/tmp/dunits.plist"];
    
    //remove the heading
    [dunitArray removeObjectAtIndex:0];
    
    //remove old items and load with array items
    [dunit removeAllItems];
    [dunit addItemsWithTitles:dunitArray];
    
    //create the headings
    NSString *orders = [NSString stringWithFormat:@"Order By"];
    
    //load array
    orderArray = [[NSMutableArray alloc] initWithContentsOfFile:@"/tmp/orders.plist"];
    
    //set the heading
    [orderArray replaceObjectAtIndex:0 withObject:orders];
    
    //remove old items and load with array items
    [order removeAllItems];
    [order addItemsWithTitles:orderArray];
    
    //create the headings
    NSString *studys = [NSString stringWithFormat:@"Attendance"];
    
    //load array
    studymodeArray = [[NSMutableArray alloc] initWithContentsOfFile:@"/tmp/studymodes.plist"];
    
    //set the heading
    [studymodeArray replaceObjectAtIndex:0 withObject:studys];
    
    //remove old items and load with array items
    [studymode removeAllItems];
    [studymode addItemsWithTitles:studymodeArray];        
}


//display the results
-(void)displayResults {
    
    resultsArray = [NSArray arrayWithContentsOfFile:@"/tmp/catalog.plist"];
    
    if (totalHits == 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert setMessageText:@"Alert"];
        [alert setInformativeText:@"There are no results, enter a boarder search or keyword"];
        [alert beginSheetModalForWindow:_window modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    else {
    
    if (offset == 0) {
        previousPage.hidden = YES;
    }
    else {
        previousPage.hidden = NO;
    }
    
    if ([totalResults intValue] < offset+100 ) {
        nextPage.hidden = YES;
        results.stringValue = [NSString stringWithFormat:@"Total Results %@, Displaying %i - %i", totalResults, offset, totalHits];
    }
    else {
        nextPage.hidden = NO;
        results.stringValue = [NSString stringWithFormat:@"Total Results %@, Displaying %i - %i", totalResults, offset, offset+100];
    }
    
    [resultsWindow makeKeyAndOrderFront:self];
    [resultsTable reloadData];
    }
    
}

#pragma table data

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
   return resultsArray.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    return [[resultsArray objectAtIndex:row] objectForKey:[tableColumn identifier]];

}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    
    [detailsDrawer open:(self)];
    
    rowNumber = row;
    
    courseTitle.stringValue = [[resultsArray objectAtIndex:rowNumber] objectForKey:@"title"];
    courseText.string = [NSString stringWithFormat:@""];

    return YES;
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    
    return YES;
}

@end
