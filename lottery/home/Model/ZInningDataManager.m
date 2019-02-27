//
//  ZInningDataManager.m
//  lottery
//
//  Created by zzz on 2018/7/2.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZInningDataManager.h"
#import <math.h>

@implementation ZInningDataManager
//num 输入的公式 Qnum开的数字 Bl为/后面的数字 tsbl为刚开始选择的0.8或0.7
+ (NSString *)computeWithNum:(NSString *)num Qnum:(NSString *)Qnum Bl:(NSString *)Bl tsbl:(NSString *)tsbl{
    NSString *resultStr = @"";
    double result = 0.0;
    //num.indexOf(Qnum)>=0
    if([num rangeOfString:Qnum].location != NSNotFound) {//从输入的数字里获取到对应值时
        //num.indexOf("1")>=0
        if([num rangeOfString:@"1"].location != NSNotFound) {//数字中出现1的时候拉低赔率
            //num.indexOf(".")>0
            if([num rangeOfString:@"."].location != NSNotFound && [num rangeOfString:@"."].location > 0) {//保數字
                //console.log("中签保数字(1)为:"+num);
                if(num.length==4) {//X.XX
                    //"1"==Qnum
                    if([@"1" isEqualToString:Qnum]) {
                        //num.indexOf("1")==0
                        if([num rangeOfString:@"1"].location != NSNotFound && [num rangeOfString:@"1"].location==0) {//X.为1时
                            //console.log("中签数字(1)为"+num+"是X.XX类型結果開:"+0.24*Bl);
//                            result="+"+Number(0.24*Bl).toFixed(3);
                            result += 0.24 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }else {//.XX中有1时
                            //console.log("中签数字(1)为"+num+"是X.XX类型結果開:"+0*Bl);
//                            result=""+Number(0*Bl).toFixed(3);
                            result += 0 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }
                    }else {
                        //num.indexOf(Qnum)==0
                        if([num rangeOfString:Qnum].location != NSNotFound && [num rangeOfString:Qnum].location==0) {//X.为Qnum时
                            //console.log("中签数字(1)为"+num+"是X.XX类型結果開:"+0.28*Bl);
//                            result="+"+Number(0.28*Bl).toFixed(3);
                            result += 0.28 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }else {//.XX中有Qnum时
                            //console.log("中签数字(1)为"+num+"是X.XX类型結果開:"+0*Bl);
//                            result=""+Number(0*Bl).toFixed(3);
                            result += 0 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }
                    }
                }else if(num.length==3) {// 1.X X.1
                    //num.indexOf("1")==0
                    if([num rangeOfString:@"1"].location != NSNotFound && [num rangeOfString:@"1"].location==0) {// 1.X
                        //"1"==Qnum
                        if([@"1" isEqualToString:Qnum]) {
                            //console.log("中签数字(1)为"+num+"是1.X类型結果開:"+0.32*Bl);
//                            result="+"+Number(0.32*Bl).toFixed(3);
                            result = 0.32 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }else {
                            //console.log("中签数字(1)为"+num+"是1.X类型結果開:"+0*Bl);
//                            result=""+Number(0*Bl).toFixed(3)
                            result += 0 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }
                    }else {// X.1
                        //"1"==Qnum
                        if([@"1" isEqualToString:Qnum]) {
                            //console.log("中签数字(1)为"+num+"是X.1类型結果開:"+0*Bl);
//                            result=""+Number(0*Bl).toFixed(3);
                            result += 0 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }else {
                            //console.log("中签数字(1)为"+num+"是X.1类型結果開:"+0.38*Bl);
//                            result="+"+Number(0.38*Bl).toFixed(3);
                            result = 0.38 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }
                    }
                }
                //num.indexOf("//")>0
            }else if([num rangeOfString:@"//"].location != NSNotFound && [num rangeOfString:@"//"].location > 0) {//轉数字
                //console.log("中签转数字(1)为:"+num);
                //(num.indexOf("1")==0
                if([num rangeOfString:@"1"].location != NSNotFound && [num rangeOfString:@"1"].location==0) {//1//X  1=2.4 X=1
                    //"1"==Qnum
                    if([@"1" isEqualToString:Qnum]) {
                        //console.log("中签数字(1)为"+num+"是1//X类型結果開:"+0.24*Bl);
//                        result="+"+Number(0.24*Bl).toFixed(3);
                        result = 0.24 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }else {
                        //console.log("中签数字(1)为"+num+"是1//X类型結果開:"+0.1*Bl);
//                        result="+"+Number(0.1*Bl).toFixed(3);
                        result = 0.1 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }
                }else {//X//1  1=1    X=2.6
                    //"1"==Qnum
                    if([@"1" isEqualToString:Qnum]) {
                        //console.log("中签数字(1)为"+num+"是X//1类型結果開:"+0.1*Bl);
//                        result="+"+Number(0.1*Bl).toFixed(3);
                        result = 0.1 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }else {
                        //console.log("中签数字(1)为"+num+"是X//1类型結果開:"+0.26*Bl);
//                        result="+"+Number(0.26*Bl).toFixed(3);
                        result = 0.26 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }
                }

            }else {//正常情况
                //console.log("中签正常数字(1)为:"+num);
                if(num.length==3) {//XXX  1=0.7 X=1
                    //"1"==Qnum
                    // Bl.substring(Bl.indexOf("."),Bl.length)==".5"
                    if([@"1" isEqualToString:Qnum]) {
                        NSString *stemp = @"";
                        if (Bl.length > 0 && [Bl rangeOfString:@"."].location != NSNotFound) {
                            stemp = [Bl substringWithRange:NSMakeRange([Bl rangeOfString:@"."].location, Bl.length - [Bl rangeOfString:@"."].location)] ;
                            if([stemp isEqualToString:@".5"]) {//    result="+"+Number(tsbl*Bl).toFixed(3);
                                //tsbl=="0.08"
                                if([tsbl isEqualToString:@"0.08"]){
                                    NSString *temp7 = [NSString stringWithFormat:@"%f",0.07 * [Bl doubleValue]];
                                    //Number(0.07*Bl).toString().length>5
                                    if(temp7.length>5){
                                        //                                    result="+"+Number(0.07*Bl).toFixed(2);
                                        result = 0.07 * [Bl doubleValue] + result;
                                        resultStr = [NSString stringWithFormat:@"%.2f",result];
                                    }else{
                                        //                              result="+"+Math.round(Number(0.07*Bl).toFixed(3) * 100) / 100;
                                        result = 0.07 * [Bl doubleValue] + result;
                                        result = round(result * 100.0f)/100.0f;
                                        resultStr = [NSString stringWithFormat:@"%.2f",result];
                                    }
                                }else{
                                    //                                result="+"+Number(0.07*Bl).toFixed(3);
                                    result = 0.07 * [Bl doubleValue] + result;
                                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                                }
                            }else {
                                //                            result="+"+Number(0.07*Bl).toFixed(3);
                                result = 0.07 * [Bl doubleValue] + result;
                                resultStr = [NSString stringWithFormat:@"%.3f",result];
                            }
                        }else{
                            result = 0.07 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }
                        //console.log("中签数字(1)为"+num+"是XXX 类型結果開:"+0.7*Bl);
                    }else {
                        //console.log("中签数字(1)为"+num+"是XXX 类型結果開:"+0.1*Bl);
//                        result="+"+Number(0.1*Bl).toFixed(3);
                        result = 0.1 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }
                }else if(num.length==2) {//XX 1=1.5 X=2
                    //"1"==Qnum
                    if([@"1" isEqualToString:Qnum]) {
                        NSString *stemp = @"";
                        if (Bl.length > 0 && [Bl rangeOfString:@"."].location != NSNotFound) {
                            stemp = [Bl substringWithRange:NSMakeRange([Bl rangeOfString:@"."].location, Bl.length - [Bl rangeOfString:@"."].location)];
                            //Bl.substring(Bl.indexOf("."),Bl.length)==".5"
                            if([stemp isEqualToString:@".5"]) {
                                //tsbl=="0.08"
                                if([tsbl isEqualToString:@"0.08"]){
                                    NSString *temp7 = [NSString stringWithFormat:@"%f",0.15 * [Bl doubleValue]];
                                    //Number(0.15*Bl).toString().length>5
                                    if(temp7.length>5){
                                        //                                    result="+"+Number((Math.round(Number(0.15*Bl) * 1000) / 1000)).toFixed(2);
                                        result = 0.15 * [Bl doubleValue] + result;
                                        result = round(result * 1000.0f)/1000.0f;
                                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                                    }else{
                                        //                                    result="+"+Math.round(Number(0.15*Bl) * 100) / 100;
                                        result = 0.15 * [Bl doubleValue] + result;
                                        result = round(result * 100.0f)/100.0f;
                                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                                    }
                                }else{
                                    //                                result="+"+Number(0.15*Bl).toFixed(3);
                                    result = 0.15 * [Bl doubleValue] + result;
                                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                                }
                            }else {
                                //                            result="+"+Number(0.15*Bl).toFixed(3);
                                result = 0.15 * [Bl doubleValue] + result;
                                resultStr = [NSString stringWithFormat:@"%.3f",result];
                            }
                        }else{
                            result = 0.15 * [Bl doubleValue] + result;
                            resultStr = [NSString stringWithFormat:@"%.3f",result];
                        }
                        
                        
                        //console.log("中签数字(1)为"+num+"是XX类型結果開:"+0.15*Bl);
                    }else {
                        //console.log("中签数字(1)为"+num+"是XX类型結果開:"+0.2*Bl);
//                        result="+"+Number(0.2*Bl).toFixed(3);
                        result = 0.2 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }
                    //num.length==1
                }else if(num.length==1) {//X  1=4 X5
                    //console.log("中签数字(1)为"+num+"是X类型結果開:"+0.4*Bl);
//                    result="+"+Number(0.4*Bl).toFixed(3);
                    result = 0.4 * [Bl doubleValue] + result;
                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                }
            }
        }else {//数字中没有出现1的时候
            //num.indexOf(".")>0
            if([num rangeOfString:@"."].location != NSNotFound && [num rangeOfString:@"."].location > 0) {//保數字
                //console.log("中签保数字为:"+num);
                //(num.length==4
                if(num.length==4) {//X.XX
                    //num.indexOf(Qnum)==0
                    if([num rangeOfString:Qnum].location != NSNotFound && [num rangeOfString:Qnum].location==0) {//X.为Qnum时
                        //console.log("中签数字为"+num+"是X.XX类型結果開:"+0.3*Bl);
//                        result="+"+Number(0.3*Bl).toFixed(3);
                        result = 0.3 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }else {//.XX中有Qnum时
//                        console.log("中签数字为"+num+"是X.XX类型結果開:"+0*Bl);
//                        result=""+Number(0*Bl).toFixed(3);
                        result = 0 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }
                    //num.length==3
                }else if(num.length==3) {//X.X
                    //num.indexOf(Qnum)==0
                    if([num rangeOfString:Qnum].location != NSNotFound && [num rangeOfString:Qnum].location==0) {//X.为Qnum时
                        //console.log("中签数字为"+num+"是X.X类型結果開:"+0.4*Bl);
//                        result="+"+Number(0.4*Bl).toFixed(3);
                        result = 0.4 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }else {//.X中有Qnum时
                        //console.log("中签数字为"+num+"是X.X类型結果開:"+0*Bl);
//                        result=""+Number(0*Bl).toFixed(3);
                        result = 0 * [Bl doubleValue] + result;
                        resultStr = [NSString stringWithFormat:@"%.3f",result];
                    }
                }
                //num.indexOf("//")>0
            }else if([num rangeOfString:@"//"].location != NSNotFound && [num rangeOfString:@"//"].location > 0) {//轉数字
                //console.log("中签轉数字为:"+num);
                //num.indexOf(Qnum)==0
                if([num rangeOfString:Qnum].location != NSNotFound && [num rangeOfString:Qnum].location==0) {//X//X
                    //console.log("中签数字为"+num+"是X//X类型結果開:"+0.3*Bl);
//                    result="+"+Number(0.3*Bl).toFixed(3);
                    result = 0.3 * [Bl doubleValue] + result;
                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                }else {
                    //console.log("中签数字为"+num+"是X//X类型結果開:"+0.1*Bl);
//                    result="+"+Number(0.1*Bl).toFixed(3);
                    result = 0.1 * [Bl doubleValue] + result;
                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                }
            }else {//正常情况
                //console.log("中签正常数字为:"+num);
                if(num.length==3) {//type1   1=0.7 X=1
                    //console.log("中签数字为"+num+"是XXX类型結果開:"+0.1*Bl);
//                    result="+"+Number(0.1*Bl).toFixed(3);
                    result = 0.1 * [Bl doubleValue] + result;
                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                }else if(num.length==2) {//type2  1=1.5 X=2
                    //console.log("中签数字为"+num+"是XX类型結果開:"+0.2*Bl);
//                    result="+"+Number(0.2*Bl).toFixed(3);
                    result = 0.2 * [Bl doubleValue] + result;
                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                }else if(num.length==1) {//type3  1=4 X5
                    //console.log("中签数字为"+num+"是X类型結果開:"+0.5*Bl);
//                    result="+"+Number(0.5*Bl).toFixed(3);
                    result = 0.5 * [Bl doubleValue] + result;
                    resultStr = [NSString stringWithFormat:@"%.3f",result];
                }
            }
        }
    }else {
        //console.log("没有中签赔率："+(Bl*-0.1));
//        result=Number(Bl*-0.1).toFixed(3);
        result = -0.1 * [Bl doubleValue] + result;
        resultStr = [NSString stringWithFormat:@"%.3f",result];
    }
    return resultStr;
}

