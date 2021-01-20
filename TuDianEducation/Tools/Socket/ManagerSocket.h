//
//  ManagerSocket.h
//  ConnectTest
//
//  Created by apple on 14-8-6.
//
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^SocketDidConnectBlock)(void);

@protocol ManagerSocketDelegate
//-(void)socketDidReciveData:(id)data;
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier;

@optional
@end

@interface ManagerSocket : NSObject
@property (nonatomic, weak) id<ManagerSocketDelegate>delegate;

//超时重连时间，默认1秒
@property (nonatomic,assign)NSTimeInterval overtime;
//重连次数,默认5次
@property (nonatomic, assign)NSUInteger reconnectCount;
@property (nonatomic,copy)SocketDidConnectBlock connect;
+ (instancetype)sharedManager;

-(instancetype)initWithUrl:(NSString *)url identifier:(NSString *)identifier;

//判断是否连接
- (BOOL)socketIsConnected;
//开启连接
- (void)openConnectSocketWithConnectSuccess:(SocketDidConnectBlock)connectSuccess;
//关闭连接
- (void)closeConnectSocket;
//发送消息
- (void)socketSendMsg:(NSString*)str;

//单利存储数据

@property(nonatomic,strong)NSMutableDictionary *dataDic;


-(void)removedataDic;

-(NSDictionary *)didWithData:(id)data;

@end


