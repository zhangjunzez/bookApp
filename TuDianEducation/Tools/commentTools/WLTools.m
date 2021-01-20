//
//  WLTools.m
//  WeiLv
//
//  Created by James on 16/2/16.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "WLTools.h"
#import <sys/sockio.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <CoreLocation/CoreLocation.h>
#import "WL_KeyChainStore.h"


#define  KEY_USERNAME_PASSWORD @"com.ZSD.SSNW.usernamepassword"
#define  KEY_USERNAME @"com.ZSD.SSNW.username"
#define  KEY_PASSWORD @"com.ZSD.SSNW.password"

@implementation WLTools

+(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i  = 0; i <CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
        
    }
    return output;
}
#pragma mark - 加密实现MD5和SHA1
//+(NSString *) md5:(NSString *)str
//{
//
//    return Encrypt(str);
//
////    str = [str stringByAppendingString:@"c077292f-2dc5-493e-a965-00659318c889"];
////
////
////    const char *cStr = [str UTF8String];
////    unsigned char digest[CC_MD5_DIGEST_LENGTH];
////
////#pragma clang diagnostic push
////#pragma clang diagnostic ignored "-Wshorten-64-to-32"
////
////    CC_MD5( cStr, strlen(cStr), digest );
////#pragma clang diagnostic pop
////
////    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
////
////    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
////        [output appendFormat:@"%02X", digest[i]];
////
////    //return output;
////    return  [output lowercaseString];
////}
/////* sha1 encode */
////+(NSString*) sha1:(NSString *)str
////{
////    // const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
////    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
////    //[NSData dataWithBytes:str length:str.length];
////
////    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
////
////#pragma clang diagnostic push
////#pragma clang diagnostic ignored "-Wshorten-64-to-32"
////
////    CC_SHA1(data.bytes, data.length, digest);
////#pragma clang diagnostic pop
////
////    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
////
////    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
////        [output appendFormat:@"%02x", digest[i]];
////
////    return output;
////}
////
////#pragma mark - 实现http GET/POST 解析返回的json数据
////+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data
////{
////    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
////    //设置提交方式
////    [request setHTTPMethod:method];
////    //设置数据类型
////    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
////    //设置编码
////    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
////    //如果是POST
////    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
////
////    NSError *error;
////
////#pragma clang diagnostic push
////#pragma clang diagnostic ignored "-Wdeprecated-declarations"
////    //将请求的url数据放到NSData对象中
////    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
////#pragma clang diagnostic pop
////
////    return response;
//}
//



#pragma mark - 颜色十六进制转换成UIColor
/**
 *   颜色十六进制转换成UIColor
 *
 *  @param str 十六进制颜色值
 *
 *  @return 返回UIColor
 */
+(UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""])
    {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

#pragma mark - 颜色十六进制转换成UIColor
/**
 *   颜色十六进制转换成UIColor
 *
 *  @param str 十六进制颜色值
 *
 *  @return 返回UIColor
 */
+(UIColor *) stringToColor:(NSString *)str andAlpha:(CGFloat)value
{
    if (!str || [str isEqualToString:@""])
    {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:value];
    return color;
}



#pragma mark - 把格式化的JSON格式的字符串转换成字典
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @param jsonString 字符串
 *
 *  @return jsonString JSON格式的字符串
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //SSLog(Localized(@"json解析失败：%@", nil),err);
        return nil;
    }
    return dic;
}
#pragma mark - 把字典转换成JSON格式

+ (NSString*)wlDictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark - 把数组转换成JSON格式
+ (NSString*)wlArrayToJson:(NSArray *)arr {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - 创建label
+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    return label;
}

#pragma mark - 创建button

+ (UIButton *)allocButtonTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor image:(UIImage *)image frame:(CGRect)frame sel:(SEL)sel taget:(id)taget;{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:(UIControlStateNormal)];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn addTarget:taget action:sel forControlEvents:(UIControlEventTouchUpInside)];
    btn.titleLabel.font = font;
    return btn;
};
#pragma mark -创建textField
+(UITextField *)allocTextFieldTextFont:(CGFloat)textFont placeHolderFont:(CGFloat)placeHolderFont text:(NSString *)text placeText:(NSString *)placeText textColor:(UIColor *)textColor placeHolderTextColor:(UIColor *)placeHolderTextColor frame:(CGRect)frame {
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
      textField.text = text;
        textField.placeholder = placeText;
    //    [textField setValue:placeHolderTextColor forKeyPath:@"_placeholderLabel.textColor"];
    //    [textField setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeText attributes:@{NSForegroundColorAttributeName:placeHolderTextColor,NSFontAttributeName:[UIFont systemFontOfSize:placeHolderFont]}];
        textField.font = [UIFont systemFontOfSize:textFont];
        textField.textColor = textColor;
    return textField;
}
#pragma mark - 创建imageview
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    return imageView;
}

