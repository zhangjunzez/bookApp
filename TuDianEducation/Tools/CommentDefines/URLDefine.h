//
//  UrlDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//


#define SUCCESSED 200



#ifdef DEBUG

//叶文海
//#define ProductBaseServer  @"http://192.168.1.86:8080"

//张龙飞
//#define ProductBaseServer  @"http://192.168.1.109:8080"

//#define ProductBaseServer  @"http://47.56.9.200"



//#define MarketSocketUrl @"ws://47.56.9.200/websocket/xxx"

//#define ProductBaseServer @"https://api.bnexcoin.com"
//api.digtat.comhttp://139.224.73.213/supplyanddemand
#define kBaseRequstUrl @"http://139.224.73.213/supplyanddemand"
#define ProductBaseServer @"http://139.224.73.213/supplyanddemand/api/"
//92.168.1.17
//#define ProductBaseServer @"http://192.168.1.17:8080"
#define MarketSocketUrl @"wss://api.digtat.com/websocket/xxx"
#define ImageBaseServer  ProductBaseServer

#else



//#define ProductBaseServer  @"http://api.tengcoin.vip"
#define kBaseRequstUrl @"http://139.224.73.213/supplyanddemand"
#define ProductBaseServer @"http://139.224.73.213/supplyanddemand/api/"
#define ImageBaseServer  ProductBaseServer

#define MarketSocketUrl @"wss://api.digtat.com/websocket/xxx"



#endif




//#define ENVIRONMENT 1 //  0－开发/1－正式
//
//#if ENVIRONMENT == 0
//
//#elif ENVIRONMENT == 1
//
//#endif


/************************************ 登录、注册、忘记密码、获取验证码 ****************************/

///公共接口
///获取验证码

#define kGetCodeUrl  @"getValidateCode"
///用户注册
#define kUserRegisterActionUrl @"engineerRegister"
///忘记密码
#define kUserForgetPassWordUrl @"engineerforgetPwd"
///修改密码
#define kUserEngineerupdatePasswordUrl @"engineerupdatePassword"
///设置支付密码
#define kEngineeraddpaypasswordUrl @"engineeraddpaypassword"
///修改支付密码
#define kEngineerupdatepaypasswordUrl @"engineerupdatepaypassword"
///工程师短信登录
#define kUserMessageLoginUrl @"engineerphoneLogin"
///密码登录
#define kUserPassWordLoginUrl @"engineerLogin"
///退出登录
#define kUserQuiteOutLoginUrl @"engineeroutlogin"
///服务发布
#define kAddservicestoUrl @"addservicesto"
///技能分享发布
#define kAddskillsUrl @"addskills"
///跑马灯
#define kEngineerhorseracelampListUrl @"engineerhorseracelampList"
///抢单大厅getnearorderdemandlist
#define kGetnearorderdemandlist @"getnearorderdemandlist"
///消息列表
#define kEngineernoticeslist @"engineernoticeslist"
///清空消息列表
#define kEngineerdeletenotices @"engineerdeletenotices"
///需求订单抢单
#define kEngineerorderdemandgrabbing @"engineerorderdemandgrabbing"

///*****************************个人中心********************
///个人信息
#define kUserInforUrl @"engineeruserinfo"
///编辑个人信息
#define kEdtingUserUrl @"editengineerInfo"
///获取行业分类
#define kGetindustrysListUrl @"getindustrysList"
///版本更新
#define kVersionUpdateUrl @"versionupdate"
///意见反馈
#define kAddengineerfeedbackUrl @"addengineerfeedback"
///新增修改地址
#define kEngineeraddAddressUrl @"engineeraddAddress"
///地址列表
#define kEngineerAddressListUrl @"engineerAddressList"
///删除地址
#define kEngineerdeleteAddress @"engineerdeleteAddress"
///获取获取月度签到记录
#define kGetclockinmonthUrl @"getclockinmonth"
///签到
#define kAddclockUrl @"addclock"
///我的收益
#define kEngineermoneylist @"engineermoneylist"
///提现申请
#define kAddwithdrawalengineerUrl @"addwithdrawalengineer"
///我的提现记录
#define kWithdrawalengineerlist @"withdrawalengineerlist"
///积分记录列表
#define kEngineerintegrallist @"engineerintegrallist"
///实名认证
#define kAddengineerauth @"addengineerauth"
///客服热线
#define kGetcustomersUrl @"getcustomers"

///推荐用户
#define kEngineermemberlist @"engineermemberlist"
///推荐工程师
#define kEngineerengineerlist @"engineerengineerlist"
///获取封面图片
#define kGetimagesUrl @"getimages"
///技能分享类型
#define kGetskillstype @"getskillstype"

///我发布的学习列表
#define kGetmyskillslist @"getmyskillslist"
///我发布过的服务
#define kGetmyservicestoUrl @"getmyservicesto"
///服务详情
#define kMyservicestodetailUrl @"myservicestodetail"
///服务的上下架
#define kMyservicestoputUrl @"myservicestoput"
///学习列表
#define kGetskillsstudylistUrl @"getskillsstudylist"
///删除学习技能
#define kDeleteskillsUrl @"deleteskills"
///上传学习时间
#define kAddskillsstudyUrl @"addskillsstudy"
///获取城市列表
#define kGetcityListUrl @"getcityList"
///帮助中心
#define kGetengineerhelplist @"getengineerhelplist"

///*********************行业资讯*****************************

///资讯分类
#define kInformationsTypeListUrl @"informationsTypeList"
///资讯列表
#define kInformationsListUrl @"informationsList"
///咨询详情
#define kInformationsdetailUrl @"informationsdetail"


///*******************学习天地************************
///学习天地列表
#define kGetSkillListUrl @"getskillslist"
///学习天地详情
#define kGetSkillsDetailUrl @"getskillsdetail"
///*********************************订单*********************
///需求订单列表
#define kEngineerorderdemandlistUrl @"engineerorderdemandlist"
///需求订单确认
#define kEngineerorderdemandconfirm @"engineerorderdemandconfirm"
///需求订单删除
#define kEngineerorderdemanddelete @"engineerorderdemanddelete"
///需求订单详情
#define kEngineerorderdemanddetail @"engineerorderdemanddetail"

///服务订单列表
#define kEngineerorderservicestolistUrl @"engineerorderservicestolist"
///服务订单确认
#define kOrderservicestoconfirmengineerUrl @"orderservicestoconfirmengineer"
///服务订单删除
#define kOrderservicestodeleteengineer @"orderservicestodeleteengineer"
///服务订单详情
#define kEngineerorderservicestodetail @"engineerorderservicestodetail"


///*********积分商城**************
#define kGetgoodslistUrl @"getgoodslist"

///积分商城详情
#define kGoodsdetailUrl @"goodsdetail"
///兑换积分商品
#define kExchangegoodsUrl @"exchangegoods"
///积分商城订单
#define kMyordergoodslistUrl @"myordergoodslist"
///商品订单详情
#define kMyordergoodsdetailUrl @"myordergoodsdetail"
///商品订单确认收货
#define kOrdergoodsconfirmUrl @"ordergoodsconfirm"
///查看物流
#define kLooklogisticsUrl @"looklogistics"
///订单删除
#define kOrdergoodsdelete @"ordergoodsdelete"
