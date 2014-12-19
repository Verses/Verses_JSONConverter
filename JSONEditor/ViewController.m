//
//  ViewController.m
//  JSONEditor
//
//  Created by Zach Whelchel on 11/8/14.
//  Copyright (c) 2014 JSONEditor. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dict = [self dictionaryWithContentsOfJSONString:@"ESV.json"];
    NSArray * bookNames = [dict allKeys];
    NSArray * books = [dict objectsForKeys:bookNames notFoundMarker:[NSNull null]];

    NSMutableDictionary *mainDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < books.count; i++) {
        
        
        NSMutableDictionary *chapDictionary = [NSMutableDictionary dictionary];

        NSDictionary *dict2 = [books objectAtIndex:i];
        
        NSArray * chapNames = [dict2 allKeys];
        NSArray * chaps = [dict2 objectsForKeys:chapNames notFoundMarker:[NSNull null]];

        
        NSMutableArray * chapDicts = [NSMutableArray array];

        for (int i = 0; i < chaps.count; i++) {
            
            NSMutableDictionary *chapDictionary = [NSMutableDictionary dictionary];
            
            NSDictionary *dict3 = [chaps objectAtIndex:i];
            NSArray * verseNames = [dict3 allKeys];
            NSArray * verses = [dict3 objectsForKeys:verseNames notFoundMarker:[NSNull null]];

            
            NSMutableArray * verseDicts = [NSMutableArray array];

            for (int i = 0; i < verses.count; i++) {
                NSMutableDictionary *verseDictionary = [NSMutableDictionary dictionary];
                
                [verseDictionary setValue:[verseNames objectAtIndex:i] forKey:@"_num"];
                [verseDictionary setValue:[verses objectAtIndex:i] forKey:@"__text"];
                
                [verseDicts addObject:verseDictionary];
            }
            
            // sort verses dicts
            
            NSArray *sortedVerses;
            sortedVerses = [verseDicts sortedArrayUsingComparator:^(NSDictionary *first, NSDictionary *second) {
                
                int i = [[first valueForKey:@"_num"] intValue];
                int j = [[second valueForKey:@"_num"] intValue];
                
                return [[NSNumber numberWithInt:i] compare:[NSNumber numberWithInt:j]];
            }];

            
            
            
            [chapDictionary setValue:[chapNames objectAtIndex:i] forKey:@"_num"];
            [chapDictionary setValue:sortedVerses forKey:@"verse"];

            [chapDicts addObject:chapDictionary];
        }
        
        
        NSArray *sortedChaps;
        sortedChaps = [chapDicts sortedArrayUsingComparator:^(NSDictionary *first, NSDictionary *second) {
            
            int i = [[first valueForKey:@"_num"] intValue];
            int j = [[second valueForKey:@"_num"] intValue];
            
            return [[NSNumber numberWithInt:i] compare:[NSNumber numberWithInt:j]];
        }];

        
        [chapDictionary setValue:sortedChaps forKey:@"chapter"];
        [chapDictionary setValue:[self shortNameForBook:[bookNames objectAtIndex:i]] forKey:@"_num"];
        [chapDictionary setValue:[bookNames objectAtIndex:i] forKey:@"_num_full"];

        [array addObject:chapDictionary];
    }
    
    
    
    
    
    
    NSArray *sortedBooks;
    sortedBooks = [array sortedArrayUsingComparator:^(NSDictionary *first, NSDictionary *second) {
        
        
        NSString *string1 = [first valueForKey:@"_num_full"];
        NSString *string2 = [second valueForKey:@"_num_full"];
        
        int i = [self orderForBook:string1];
        int j = [self orderForBook:string2];
        
        return [[NSNumber numberWithInt:i] compare:[NSNumber numberWithInt:j]];
    }];

    
    
    
    
    
    
    
    [mainDictionary setValue:sortedBooks forKey:@"book"];
    [mainDictionary setValue:@"ESV" forKey:@"_abbrev"];
    [mainDictionary setValue:@"English Standard Version" forKey:@"_name"];

    
    
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mainDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    [self.textField setStringValue:[NSString stringWithFormat:@"%@", jsonString]];
    
    // Do any additional setup after loading the view.
}

