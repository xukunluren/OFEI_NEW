//
//  dataAnaly.m
//  OFei
//
//  Created by admin on 15/12/8.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "dataAnaly.h"

@implementation dataAnaly



//风速判断
- (NSString *)judgeWindPower:(NSNumber *)number
{

    NSString *power;
    CGFloat i = [number doubleValue];
    
    
    if (i<0.4) {
        power = @"0";
    }
    else if (i<1.6) {
        power = @"1";
    }
    else if (i<3.4) {
        power = @"2";
    }
    else   if (i<5.5) {
        power = @"3";
    }
    else if (i<8.0) {
        power = @"4";
    }
    else  if (i<10.8) {
        power = @"5";
    }
    else if (i<13.9) {
        power = @"6";
    }
    else if (i<17.2) {
        power = @"7";
    }
    else if (i<20.8) {
        power = @"8";
    }
    else  if (i<24.5) {
        power = @"9";
    }
    else if (i<28.5) {
        power = @"10";
    }
    else  if (i<32.7) {
        power = @"11";
    }
    else  if (i<37) {
        power = @"12";
    }
    else  if (i<41.5) {
        power = @"13";
    }
    else  if (i<46.2) {
        power = @"14";
    }
    else  if (i<51.1) {
        power = @"15";
    }
    else  if (i<56.1) {
        power = @"16";
    }
    
    return power;
}

- (NSString *)judgeDirectionPower:(NSNumber *)str
{
    NSString *direc;
    float nnn = str.floatValue;
    if (nnn<11.26) {
        direc = @"N";
    }
    else if (nnn<33.76){
        direc = @"NNE";
    }
    else if (nnn<56.26){
        direc = @"NE";
    }
    else if (nnn<78.76){
        direc = @"ENE";
    }
    
    if (nnn<101.26) {
        direc = @"E";
    }
    else if (nnn<123.76){
        direc = @"ESE";
    }
    else if (nnn<56.26){
        direc = @"NE";
    }
    else if (nnn<146.26){
        direc = @"SE";
    }
    else if (nnn<168.76) {
        direc = @"SSE";
    }
    else if (nnn<191.26){
        direc = @"S";
    }
    else if (nnn<213.76){
        direc = @"SSW";
    }
    else if (nnn<236.25){
        direc = @"SW";
    }
    else if (nnn<258.76) {
        direc = @"WSW";
    }
    else if (nnn<258.76){
        direc = @"W";
    }
    else if (nnn<303.75){
        direc = @"WNW";
    }
    else if (nnn<326.25){
        direc = @"NW";
    }
    else if (nnn<348.75){
        direc = @"NNW";
    }
    else {
        direc = @"N";
    }
    return direc;



}



#pragma 字符串的分割
-(NSString *)stringForAnaly:(NSString *)string
{
    NSString *dateString1 = string;
    NSString *dateString2 = [dateString1 substringFromIndex:5];//截取下标5之后的字符串
    NSString *dateString3 = [dateString2 substringToIndex:8];//截取下标2之前的字符串
    NSArray *array1 = [dateString3 componentsSeparatedByString:@"-"]; //
    NSArray *array2 = [array1.lastObject componentsSeparatedByString:@" "];
    NSString *yue = @"月";
    NSString *shi = @"时";
    NSString *ri = @"日";
    NSString *dateString = [NSString stringWithFormat:@"%@%@%@%@ %@%@",array1.firstObject,yue,array2.firstObject,ri,array2.lastObject,shi];
    //    NSLog(@"日器值为%@",dateString);
    return dateString;
}

@end