#pragma mark - 计算小数点有几位
+ (NSString*)decimalPrecisionWithString:(NSString*)_str {
    NSRange range = [_str rangeOfString:@"."];
    if (range.length == 0 || range.location == 0) {//没有小数点的str
        return @"0";
    }
    NSInteger lastOfStringLocation = range.location+1;
    NSInteger subLength = _str.length - lastOfStringLocation;
    return [NSString stringWithFormat:@"%ld",(long)subLength];
}
#pragma mark--返回不带小数点的字符串
+ (NSString *)returnIntStrFrom:(NSString *)str
{
    
    NSString *resulutStr;
    if ([str rangeOfString:@"."].location!=NSNotFound) {
        NSInteger index =[str rangeOfString:@"."].location;
        //SSLog(@"%ld",(long)index);
        resulutStr=[str substringToIndex:index];
        
    }else{
        return str;
    }
    return resulutStr;
}

#pragma mark--返回两位小数点的字符串
+ (NSString *)return02lfStrFrom:(NSString *)str
{
    
    NSString *resulutStr=@"0.00";
    
    if ([WLTools judgeString:str]) {
        
        if ([str rangeOfString:@"."].location!=NSNotFound) {
            
            NSInteger index =[str rangeOfString:@"."].location;
            
            NSString *s=[str substringFromIndex:index+1];
            if (s.length>=2){
                
                resulutStr=[str substringToIndex:index+3];
                
            }else{
                
                return [NSString stringWithFormat:@"%@0",str];
                
            }
        }else{
            return [NSString stringWithFormat:@"%@.00",str];
        }
        
        
    }else{
        return @"0.00";
    }
    
    return resulutStr;
}

#pragma mark--转换时间戳
/**
 * @param seconds  double类型的时间戳
 * @param format   格式，例如: yyyy年MM月dd日或yyyy-M-dd
 */
+ (NSString *)convertTimestamp:(double)seconds andFormat:(NSString *)format {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:format];
    
    NSString *currentDateStr = [formatter stringFromDate:date];
    
    return currentDateStr;
}

/**
 *  判断字符串是否为空
 *
 *  @param returnStr 字符串
 *
 *  @return 结果值
 */
+ (BOOL)judgeString:(NSString *)returnStr {
    
    if (returnStr) {
        returnStr = [NSString stringWithFormat:@"%@", returnStr];
    }
    if ([returnStr isEqual:[NSNull null]] || returnStr.length == 0 || returnStr == nil || [returnStr isEqualToString:@""] ||[returnStr isEqualToString:@" "]|| !returnStr || [returnStr isEqualToString: @"<null>"]||[returnStr isEqualToString: @"(null)"]||[returnStr isEqualToString: @"null"]) {
        return NO;
    }
    return YES;
}

//判断字符串是否可用(可能是整型)
+ (NSString*)stringTransformObject:(id)object {
    NSString *str = @"";
    if ([object isKindOfClass:[NSNumber class]]) {
        str = [object stringValue];
    } else if([object isKindOfClass:[NSNull class]]){
        str = @"";
    } else {
        str = (NSString*)object;
    }
    return str;
}

