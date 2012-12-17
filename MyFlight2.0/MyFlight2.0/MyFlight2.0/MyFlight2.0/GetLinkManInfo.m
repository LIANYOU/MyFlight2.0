//
//  GetLinkManInfo.m
//  MyFlight2.0
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 LIAN YOU. All rights reserved.
//

#import "GetLinkManInfo.h"

@implementation GetLinkManInfo
-(NSMutableArray *)getAllPersonNameAndPhone{
    NSMutableArray * array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    ABAddressBookRef addressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){

        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }else{

        addressBook = ABAddressBookCreate();
    }
    NSArray *personArray = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSLog(@"%d",[personArray count]);
    for ( id obj in personArray) {
        ABMutableMultiValueRef phone = ABRecordCopyValue(obj, kABPersonPhoneProperty);
        for(int i = 0 ;i < ABMultiValueGetCount(phone); i++)
        {
            NSString * myNumber = (NSString *)ABMultiValueCopyValueAtIndex(phone, i);
            NSString * myName = (NSString *)ABRecordCopyCompositeName(obj);
            NSString * temp1 =  [myNumber stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            NSString * new = [temp1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSDictionary * myDic = [[NSDictionary alloc]initWithObjectsAndKeys:myName,@"name",new,@"phone", nil];
            [array addObject:myDic];
            [myDic release];
        }
    }
    
    CFRelease(personArray);
    CFRelease(addressBook);
    return array;
}


-(NSMutableArray *)ThreeFourFourGetAllPersonNameAndPhone{
    NSMutableArray * array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    ABAddressBookRef addressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){
        
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }else{
        
        addressBook = ABAddressBookCreate();
    }
    NSArray *personArray = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSLog(@"%d",[personArray count]);
    for ( id obj in personArray) {
        ABMutableMultiValueRef phone = ABRecordCopyValue(obj, kABPersonPhoneProperty);
        for(int i = 0 ;i < ABMultiValueGetCount(phone); i++)
        {
            NSString * myNumber = (NSString *)ABMultiValueCopyValueAtIndex(phone, i);
            NSString * myName = (NSString *)ABRecordCopyCompositeName(obj);
            NSString * temp1 =  [myNumber stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            NSString * new = [temp1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSMutableString * tempStr = [NSMutableString stringWithString:new];
            [tempStr insertString:@" " atIndex:7];
            [tempStr insertString:@" " atIndex:3];
            NSString * tff = [NSString stringWithString:tempStr];
            NSDictionary * myDic = [[NSDictionary alloc]initWithObjectsAndKeys:myName,@"name",tff,@"phone", nil];
            [array addObject:myDic];
            [myDic release];
        }
    }
    
    CFRelease(personArray);
    CFRelease(addressBook);
    return array;
}
@end