- (NSString *)shortNameForBook:(NSString *)bookName
{
    NSString *string = @"";
    
    if ([bookName isEqualToString:@"Genesis"]) {
        string = @"Gen";
    }
    
    if ([bookName isEqualToString:@"Exodus"]) {
        string = @"Exod";
    }
    
    
    if ([bookName isEqualToString:@"Leviticus"]) {
        string = @"Lev";
    }
    
    
    if ([bookName isEqualToString:@"Numbers"]) {
        string = @"Num";
    }
    
    
    if ([bookName isEqualToString:@"Deuteronomy"]) {
        string = @"Deut";
    }
    
    
    if ([bookName isEqualToString:@"Joshua"]) {
        string = @"Josh";
    }
    
    
    if ([bookName isEqualToString:@"Judges"]) {
        string = @"Judg";
    }
    
    
    if ([bookName isEqualToString:@"Ruth"]) {
        string = @"Ruth";
    }
    
    
    if ([bookName isEqualToString:@"1 Samuel"]) {
        string = @"1Sam";
    }
    
    
    if ([bookName isEqualToString:@"2 Samuel"]) {
        string = @"2Sam";
    }
    
    
    if ([bookName isEqualToString:@"1 Kings"]) {
        string = @"1Kgs";
    }
    
    
    if ([bookName isEqualToString:@"2 Kings"]) {
        string = @"2Kgs";
    }
    
    
    if ([bookName isEqualToString:@"1 Chronicles"]) {
        string = @"1Chr";
    }
    
    
    if ([bookName isEqualToString:@"2 Chronicles"]) {
        string = @"2Chr";
    }
    
    
    if ([bookName isEqualToString:@"Ezra"]) {
        string = @"Ezra";
    }
    
    
    if ([bookName isEqualToString:@"Nehemiah"]) {
        string = @"Neh";
    }
    
    
    if ([bookName isEqualToString:@"Esther"]) {
        string = @"Esth";
    }
    
    
    if ([bookName isEqualToString:@"Job"]) {
        string = @"Job";
    }
    
    
    if ([bookName isEqualToString:@"Psalms"]) {
        string = @"Ps";
    }
    
    
    if ([bookName isEqualToString:@"Proverbs"]) {
        string = @"Prov";
    }
    
    
    if ([bookName isEqualToString:@"Ecclesiastes"]) {
        string = @"Eccl";
    }
    
    
    if ([bookName isEqualToString:@"Song of Solomon"]) {
        string = @"Song";
    }
    
    
    if ([bookName isEqualToString:@"Isaiah"]) {
        string = @"Isa";
    }
    
    
    if ([bookName isEqualToString:@"Jeremiah"]) {
        string = @"Jer";
    }
    
    
    if ([bookName isEqualToString:@"Lamentations"]) {
        string = @"Lam";
    }
    
    
    if ([bookName isEqualToString:@"Ezekiel"]) {
        string = @"Ezek";
    }
    
    
    if ([bookName isEqualToString:@"Daniel"]) {
        string = @"Dan";
    }
    
    
    if ([bookName isEqualToString:@"Hosea"]) {
        string = @"Hos";
    }
    
    
    if ([bookName isEqualToString:@"Joel"]) {
        string = @"Joel";
    }
    
    
    if ([bookName isEqualToString:@"Amos"]) {
        string = @"Amos";
    }
    
    
    if ([bookName isEqualToString:@"Obadiah"]) {
        string = @"Obad";
    }
    
    
    if ([bookName isEqualToString:@"Jonah"]) {
        string = @"Jonah";
    }
    
    
    if ([bookName isEqualToString:@"Micah"]) {
        string = @"Mic";
    }
    
    
    if ([bookName isEqualToString:@"Nahum"]) {
        string = @"Nah";
    }
    
    
    if ([bookName isEqualToString:@"Habakkuk"]) {
        string = @"Hab";
    }
    
    
    if ([bookName isEqualToString:@"Zephaniah"]) {
        string = @"Zeph";
    }
    
    
    if ([bookName isEqualToString:@"Haggai"]) {
        string = @"Hag";
    }
    
    
    if ([bookName isEqualToString:@"Zechariah"]) {
        string = @"Zech";
    }
    
    
    if ([bookName isEqualToString:@"Malachi"]) {
        string = @"Mal";
    }
    
    
    
    if ([bookName isEqualToString:@"Matthew"]) {
        string = @"Matt";
    }
    
    
    if ([bookName isEqualToString:@"Mark"]) {
        string = @"Mark";
    }
    
    
    if ([bookName isEqualToString:@"Luke"]) {
        string = @"Luke";
    }
    
    
    if ([bookName isEqualToString:@"John"]) {
        string = @"John";
    }
    
    if ([bookName isEqualToString:@"Acts"]) {
        string = @"Acts";
    }
    
    
    if ([bookName isEqualToString:@"Romans"]) {
        string = @"Rom";
    }
    
    
    if ([bookName isEqualToString:@"1 Corinthians"]) {
        string = @"1Cor";
    }
    
    
    if ([bookName isEqualToString:@"2 Corinthians"]) {
        string = @"2Cor";
    }
    
    
    if ([bookName isEqualToString:@"Galatians"]) {
        string = @"Gal";
    }
    
    
    if ([bookName isEqualToString:@"Ephesians"]) {
        string = @"Eph";
    }
    
    
    if ([bookName isEqualToString:@"Philippians"]) {
        string = @"Phil";
    }
    
    
    if ([bookName isEqualToString:@"Colossians"]) {
        string = @"Col";
    }
    
    if ([bookName isEqualToString:@"1 Thessalonians"]) {
        string = @"1Thess";
    }
    
    
    if ([bookName isEqualToString:@"2 Thessalonians"]) {
        string = @"2Thess";
    }
    
    
    if ([bookName isEqualToString:@"1 Timothy"]) {
        string = @"1Tim";
    }
    
    
    if ([bookName isEqualToString:@"2 Timothy"]) {
        string = @"2Tim";
    }
    
    
    if ([bookName isEqualToString:@"Titus"]) {
        string = @"Titus";
    }
    
    
    if ([bookName isEqualToString:@"Philemon"]) {
        string = @"Phlm";
    }
    
    
    if ([bookName isEqualToString:@"Hebrews"]) {
        string = @"Heb";
    }
    
    
    if ([bookName isEqualToString:@"James"]) {
        string = @"Jas";
    }
    
    
    if ([bookName isEqualToString:@"1 Peter"]) {
        string = @"1Pet";
    }
    
    
    if ([bookName isEqualToString:@"2 Peter"]) {
        string = @"2Pet";
    }
    
    
    if ([bookName isEqualToString:@"1 John"]) {
        string = @"1John";
    }
    
    
    if ([bookName isEqualToString:@"2 John"]) {
        string = @"2John";
    }
    
    
    if ([bookName isEqualToString:@"3 John"]) {
        string = @"3John";
    }
    
    
    if ([bookName isEqualToString:@"Jude"]) {
        string = @"Jude";
    }
    
    
    if ([bookName isEqualToString:@"Revelation"]) {
        string = @"Rev";
    }

    
    return string;
}