#pragma mark--过滤字符串中的空格
+(NSString *)FliterWhiteSpace:(NSString *)str
{
    str= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

#pragma mark--过滤字符串中的html标签
+ (NSString *)filterHTML:(NSString *)html {
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    
    NSString * text = nil;
    
    while([scanner isAtEnd] == NO){
        
        [scanner scanUpToString:@"<" intoString:nil];
        
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

#pragma mark - 过滤HTML（包含换行空格等特殊符号）
+ (NSString *)flattenHTML:(NSString *)html
{
    
    //  过滤html标签
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    NSMutableString *str1 = [NSMutableString stringWithString:html];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        
        //  在这里添加要过滤的特殊符号
        if ( c == '\r' || c == '\n' || c == '\t' ) {
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    html  = [NSString stringWithString:str1];
    return html;
}




#pragma mark--删除webView 的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView
{
    for(id subview in webView.subviews)
    {
        if ([[subview  class] isSubclassOfClass: [UIScrollView  class]])
            
        {
            ((UIScrollView *)subview).bounces = NO;
            
            [(UIScrollView *)subview setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)subview setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
        }
        
        webView.scrollView.bounces=NO;
    }
    
}

#pragma mark--验证MD5字符串
+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString
{
    return [signString isEqualToString:[self md5:string]];
}

#pragma mark--获取当前时间戳
+(NSString *)getOrderTrSeq
{
    NSDate *senddate=[NSDate date];
    NSString *locationString = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    return locationString;
}

#pragma mark--获取当前时间毫秒级
+(NSString *)getOrderTimeMS
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSS"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

#pragma mark--获取当前时间分钟级
+(NSString *)getOrderTime
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

#pragma mark-- 获取iPhone客户端UUID
+(NSString*)getIPhoneUUID
{
    NSString * strUUID = (NSString *)[WL_KeyChainStore load:@"com.ZSD.SSNW.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [WL_KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
    
}

#pragma mark--获取iPhone客户端MAC地址
+(NSString *)getIPhoneMacAddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

#pragma mark--过滤特殊字符
+ (NSString *)filterSpecialString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@/：；（）¥「」＂、[]{}#%-*+=_\\|~<>$€^•'@#$%^&*()_+'\""];
    NSString *body=@"";
    for (int i=0; i<string.length; i++) {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange userNameRange = [s rangeOfCharacterFromSet:set];
        if (userNameRange.location != NSNotFound)
        {
            s = @"";
        }
        body = [body stringByAppendingString:s];
    }
    return body;
}

#pragma mark - 获取字符串的宽度
+(CGFloat)getStringWidth:(NSString *)str fontSize:(float)size
{
    NSDictionary *attributes = @{NSFontAttributeName: systemFont(size)};
    
    CGFloat titleWidth = [str boundingRectWithSize:CGSizeMake(ScreenWidth,size) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    return titleWidth;
}

#pragma mark - 获取字符串的高度
+(CGFloat)getStringHeight:(NSString *)str fontSize:(float)size
{
    NSDictionary *attributes = @{NSFontAttributeName: systemFont(size)};
    
    CGFloat titleHeight = [str boundingRectWithSize:CGSizeMake(ScreenWidth,size) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return titleHeight;
    
}

#pragma mark - 手机号码格式化
+(NSString *)phoneNumberFormat:(NSString *)phone
{
    NSString *strPhone=phone;
    
    if (phone.length==11)
    {
        NSString *oneStr=[strPhone substringWithRange:NSMakeRange(0, 3)];
        NSString *twoStr=[strPhone substringWithRange:NSMakeRange(3, 4)];
        NSString *thirdStr=[strPhone substringWithRange:NSMakeRange(7, 4)];
        
        strPhone=[NSString stringWithFormat:@"%@-%@-%@",oneStr,twoStr,thirdStr];
        return strPhone;
    }
    return strPhone;
}

#pragma mark - 字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if (dict && entity)
    {
        
        for (NSString *keyName in [dict allKeys])
        {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector])
            {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [entity performSelector:destMethodSelector withObject:[dict objectForKey:keyName]];
                
#pragma clang diagnostic pop
            }
            
        }
        
    }
}

#pragma mark - 实体对象转为字典对象
//+ (NSDictionary *) entityToDictionary:(id)entity
//{
//    Class clazz = [entity class];
//    u_int count;
//    
//    objc_property_t* properties = class_copyPropertyList(clazz, &count);
//    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
//    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
//    
//    for (int i = 0; i < count ; i++)
//    {
//        objc_property_t prop=properties[i];
//        const char* propertyName = property_getName(prop);
//        
//        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
//#pragma clang diagnostic pop
//        if(value ==nil)
//            [valueArray addObject:[NSNull null]];
//        else {
//            [valueArray addObject:value];
//        }
//    }
//    
//    free(properties);
//    
//    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
//    //SSLog(@"%@", returnDic);
//    
//    return returnDic;
//}


#pragma mark - 判断是否为整形
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark - 根据身份证号，获取生日 - 18位
+(NSString *)birthdayStrFromIdentityCard_18:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
    {
        return result;
    }
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0')
    {
        if(!(*p>='0'&&*p<='9'))
        {
            isAllNumber = NO;
        }
        p++;
    }
    if(!isAllNumber)
    {
        return result;
    }
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

#pragma mark - 根据身份证号，获取生日 - 15位
+(NSString *)birthdayStrFromIdentityCard_15:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    
    NSString *day = nil;
    if([numberStr length]<14)
    {
        return result;
    }
    
    //**截取前12位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];
    
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0')
    {
        if(!(*p>='0'&&*p<='9'))
        {
            isAllNumber = NO;
        }
        p++;
    }
    if(!isAllNumber)
    {
        return result;
    }
    
    
    year = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(6, 2)]];
    month = [numberStr substringWithRange:NSMakeRange(8, 2)];
    day = [numberStr substringWithRange:NSMakeRange(10,2)];
    
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
    
}


