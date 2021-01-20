

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYLogicHelper : NSObject

// 适配(文字,等等)
+(CGFloat)sizeFitWithiphoneTypeByMaxValue:(CGFloat)mv;

//// 获取唯一UUID
//+ (NSString *)uuidString;

// toast
//+(void)showMsg:(NSString *)msg;

// 当前控制器
+ (UIViewController *)findCurrentViewController;

// 首次登录
+ (BOOL) isFirstLoad;

// 首次登录,不改状态
+ (BOOL) isFirstLoadwithOutChageState;

//退登
+(void)quit;

// MD5加密, 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// MD5加密, 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// MD5加密, 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;
//MD5加密, 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

// 签名
+(NSString *)signStr:(NSMutableDictionary*)dict;
// 当前时间戳(13位)
+(NSString *)getNowTimestamp;
// 当前时间戳(10位)
+(NSString *)getNowTimestamp10;
// 空字符串
+ (BOOL)isBlankString:(NSString *)string;
// 获取当前时间
+(NSString*)getCurrentTimes;
// json串转dictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  对象转换为JSONData
 *  @return NSData
 */
+ (nullable NSData *)JSONData:(id)obj;

/**
 *  对象转换为JSONString
 *  @return NSString
 */
+ (nullable NSString *)JSONString:(id)obj;

/**
 *  将JSONString转换为对象
 *  @param jsonString json字符串
 *  @return 对象
 */
+ (nullable id)objectFromJSONString:(nullable NSString *)jsonString;

/**
 *  将JSONString转换为对象
 *  @param jsonData json字符串
 *  @return 对象
 */
+ (nullable id)objectFromJSONData:(nullable NSData *)jsonData;

//传入 秒  得到  xx分钟xx秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

// 图片格式
+ (NSString *)typeForImageData:(NSData *)data;

// 获取视频封面
+ (UIImage *)xy_getVideoThumbnail:(NSData *)data;

// 获取视频时长
+ (NSString *)getVideoTimeByUrlString:(NSString*)urlString;

// 颜色相同判断
+ (BOOL) isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB;

// 表情云配置
+(void)DTSet:(nullable NSString *)uid;

+(NSString *)getTimeFromTimestamp:(double)time;

@end

NS_ASSUME_NONNULL_END
