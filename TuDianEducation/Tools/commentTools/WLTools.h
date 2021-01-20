
//
//  WLTools.h
//  WeiLv
//
//  Created by James on 16/2/16.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>


@interface WLTools : NSObject<NSXMLParserDelegate>

#pragma mark - 加密实现MD5和SHA1
+(NSString *) md5:(NSString *)str;
+(NSString*) sha1:(NSString *)str;

#pragma mark - 实现http GET/POST 解析返回的json数据
+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data;

#pragma mark - 颜色十六进制转换成UIColor
+(UIColor *) stringToColor:(NSString *)str;

#pragma mark - 颜色十六进制转换成UIColor
+(UIColor *) stringToColor:(NSString *)str andAlpha:(CGFloat)value;

#pragma mark - 把格式化的JSON格式的字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - 把字典转换成JSON格式
+ (NSString *)wlDictionaryToJson:(NSDictionary *)dic;

#pragma mark - 把数组转换成JSON格式
+ (NSString *)wlArrayToJson:(NSArray *)arr;

#pragma mark - 创建label
+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;
#pragma mark -创建textField
+(UITextField *)allocTextFieldTextFont:(CGFloat)textFont placeHolderFont:(CGFloat)placeHolderFont text:(NSString *)text placeText:(NSString *)placeText textColor:(UIColor *)textColor placeHolderTextColor:(UIColor *)placeHolderTextColor frame:(CGRect)frame;
#pragma mark - 创建button
+ (UIButton *)allocButtonTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor image:(UIImage *)image frame:(CGRect)frame sel:(SEL)sel taget:(id)taget;
#pragma mark - 创建imageView
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image;

#pragma mark - 计算小数点有几位
+ (NSString*)decimalPrecisionWithString:(NSString*)_str;

#pragma mark--返回不带小数点的字符串
+ (NSString *)returnIntStrFrom:(NSString *)str;

#pragma mark--返回两位小数点的字符串
+ (NSString *)return02lfStrFrom:(NSString *)str;

#pragma mark--转换时间戳
+ (NSString *)convertTimestamp:(double)seconds andFormat:(NSString *)format;

#pragma mark--空字符串判断
+ (BOOL)judgeString:(NSString *)returnStr;

#pragma mark--NSNumber转string
+ (NSString*)stringTransformObject:(id)object;

#pragma mark--过滤字符串中的空格
+(NSString *)FliterWhiteSpace:(NSString *)str;

#pragma mark--过滤字符串中的html标签
+ (NSString *)filterHTML:(NSString *)html;

#pragma mark--删除webView 的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView;

#pragma mark--验证MD5字符串
+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;

#pragma mark--获取当前时间戳
+(NSString *)getOrderTrSeq;

#pragma mark--获取当前时间毫秒级
+(NSString *)getOrderTimeMS;

#pragma mark--获取当前时间分钟级
+(NSString *)getOrderTime;

#pragma mark-- 获取iPhone客户端UUID
+(NSString*)getIPhoneUUID;

#pragma mark--获取iPhone客户端MAC地址
+(NSString *)getIPhoneMacAddress;

#pragma mark--过滤特殊字符
+ (NSString *)filterSpecialString:(NSString *)string;

#pragma mark - 获取字符串的宽度
+(CGFloat)getStringWidth:(NSString *)str fontSize:(float)size;

#pragma mark - 获取字符串的高度
+(CGFloat)getStringHeight:(NSString *)str fontSize:(float)size;

#pragma mark - 手机号码格式化
+(NSString *)phoneNumberFormat:(NSString *)phone;

#pragma mark - 字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity;

#pragma mark - 实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity;

#pragma mark - 判断是否为整形
+ (BOOL)isPureInt:(NSString*)string;

#pragma mark - 判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string;

#pragma mark - 根据身份证号，获取生日 - 18位
+(NSString *)birthdayStrFromIdentityCard_18:(NSString *)numberStr;

#pragma mark - 根据身份证号，获取生日 - 15位
+(NSString *)birthdayStrFromIdentityCard_15:(NSString *)numberStr;

#pragma mark - 根据身份证号，获取性别 - 18 位
+(NSString *)getIdentityCardSex_18:(NSString *)numberStr;

#pragma mark - 根据身份证号，获取性别 - 15 位
+(NSString *)getIdentityCardSex_15:(NSString *)numberStr;
#pragma mark - 自己拼接字典转json串
+ (NSString *)WL_FomateJsonWithDictionary:(NSDictionary *)dic;

#pragma mark - 图片等比率缩放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

#pragma mark - 自定长宽
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

#pragma mark - 字符串反转 方法一
+ (NSString *)reverseWordsInString1:(NSString *)str;

#pragma mark - 字符串反转 方法二
+ (NSString*)reverseWordsInString2:(NSString*)str;

#pragma mark - 获取汉字的拼音
+ (NSString *)transform:(NSString *)chinese;

#pragma mark - 阿拉伯数字转中文格式
+(NSString *)translation:(NSString *)arebic;

#pragma mark - 计算文件大小
+ (long long)fileSizeAtPath:(NSString *)path;

#pragma mark - 计算文件夹大小
+ (long long)folderSizeAtPath:(NSString *)path;

#pragma mark - 计算字符串字符长度，一个汉字算两个字符 方法一
+ (int)convertToInt:(NSString*)strtemp;

#pragma mark - 计算字符串字符长度，一个汉字算两个字符 方法二
+(NSUInteger) unicodeLengthOfString: (NSString *) text;

#pragma mark - 字符串中是否含有中文
+ (BOOL)checkIsChinese:(NSString *)string;