#pragma mark - 根据身份证号，获取性别 - 18 位
+(NSString *)getIdentityCardSex_18:(NSString *)numberStr
{
    int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    
    if(sexInt%2!=0)
    {
        return @"1";
    }
    else
    {
        return @"2";
    }
}

#pragma mark - 根据身份证号，获取性别 - 15 位
+(NSString *)getIdentityCardSex_15:(NSString *)numberStr
{
    int sexInt=[[numberStr substringWithRange:NSMakeRange(14,1)] intValue];
    
    if(sexInt%2!=0)
    {
        return @"1";
    }
    else
    {
        return @"2";
    }
}

+ (NSString *)WL_FomateJsonWithDictionary:(NSDictionary *)dic {
    
    NSArray *keys = [dic allKeys];
    
    NSString *string = [NSString string];
    
    
    
    for (NSString *key in keys) {
        
        NSString *value = [dic objectForKey:key];
        
        
        
        value = [NSString stringWithFormat:@"\"%@\"",value];
        
        NSString *newkey = [NSString stringWithFormat:@"\"%@\"",key];
        
        
        
        
        
        if (!string.length) {
            
            string = [NSString stringWithFormat:@"%@:%@}",newkey,value];
            
        }else {
            
            string = [NSString stringWithFormat:@"%@:%@,%@",newkey,value,string];
            
        }
        
    }
    
    string = [NSString stringWithFormat:@"{%@",string];
    
    return string;
    
}

#pragma mark - 图片等比率缩放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma mark - 自定长宽
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}


#pragma mark - 字符串反转 方法一
+ (NSString *)reverseWordsInString1:(NSString *)str
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (NSInteger i = str.length - 1; i >= 0 ; i --)
    {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    return newString;
}

#pragma mark - 字符串反转 方法二
+ (NSString*)reverseWordsInString2:(NSString*)str
{
    NSMutableString *reverString = [NSMutableString stringWithCapacity:str.length];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverString appendString:substring];
    }];
    return reverString;
}

#pragma mark - 获取汉字的拼音
+ (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //SSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //SSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

#pragma mark - 阿拉伯数字转中文格式
+(NSString *)translation:(NSString *)arebic
{
   /* NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[Localized(@"一", nil),Localized(@"二", nil),Localized(@"三", nil),Localized(@"四", nil),Localized(@"五", nil),Localized(@"六", nil),Localized(@"七", nil),Localized(@"八", nil),Localized(@"九", nil),Localized(@"零", nil)];
    NSArray *digits = @[Localized(@"个", nil),Localized(@"十", nil),Localized(@"百", nil),Localized(@"千", nil),Localized(@"万", nil),Localized(@"十", nil),Localized(@"百", nil),Localized(@"千", nil),Localized(@"亿", nil),Localized(@"十", nil),Localized(@"百", nil),Localized(@"千", nil),Localized(@"兆", nil)];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    //SSLog(@"%@",str);
    //SSLog(@"%@",chinese);
    return chinese;*/
    return @"";
}

#pragma mark - 计算文件大小
+ (long long)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path])
    {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    
    return 0;
}

#pragma mark - 计算文件夹大小
+ (long long)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    long long folderSize = 0;
    
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            if ([fileManager fileExistsAtPath:fileAbsolutePath])
            {
                long long size = [fileManager attributesOfItemAtPath:fileAbsolutePath error:nil].fileSize;
                folderSize += size;
            }
        }
    }
    
    return folderSize;
}

#pragma mark - 计算字符串字符长度，一个汉字算两个字符 方法一
+ (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
        
    }
    return strlength;
}

#pragma mark - 计算字符串字符长度，一个汉字算两个字符 方法二
+(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

#pragma mark - 字符串中是否含有中文
+ (BOOL)checkIsChinese:(NSString *)string
{
    for (int i=0; i<string.length; i++)
    {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 过滤表情
+ (NSString *)filterEmoji:(NSString *)string
{
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [string UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}

#pragma mark - 是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;\
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark - 获取date的下个月日期
+(NSDate *)nextMonthDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
    return nextMonthDate;
    
}

#pragma mark - 获取date的下下个月日期
+(NSDate *)nextnextMonthDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 2;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

#pragma mark - 获取date日期对应的天
+(NSInteger)getDay:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger day = [comps day];
    
    return day;
}

#pragma mark - 获取date日期对应的月
+(NSInteger)getMonth:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger month = [comps month];
    
    return month;
    
}

#pragma mark - 获取date日期对应的年
+(NSInteger)getYear:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [comps year];
    
    return year;
}

