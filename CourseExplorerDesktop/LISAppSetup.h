//
//  LISAppSetup.h
//  Course Compare
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
