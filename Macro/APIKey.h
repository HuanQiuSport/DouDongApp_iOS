//
//  APIKey.h
//  ShengAi
//
//  Created by 刘赓 on 2018/10/29.
//  Copyright © 2018年 刘赓. All rights reserved.
//
/**
 *  本类放一些第三方常量
 */
/* 使用高德地图API，请注册Key，注册地址：http://lbs.amap.com/console/key */
#define RSA_Public_key         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCetmJK/hpaoKgzjAqjcVE/XvWNpKhZt/m3B/tzGpn5ck+ZV5jBxp8oGuhreeHCMEqE6VQX+FIovGNL0I/5rLQpWgD1dg3PRuI324g7/wJ488i3UOTc4xpE6esy8+wR4dUEsWfvbrB6znLeduikhCqaHbElZtVFfAmC2eWcob5QzQIDAQAB"//Agou
static NSString *BaiduMap_APIKey = @"TWC2ybVAS387MaFmv26RdYSeExoGc5l5";//百度地图Key

////支付宝支付状态
//NSString *const AliPay_RESULT = @"PayResult";
     //NSString * const AliPay_SAFEPAY = @"SafePay";  //支付宝scheme
//NSString * const SCHEME_AliPay = @"ShengAiStore_AliPay";

//微信支付结果
//NSString * const WechatPay_RESULT = @"weChat_pay_result";
//微信App_id
//NSString * const WechatPay_AppID = @"wx6a81e31edc698b3d";


#define HansongTest NO
#import "MKSingeUserCenterVC.h"
#define MKBakcColor kHexRGB(0x242a37)
#define MKTextColor kHexRGB(0xc4c1c1)//
#define MKSelectColor kHexRGB(0xf54b64)
#define MKNoSelectColor kHexRGB(0xffffff)
#define MKBorderColor kHexRGB(0x4b5774)
#define MKSignColor kHexRGB(0x666e87)
#define MKFanNumColor kHexRGB(0x9ca5c3)
#define MKSelectTextColor kHexRGB(0xf54b64)

#pragma mark ======================================== MD5加盐 ========================================
#define Salt @"2f7607f1d1ee429ea4a978cf904990d6"


#pragma mark - 调整环球体育App文本 https://www.hqbet24.app/?i_code=6215472  itms-services://?action=download-manifest&url=https://bt.5li2v2.com/channel/ios/hqbetgame_201_6215472_202009132133_4712.plist

//#define mkSkipHQAppString @"https://www.hqbet24.app/?i_code=6215472"

#define mkSkipHQAppString @"itms-services://?action=download-manifest&url=https://bt.5li2v2.com/channel/ios/hqbetgame_201_6215472_202009132133_4712.plist"