#pragma mark - 颜色变成UIImage
+(UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - 传入 秒 得到 时分秒
+(NSString *)getHHMMSSFromSS:(NSString *)totalTime
{
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}

#pragma mark - 传入 秒 得到 分秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime
{
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    //SSLog(@"format_time : %@",format_time);
    
    return format_time;
}

#pragma mark - 提取字符串中的汉字
+ (NSArray *)getAStringOfChineseWord:(NSString *)string
{
    if (string == nil || [string isEqual:@""])
    {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i<[string length]; i++)
    {
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00)
        {
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return arr;
    
}

#pragma mark - 生成guid字符串
+ (NSString*) stringWithGUID
{
    CFUUIDRef guidObj = CFUUIDCreate(nil);
    
    NSString *guidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil,guidObj));
    
    return guidString;
}

#pragma mark - 浮点数格式化
+(NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) //如果有一位小数点
    {
        return [NSString stringWithFormat:@"%.0f",f];
    }
    else if (fmodf(f*10, 1)==0) //如果有两位小数点
    {
        return [NSString stringWithFormat:@"%.1f",f];
    }
    else
    {
        return [NSString stringWithFormat:@"%.2f",f];
    }
    
}


#pragma mark - 获取未来某个日期是星期几
+(NSString *)featureWeekdayWithDate:(NSString *)featureDate
{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:endDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    switch (week) {
        case 1:
            return SSKJLocalized(@"星期天", nil);
            break;
        case 2:
            return SSKJLocalized(@"星期一", nil);
            break;
        case 3:
            return SSKJLocalized(@"星期二", nil);
            break;
        case 4:
            return SSKJLocalized(@"星期三", nil);
            break;
        case 5:
            return SSKJLocalized(@"星期四", nil);
            break;
        case 6:
            return SSKJLocalized(@"星期五", nil);
            break;
        case 7:
            return SSKJLocalized(@"星期六", nil);
            break;
            
        default:
            break;
    }
    return @"";
}

#pragma mark - 计算2个日期相差天数
+(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0)
    {
        //SSLog(Localized(@"0天0小时0分钟", nil));
        return 0;
    }
    else
    {
        //SSLog(@"%@",[[NSString alloc] initWithFormat:Localized(@"%i天%i小时%i分钟", nil),days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days + 1;
    }
}

+(NSInteger)secondFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}


+ (NSString *)getDetailedDateWithTimeInterval:(long long)interval{
    
    if (!interval) {
        return @"";
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    if (date.isThisYear) {
//        [formatter setDateFormat:@"MM-dd HH:mm:ss"];
//    }else{
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    }
    
    NSString *time = [formatter stringFromDate:date];
    return time;
}



#pragma mark -  获取当前是星期几
+ (NSInteger)getNowWeekday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}



#pragma mark - （最多）保留小数位，不四舍五入，不保留无效0
+(NSString *)noroundingStringWith:(double)price afterPointNumber:(NSInteger)point;
{
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",point + 3];

    NSString *string =  [NSString stringWithFormat:format,price];
    
    if ([string containsString:@"."]) {
        NSArray *array = [string componentsSeparatedByString:@"."];
        NSString *pointString ;
        if ([array.lastObject length] > point) {
            pointString = [array.lastObject substringToIndex:point];
        }else{
            pointString = array.lastObject;
        }
        string = [NSString stringWithFormat:@"%@.%@",array.firstObject,pointString];
    }
    
    
    
    NSString *format1 = [NSString stringWithFormat:@"%%.%ldf",point];
    NSString *string1 =  [NSString stringWithFormat:format1,string.doubleValue];
    
    if ([string1 hasSuffix:@"."]) {
        string1 = [string1 substringToIndex:string1.length - 1];
    }
    string1 =  [self deleteLastZeroWithString:string1] ;
    
    if ([string1 hasSuffix:@"."]) {
        string1 = [string1 substringToIndex:string1.length - 1];
    }
    
    return string1;
}


#pragma mark - （最多）保留小数位，不四舍五入，保留无效0
+(NSString *)roundingStringWith:(double)price afterPointNumber:(NSInteger)point
{
    NSString *string =  [NSString stringWithFormat:@"%.10f",price];
    
    if ([string containsString:@"."]) {
        NSArray *array = [string componentsSeparatedByString:@"."];
        NSString *pointString ;
        if ([array.lastObject length] > point) {
           pointString = [array.lastObject substringToIndex:point];
        }else{
            pointString = array.lastObject;
        }
        string = [NSString stringWithFormat:@"%@.%@",array.firstObject,pointString];
    }
    
    
    
    NSString *format1 = [NSString stringWithFormat:@"%%.%ldf",point];
    NSString *string1 =  [NSString stringWithFormat:format1,string.doubleValue];
    if ([string1 hasSuffix:@"."]) {
        string1 = [string1 substringToIndex:string1.length - 1];
    }
    return string1;
    
    
    
    
}

