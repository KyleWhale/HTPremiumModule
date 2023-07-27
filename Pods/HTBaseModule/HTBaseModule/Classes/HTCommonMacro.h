//
//  HTCommonMacro.h
//  PostTest
//
//  Created by 李雪健 on 2023/7/27.
//

#ifndef HTCommonMacro_h
#define HTCommonMacro_h

#define AsciiString(object) [LKFPrivateFunction lgjeropj_stringFromAsciiArray:object]
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define HTPingFangFont(var_font) [UIFont systemFontOfSize:var_font weight:UIFontWeightMedium]
#define HTPingFangRegularFont(var_font) [UIFont systemFontOfSize:var_font weight:UIFontWeightRegular]
#define isIPhoneX_X_orMore kStatusHeight > 20
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define REAL_WIDTH      ((kScreenWidth < kScreenHeight) ?kScreenWidth :kScreenHeight)
#define REAL_HEIGHT     ((kScreenWidth < kScreenHeight) ?kScreenHeight :kScreenWidth)
#define kScale  (kScreenWidth / 375.0)
#define kWidthScale(a)                  (isPad ? 1 : (REAL_WIDTH / 375))*(a)
#define kStatusHeight  [UIDevice statusBarHeight]
#define kNavBarHeight  (kStatusHeight +  44.f)
#define TabBarHeight                        [UIDevice tabbarHeight]
#define LR_TabbarSafeBottomMargin           (isIPhoneX_X_orMore ? 34.f : (isPad ? 15.f : 0.f))
#define ViewHeight [[UIScreen mainScreen] bounds].size.height - LR_TabbarSafeBottomMargin
#define kHJBottomHeight  [UIDevice safeBottom]
#define AsciiString(object) [LKFPrivateFunction lgjeropj_stringFromAsciiArray:object]
#define LocalString(string,comment) [LKFPrivateFunction lgjeropj_stringWithKid:string]
#define LocalInt(index) [LKFPrivateFunction lgjeropj_stringWithKid:@index]
#define kMainColor  [UIColor colorWithHexString:@"#232331"]
#define kNavBGColor  [UIColor colorWithHexString:@"#313143"]
#define kTabbarBGColor  [UIColor colorWithHexString:@"#1D1D1D"]

#define PrivacyPolicy  @"https://sites.google.com/view/moshfocus/privacypolicy"
#define TermService    @"https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"
#define IAP_AppStore   @"https://buy.itunes.apple.com/verifyReceipt"
#define IAP_SANDBOX    @"https://sandbox.itunes.apple.com/verifyReceipt"

#define HT_IPA_Month         @"month" //测试
#define HT_IPA_Year          @"year"
#define HT_IPA_Week          @"week"
#define HT_IPA_Mosh          @"free"//mosh
#define HT_IPA_Family        @"family" //测试

#define IAP_ShareKey   @"e7486eea6edb43309cad765b4d0eaa92"//测试 eb85b9543e1d4dff9d848c69eddab245

#define FBAppId             @"1005459233456032"
#define KochavaAPPGUID      @"ko-301-7d9q2"

#define Base_URL  @"http://54.187.6.80" //测试
#define TP_App_Id          @"100"//测试 289
#define AppleID           @"6446979826" //测试

#endif /* HTCommonMacro_h */