- (int)orderForBook:(NSString *)bookName
{
    int i = 0;
    if ([bookName isEqualToString:@"Genesis"]) {
        i = 1;
    }
    
    if ([bookName isEqualToString:@"Exodus"]) {
        i = 2;
    }

    
    if ([bookName isEqualToString:@"Leviticus"]) {
        i = 3;
    }

    
    if ([bookName isEqualToString:@"Numbers"]) {
        i = 4;
    }

    
    if ([bookName isEqualToString:@"Deuteronomy"]) {
        i = 5;
    }

    
    if ([bookName isEqualToString:@"Joshua"]) {
        i = 6;
    }

    
    if ([bookName isEqualToString:@"Judges"]) {
        i = 7;
    }

    
    if ([bookName isEqualToString:@"Ruth"]) {
        i = 8;
    }

    
    if ([bookName isEqualToString:@"1 Samuel"]) {
        i = 9;
    }

    
    if ([bookName isEqualToString:@"2 Samuel"]) {
        i = 10;
    }

    
    if ([bookName isEqualToString:@"1 Kings"]) {
        i = 11;
    }

    
    if ([bookName isEqualToString:@"2 Kings"]) {
        i = 12;
    }

    
    if ([bookName isEqualToString:@"1 Chronicles"]) {
        i = 13;
    }

    
    if ([bookName isEqualToString:@"2 Chronicles"]) {
        i = 14;
    }

    
    if ([bookName isEqualToString:@"Ezra"]) {
        i = 15;
    }

    
    if ([bookName isEqualToString:@"Nehemiah"]) {
        i = 16;
    }

    
    if ([bookName isEqualToString:@"Esther"]) {
        i = 17;
    }

    
    if ([bookName isEqualToString:@"Job"]) {
        i = 18;
    }

    
    if ([bookName isEqualToString:@"Psalms"]) {
        i = 19;
    }

    
    if ([bookName isEqualToString:@"Proverbs"]) {
        i = 20;
    }

    
    if ([bookName isEqualToString:@"Ecclesiastes"]) {
        i = 21;
    }

    
    if ([bookName isEqualToString:@"Song of Solomon"]) {
        i = 22;
    }

    
    if ([bookName isEqualToString:@"Isaiah"]) {
        i = 23;
    }

    
    if ([bookName isEqualToString:@"Jeremiah"]) {
        i = 24;
    }

    
    if ([bookName isEqualToString:@"Lamentations"]) {
        i = 25;
    }

    
    if ([bookName isEqualToString:@"Ezekiel"]) {
        i = 26;
    }

    
    if ([bookName isEqualToString:@"Daniel"]) {
        i = 27;
    }

    
    if ([bookName isEqualToString:@"Hosea"]) {
        i = 28;
    }

    
    if ([bookName isEqualToString:@"Joel"]) {
        i = 29;
    }

    
    if ([bookName isEqualToString:@"Amos"]) {
        i = 30;
    }

    
    if ([bookName isEqualToString:@"Obadiah"]) {
        i = 31;
    }

    
    if ([bookName isEqualToString:@"Jonah"]) {
        i = 32;
    }

    
    if ([bookName isEqualToString:@"Micah"]) {
        i = 33;
    }

    
    if ([bookName isEqualToString:@"Nahum"]) {
        i = 34;
    }

    
    if ([bookName isEqualToString:@"Habakkuk"]) {
        i = 35;
    }

    
    if ([bookName isEqualToString:@"Zephaniah"]) {
        i = 36;
    }

    
    if ([bookName isEqualToString:@"Haggai"]) {
        i = 37;
    }

    
    if ([bookName isEqualToString:@"Zechariah"]) {
        i = 38;
    }

    
    if ([bookName isEqualToString:@"Malachi"]) {
        i = 39;
    }

    
    
    if ([bookName isEqualToString:@"Matthew"]) {
        i = 40;
    }

    
    if ([bookName isEqualToString:@"Mark"]) {
        i = 41;
    }

    
    if ([bookName isEqualToString:@"Luke"]) {
        i = 42;
    }

    
    if ([bookName isEqualToString:@"John"]) {
        i = 43;
    }

    if ([bookName isEqualToString:@"Acts"]) {
        i = 44;
    }

    
    if ([bookName isEqualToString:@"Romans"]) {
        i = 45;
    }

    
    if ([bookName isEqualToString:@"1 Corinthians"]) {
        i = 46;
    }

    
    if ([bookName isEqualToString:@"2 Corinthians"]) {
        i = 47;
    }

    
    if ([bookName isEqualToString:@"Galatians"]) {
        i = 48;
    }

    
    if ([bookName isEqualToString:@"Ephesians"]) {
        i = 49;
    }

    
    if ([bookName isEqualToString:@"Philippians"]) {
        i = 50;
    }

    
    if ([bookName isEqualToString:@"Colossians"]) {
        i = 51;
    }

    
    if ([bookName isEqualToString:@"1 Thessalonians"]) {
        i = 52;
    }

    
    if ([bookName isEqualToString:@"2 Thessalonians"]) {
        i = 53;
    }

    
    if ([bookName isEqualToString:@"1 Timothy"]) {
        i = 54;
    }

    
    if ([bookName isEqualToString:@"2 Timothy"]) {
        i = 55;
    }

    
    if ([bookName isEqualToString:@"Titus"]) {
        i = 56;
    }

    
    if ([bookName isEqualToString:@"Philemon"]) {
        i = 57;
    }

    
    if ([bookName isEqualToString:@"Hebrews"]) {
        i = 58;
    }

    
    if ([bookName isEqualToString:@"James"]) {
        i = 59;
    }

    
    if ([bookName isEqualToString:@"1 Peter"]) {
        i = 60;
    }

    
    if ([bookName isEqualToString:@"2 Peter"]) {
        i = 61;
    }

    
    if ([bookName isEqualToString:@"1 John"]) {
        i = 62;
    }

    
    if ([bookName isEqualToString:@"2 John"]) {
        i = 63;
    }

    
    if ([bookName isEqualToString:@"3 John"]) {
        i = 64;
    }

    
    if ([bookName isEqualToString:@"Jude"]) {
        i = 65;
    }

    
    if ([bookName isEqualToString:@"Revelation"]) {
        i = 66;
    }

    return i;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