// 删除无效0
+(NSString *)deleteLastZeroWithString:(NSString *)string
{
    if ([string hasSuffix:@"0"]) {
        return [WLTools deleteLastZeroWithString:[string substringToIndex:string.length - 1]];
    }else{
        return string;
    }
}

#pragma mark - 把字符串替换成星号
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght
{
    NSString *newStr = originalStr;
    
    for (int i = 0; i < lenght; i++)
    {
        
        NSRange range = NSMakeRange(startLocation, 1);
        
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        
        startLocation ++;
        
    }
    
    return newStr;
}

#pragma mark - 判断用户输入的密码是否符合规范，符合规范的密码要求
+(BOOL)judgePassWordLegal:(NSString *)pass min:(NSInteger)min max:(NSInteger)max
{
    BOOL result = false;
    if ([pass length] >= min)
    {
        // 判断长度大于min位后再接着判断是否同时包含数字和字符
        NSString * regex = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%ld,%ld}$",min,max];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}


#pragma mark - 姓名改为 姓**
+ (NSString *)name:(NSString *)nameStr
{
    NSString *first = [nameStr substringToIndex:1];//字符串开始
    return [NSString stringWithFormat:@"%@**",first];
}


// 设置uitextfield的placeholder颜色
+(void)textField:(UITextField *)textField setPlaceHolder:(NSString *)placeHolder color:(UIColor *)color
{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0, placeHolder.length)];
    
    textField.attributedPlaceholder = placeholderString;
}

// 计算字符串宽度
+(CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(ScreenWidth, font.pointSize) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}


// 如果图片地址没带域名，添加域名
+ (NSString*)imageURLWithURL:(NSString *)imageURL
{
    if (![imageURL containsString:@"http"]) {
        if ([imageURL hasPrefix:@"/"]) {
            return [NSString stringWithFormat:@"%@%@",ImageBaseServer,imageURL];
        }else{
            return [NSString stringWithFormat:@"%@/%@",ImageBaseServer,imageURL];
        }
    }
    return imageURL;
}



// 把时间转换成天、时、分、秒格式
+(NSString *)countDownTimeWithTime:(long)time
{
    int second = (int)(time % 60);
    int minute = (int)(time / 60 % 60);
    int houre = (int)(time / 3600 % 24);
    int day = (int)(time / 3600 / 24);
    NSString *timeString;
    if (day == 0) {
        if (houre == 0) {
            timeString = [NSString stringWithFormat:@"%02d%@%02d%@",minute,SSKJLocalized(@"分", nil),second,SSKJLocalized(@"秒", nil)];
        }else{
            timeString = [NSString stringWithFormat:@"%d%@%02d%@%02d%@",houre,SSKJLocalized(@"时", nil),minute,SSKJLocalized(@"分", nil),second,SSKJLocalized(@"秒", nil)];
        }
    }else{
        timeString = [NSString stringWithFormat:@"%d%@%d%@%02d%@%02d%@",day,SSKJLocalized(@"天", nil),houre,SSKJLocalized(@"时", nil),minute,SSKJLocalized(@"分", nil),second,SSKJLocalized(@"秒", nil)];
    }
    
    return timeString;
    
}
///换算时间戳
+(NSString *)getdateStringFromTimetal:(NSTimeInterval)timeInterval dateFomate:(NSString *)dataFormate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:dataFormate];
    return [fomatter stringFromDate:date];
};
// 交易对保留小数位
+(NSInteger)dotNumberOfCoinCode:(NSString *)coinName
{
//    if ([coinName isEqualToString:@"BTC/USDT"] || [coinName isEqualToString:@"ETH/USDT"]) {
//        return 4;
//    }
    
    if ([coinName hasSuffix:@"/USDT"]) {
        return 6;
    }
    return 8;
}

// 买入量保留小数位
+(NSInteger)dotNumberOfCoinName:(NSString *)coinName
{
//    if ([coinName isEqualToString:@"BTC"] || [coinName isEqualToString:@"ETH"] || [coinName isEqualToString:@"USDT"]){
//        return 4;
//    }else{
//        return 8;
//    }
    
//    if ([coinName isEqualToString:@"USDT"]){
//        return 6;
//    }else{
//        return 8;
//    }
    return 3;
}