+(BOOL)checkX:(NSString *)checknum {
    NSInteger count = 0;
    for (NSInteger i = 0; i < checknum.length; i++) {
        NSRange subRange= NSMakeRange(i,1);
        NSString *g = [checknum substringWithRange:subRange];
        if ([g isEqualToString:@"/"]) {
            count++;
        }
    }
    if(count==2) {
        return true;
    }
    return false;
}

//num 输入的公式 Qnum开的数字 Bl为/后面的数字 tsbl为刚开始选择的0.8或0.7
+(void)computeWithInningModel:(ZInningModel *)model {
    double amount = 0.0;
    double subAmount = 0.0;
    double addAmount = 0.0;
    double input = 0.0;
    
    for (ZInningListModel *listModel in model.inninglist) {
        double allInputResult = 0.0;
        for (NSInteger i = 0; i < listModel.listInput.count; i++) {
            NSString *qmSinge = listModel.listInput[i];
            if (qmSinge.length > 0) {
                if( [ZInningDataManager checkX:qmSinge]){
                    //console.log(checkX(num));
                    NSArray *tempArr = [qmSinge componentsSeparatedByString:@"/"];
                    NSString *num1 = @"";
                    NSString *num2 = @"";
                    NSString *Bl1 =  @"";
                    NSString *Bl2 =  @"";
                    
                    if (tempArr.count > 0) {
                        num1 = tempArr[0];
                        num2 = [num1 stringByReplacingOccurrencesOfString:@"." withString:@""];
                    }
                    
                    if (tempArr.count > 1) {
                        Bl1 = tempArr[1];
                    }
                    
                    if (tempArr.count > 2) {
                        Bl2 = tempArr[2];
                    }
                    
                    NSString *result = @"";
                    
                    result = [ZInningDataManager computeWithNum:num1 Qnum:model.winNum Bl:Bl1 tsbl:model.multiplyingTure];
                    
                    NSString *result2 =[ZInningDataManager computeWithNum:num2 Qnum:model.winNum Bl:Bl2 tsbl:model.multiplyingTure];
                    
                    
                    input += [Bl1 doubleValue] + [Bl2 doubleValue];
                    result = [NSString stringWithFormat:@"%.3f",[result doubleValue] + [result2 doubleValue]];
                    listModel.listInputResult[i] = result;
                    
                    allInputResult += [listModel.listInputResult[i] doubleValue];
                }else{
                    NSArray *tempArr = [qmSinge componentsSeparatedByString:@"/"];
                    NSString *num1 = @"";
                    NSString *Bl1 =  @"";
                    if ([qmSinge rangeOfString:@"/"].location == NSNotFound) {
                        num1 = qmSinge;
                        Bl1 = qmSinge;
                    }else{
                        tempArr = [ZInningDataManager rangeOfSubString:@"/" inString:qmSinge];
                        if (tempArr.count > 0) {
                            NSValue *tempRangeValue = tempArr[tempArr.count - 1];
                            NSRange tempRange = [tempRangeValue rangeValue];
                            num1 = [qmSinge substringWithRange:NSMakeRange(0, tempRange.location)];
                            Bl1 = [qmSinge substringWithRange:NSMakeRange(tempRange.location+1, qmSinge.length-tempRange.location-1)] ;
                        }else{
                            num1 = qmSinge;
                            Bl1 = qmSinge;
                        }
                        
                    }
                   
                    
                    NSString *result = [ZInningDataManager computeWithNum:num1 Qnum:model.winNum Bl:Bl1 tsbl:model.multiplyingTure];
                    input += [Bl1 doubleValue];
                    listModel.listInputResult[i] = result;
                    
                    allInputResult += [listModel.listInputResult[i] doubleValue];
                }
            }
        
            if (listModel.listInput[0].length > 0) {
                listModel.listThisResult = [NSString stringWithFormat:@"%.3f",allInputResult];
                listModel.listAllResult = [NSString stringWithFormat:@"%.3f", [listModel.listThisResult doubleValue] + [listModel.listLastResult doubleValue]];
            }
        }
        if (listModel.listInput && listModel.listInput.count > 0 && listModel.listInput[0].length > 0) {
            double tempAmount = round([listModel.listThisResult doubleValue] * 1000) / 1000.0f;
            amount += tempAmount;
            if (tempAmount >= -0.00001) {
                addAmount += tempAmount;
            }else{
                subAmount += tempAmount;
            }
        }
    }
    model.subAmount = [[ZPublicManager shareInstance] changeFloat:[NSString stringWithFormat:@"%.3f",subAmount]] ;
    model.addAmount = [[ZPublicManager shareInstance] changeFloat:[NSString stringWithFormat:@"%.3f",addAmount]];
    model.amount = [[ZPublicManager shareInstance] changeFloat:[NSString stringWithFormat:@"%.3f",amount]];
    model.allAmount = [[ZPublicManager shareInstance] changeFloat:[NSString stringWithFormat:@"%.3f",amount + [model.lastAmount doubleValue]]];
    
    model.inputAmout = [NSString stringWithFormat:@"%.3f",input/10.0f];
}

+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString*string1 = [string stringByAppendingString:subStr];
    NSString *temp;

    for(int i =0; i < string.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject: [NSValue valueWithRange:range]];
        }
    }

    return rangeArray;
    
}
@end
