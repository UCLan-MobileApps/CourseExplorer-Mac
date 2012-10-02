//
//  LISXMLParser.h

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