// 资产币种保留小数位
+(NSInteger)dotNumberOfAssetCoinName:(NSString *)coinName
{
//    if ([coinName isEqualToString:@"BTC"] || [coinName isEqualToString:@"ETH"] || [coinName isEqualToString:@"USDT"]){
//        return 4;
//    }else{
        return 8;
//    }
}


+(NSInteger)dotNumberOfBBCoin:(NSString *)coinName{
    
    if ([coinName.uppercaseString hasSuffix:@"/BTC"]) {
        return 2;
    }
    return 4;
}




+(NSString *)hidePhoneMiddleNumberWithMobile:(NSString *)mobile
{
    if (mobile.length == 0)
    {
        return @"";
    }
    else if (mobile.length <= 7)
    {
        return mobile;
    }
   else
   {
        return [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
}


+ (UIViewController *)getCurrentViewController
{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController* currentViewController = window.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}


//加载服务端html
+ (NSMutableAttributedString *)loadHtmlTOLabelHtmlStr:(NSString *)htmlStr {
    //返回的HTML文本
    htmlStr =  [self htmlEntityDecode:htmlStr];
    
    //富文本，两种都可以
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    //或者
    //    NSDictionary *option = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    //    NSData *data = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    //设置富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    //设置段落格式
    //    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    ////    para.lineSpacing = 7;
    ////    para.paragraphSpacing = 10;
    //    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    return attStr;
    
    
}
+ (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    return string;
}

+(NSMutableAttributedString *)setAttributeTextWithString:(NSString *)string colorString:(NSString *)colorString color:(UIColor *)color
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = [string rangeOfString:colorString];
    
    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributeString;
    
}


+(NSString *)hideEmailWithEmail:(NSString *)email
{
    NSRange range = [email rangeOfString:@"@"];
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:email];
    NSString *emailString;

    SSLog(@"%lu",(unsigned long)range.location);
    
    if (range.location == 0) {
        
        [str1 insertString:@"*" atIndex:1];
        
        emailString = [NSString stringWithFormat:@"%@",str1];
        
    }else if (range.location == 1){
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        
    }else if (range.location == 2){
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        
    }else if (range.location == 3){
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        
    }else if (range.location == 4){
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        
    }else if (range.location == 5){
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        
    }else if(range.location >= 9){
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(3, range.location - 3) withString:@"****"];
        
    }else{
        
        emailString = [email stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
    }
    return emailString;

}


+(void)faceBookEvent
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.facebook.com/GoCoiner"]];
}

+(void)tweentterEvent
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://gocoin.com/twitter"]];
}

+(void)gitHubEvent
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://github.com/GoCoin"]];
}

+(id)day:(id)day night:(id)night
{
    return day;
}

+(int)pointCount:(NSString *)code
{
    /*币种
     btc/usdt  2位
     ltc/usdt 2位
     eth/usdt 2位
     etc/usdt 4位
     zec/usdt 2位
     eos/usdt 4位
     xrp/usdt 4位
     trx/usdt 6位
     dash/usdt  2位
     bch/usdt 2位*/
    if ([code.lowercaseString isEqualToString:@"btc/usdt"] || [code.lowercaseString isEqualToString:@"btc"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"ltc/usdt"] || [code.lowercaseString isEqualToString:@"ltc"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eth/usdt"]|| [code.lowercaseString isEqualToString:@"eth"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"etc/usdt"] || [code.lowercaseString isEqualToString:@"etc"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"zec/usdt"] || [code.lowercaseString isEqualToString:@"zec"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eos/usdt"] || [code.lowercaseString isEqualToString:@"eos"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"xrp/usdt"] || [code.lowercaseString isEqualToString:@"xrp"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"trx/usdt"] || [code.lowercaseString isEqualToString:@"trx"]) {
        return 6;
    }
    if ([code.lowercaseString isEqualToString:@"dash/usdt"]|| [code.lowercaseString isEqualToString:@"dash"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"bch/usdt"]|| [code.lowercaseString isEqualToString:@"bch"]) {
        return 2;
    }
    return 4;
    
}

+(double)pointChangeCount:(NSString *)code{
    
    int coutNum =  [WLTools pointCount:code];
    CGFloat pri = 0.0001;
    switch (coutNum) {
        case 2:
            pri = 0.01;
            break;
        case 4:
            pri = 0.0001;
            break;
        case 6:
            pri = 0.000001;
            break;
        default:
            break;
    }
    return pri;
}