#pragma mark - 过滤表情
+ (NSString *)filterEmoji:(NSString *)string;

#pragma mark - 是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma mark - 获取date的下个月日期
+(NSDate *)nextMonthDate:(NSDate *)date;

#pragma mark - 获取date的下下个月日期
+(NSDate *)nextnextMonthDate:(NSDate *)date;

#pragma mark - 获取date日期对应的天
+(NSInteger)getDay:(NSDate *)date;

#pragma mark - 获取date日期对应的月
+(NSInteger)getMonth:(NSDate *)date;

#pragma mark - 获取date日期对应的年
+(NSInteger)getYear:(NSDate *)date;

#pragma mark - 颜色变成UIImage
+(UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

#pragma mark - 传入 秒 得到 时分秒
+(NSString *)getHHMMSSFromSS:(NSString *)totalTime;
#pragma mark -根据时间戳获取时间字符
+(NSString *)getdateStringFromTimetal:(NSTimeInterval)timeInterval dateFomate:(NSString *)dataFormate;

#pragma mark - 传入 秒 得到 分秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime;

#pragma mark - 提取字符串中的汉字
+ (NSArray *)getAStringOfChineseWord:(NSString *)string;

#pragma mark - 生成guid字符串
+ (NSString*) stringWithGUID;

#pragma mark - 浮点数格式化
+(NSString *)formatFloat:(float)f;

#pragma mark - 获取未来某个日期是星期几
+(NSString *)featureWeekdayWithDate:(NSString *)featureDate;

#pragma mark - 计算2个日期相差天数
+(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

#pragma mark - 计算2个日期相差天数
+(NSInteger)secondFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

#pragma mark -  获取当前是星期几
+ (NSInteger)getNowWeekday;

#pragma mark - 过滤HTML（包含换行空格等特殊符号）
+ (NSString *)flattenHTML:(NSString *)html;

#pragma mark - 保留指定小数位，不进行四舍五入
+(NSString *)notRounding:(float)price afterPoint:(int)position;

#pragma mark - （最多）保留小数位，不四舍五入，不保留无效0
+(NSString *)noroundingStringWith:(double)price afterPointNumber:(NSInteger)point;

#pragma mark - （最多）保留小数位，不四舍五入，不保留无效0
+(NSString *)roundingStringWith:(double)price afterPointNumber:(NSInteger)point;

#pragma mark - 把字符串替换成星号
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;

#pragma mark - 判断用户输入的密码是否符合规范，符合规范的密码要求
+(BOOL)judgePassWordLegal:(NSString *)pass min:(NSInteger)min max:(NSInteger)max;

#pragma mark - 保留多位小数后 去掉0
+ (NSString *)noZero:(double)number afterPoint:(int)position;

#pragma mark - 姓名改为 姓**
+ (NSString *)name:(NSString *)nameStr;


+(void)textField:(UITextField *)textField setPlaceHolder:(NSString *)placeHolder color:(UIColor *)color;

+(CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font;



// 如果图片地址没带域名，添加域名
+ (NSString*)imageURLWithURL:(NSString *)imageURL;

// 把时间转换成天、时、分、秒格式
+(NSString *)countDownTimeWithTime:(long)time;


// 交易对保留小数位
+(NSInteger)dotNumberOfCoinCode:(NSString *)coinCode;

// 买入量保留小数位
+(NSInteger)dotNumberOfCoinName:(NSString *)coinName;


// 手机号中建四位加*号
+(NSString *)hidePhoneMiddleNumberWithMobile:(NSString *)mobile;

+ (UIViewController *)getCurrentViewController;

+ (NSMutableAttributedString *)loadHtmlTOLabelHtmlStr:(NSString *)htmlStr;
+ (NSString *)htmlEntityDecode:(NSString *)string;

+(NSMutableAttributedString *)setAttributeTextWithString:(NSString *)string colorString:(NSString *)colorString color:(UIColor *)color;
//资产币种小数点保留个数
+(NSInteger)dotNumberOfAssetCoinName:(NSString *)coinName;

+(NSString *)hideEmailWithEmail:(NSString *)email;
#pragma mark faceBook
+(void)faceBookEvent;

#pragma mark tweentter
+(void)tweentterEvent;

#pragma mark gitHub
+(void)gitHubEvent;


+(NSInteger)dotNumberOfBBCoin:(NSString *)coinName;

//+(id)day:(id)day night:(id)night;

#pragma mark 根据币种返回保留位数
+(int)pointCount:(NSString *)code;

+(double)pointChangeCount:(NSString *)code;

#pragma mark - 保留小数位，不四舍五入
//根据资产币种进行小数位取舍
+(NSString *)noroundingStringWith:(double)price withMoneyCode:(NSString *)code;
//根据资产价格进行小数位取舍
+(NSString *)noroundingStringWith:(double)price withPriceCode:(NSString *)code;
#pragma mark - 保留指定小数位，不进行四舍五入
+(NSString *)notRoundWithString:(NSString*)string afterPoint:(int)position;
///定位是否打开
+ (BOOL)isLocationServiceOpen;
///打开定位设置
+(void)openAppLocationSettings;

//yyyy-MM-dd HH:mm:ss
+ (NSString *)getDetailedDateWithTimeInterval:(long long)interval;
+(UITextField *)allocTextFieldText:(UIFont *)textFont placeHolderFont:(UIFont *)placeHolderFont text:(NSString *)text placeText:(NSString *)placeText textColor:(UIColor *)textColor placeHolderTextColor:(UIColor *)placeHolderTextColor frame:(CGRect)frame;

@end