#pragma mark - 保留指定小数位，不进行四舍五入
+(NSString *)noroundingStringWith:(double)price withMoneyCode:(NSString *)code;
{
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",[self moneyNumWithCode:code] + 1];
    NSString *string = [NSString stringWithFormat:format,price];
    
    
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count < 2) {
        return [NSString stringWithFormat:@"%ld",(long)price];
    }
    
    
    NSString *str = array.lastObject;
    //    if (str.length < point) {
    //        return price;
    //    }
    
    if (str.integerValue == 0) {
        return array.firstObject;
    }
    NSString *lastObjc = array.lastObject;
    if (lastObjc.length > 8) {
        str = [NSString stringWithFormat:@"%.8f",str.doubleValue];
    }
    
    NSString *newString = [str substringToIndex:[self moneyNumWithCode:code]];
    
    newString = [WLTools deleteLastZeroWithString:newString];
    
    if (newString.length == 0) {
        return array.firstObject;
    }
    newString = [NSString stringWithFormat:@"%@.%@",array.firstObject,newString];
    
    return newString ;
}

//资产币种
+(NSInteger)moneyNumWithCode:(NSString *)code
{
    code = code.lowercaseString;
    
    if ([code isEqualToString:@"btc"]) {
        return 6;
    }
    if ([code isEqualToString:@"eth"]) {
        return 6;
    }
    if ([code isEqualToString:@"usdt"]) {
        return 6;
    }
    if ([code isEqualToString:@"eos"]) {
        return 6;
    }
    return 0;
}

//根据资产币种进行小数位取舍
+(NSString *)noroundingStringWith:(double)price withPriceCode:(NSString *)code
{
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",[self moneyPriceWithCode:code] + 1];
    NSString *string = [NSString stringWithFormat:format,price];
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count < 2) {
        return [NSString stringWithFormat:@"%ld",(long)price];
    }
    
    
    NSString *str = array.lastObject;
    //    if (str.length < point) {
    //        return price;
    //    }
    
    if (str.integerValue == 0) {
        return array.firstObject;
    }
    NSString *lastObjc = array.lastObject;
    if (lastObjc.length > 8) {
        str = [NSString stringWithFormat:@"%.8f",str.doubleValue];
    }
    
    NSString *newString = [str substringToIndex:[self moneyPriceWithCode:code]];
    
    newString = [WLTools deleteLastZeroWithString:newString];
    
    if (newString.length == 0) {
        return array.firstObject;
    }
    newString = [NSString stringWithFormat:@"%@.%@",array.firstObject,newString];
    
    return newString ;
};



//价格币种
+(NSInteger)moneyPriceWithCode:(NSString *)code
{
    
    /*币种
     btc/usdt  2位
     ltc/usdt 2位
     eth/usdt 2位
     etc/usdt 4位
     zec/usdt 2位
     eos/usdt 4位
     xrp/usdt 4位
     trx/usdt 6位
     dash/usdt  2位
     bch/usdt 2位*/
    if ([code.lowercaseString isEqualToString:@"btc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"ltc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eth/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"etc/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"zec/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eos/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"xrp/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"trx/usdt"]) {
        return 6;
    }
    if ([code.lowercaseString isEqualToString:@"dash/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"bch/usdt"]) {
        return 2;
    }
    return 6;
}
#pragma mark - 保留指定小数位，不进行四舍五入
+(NSString *)notRoundWithString:(NSString*)string afterPoint:(int)position
{
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count < 2)
    {
        return string;
    }
    
    NSString *str = array.lastObject;
    
    if (str.length >= 2)
    {
        if (str.integerValue == 0)
        {
            return array.firstObject;
        }
        
        if (str.length >= position)
        {
            str = [str substringToIndex:position];
        }
        else
        {
            return string;
        }
        
        
        
        str = [WLTools deleteLastZeroWithString:str];
        
        if (str.length == 0)
        {
            return array.firstObject;
        }
        str = [NSString stringWithFormat:@"%@.%@",array.firstObject,str];
        
        return str ;
    }


    return string;
 
}
+ (BOOL)isLocationServiceOpen {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else{
        return YES;
    }
       
}
+(void)openAppLocationSettings{
    if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    }
}
#pragma mark -创建textField
+(UITextField *)allocTextFieldText:(UIFont *)textFont placeHolderFont:(UIFont *)placeHolderFont text:(NSString *)text placeText:(NSString *)placeText textColor:(UIColor *)textColor placeHolderTextColor:(UIColor *)placeHolderTextColor frame:(CGRect)frame {
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
      textField.text = text;
        textField.placeholder = placeText;
    //    [textField setValue:placeHolderTextColor forKeyPath:@"_placeholderLabel.textColor"];
    //    [textField setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeText attributes:@{NSForegroundColorAttributeName:placeHolderTextColor,NSFontAttributeName:placeHolderFont}];
        textField.font = textFont;
        textField.textColor = textColor;
    return textField;
}
@end

