//
//  ZQAccountModel.h
//  Moshfocus
//
//  Created by admin on 2021/11/8.
//

#import "HTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQAccountModel : HTBaseModel

@property (nonatomic, copy) NSString *var_avatar;
@property (nonatomic, copy) NSString *var_name;
@property (nonatomic, copy) NSString *var_userid;
@property (nonatomic, copy) NSString *var_gender;
@property (nonatomic, copy) NSString *var_birth;
@property (nonatomic, copy) NSString *var_mail;
@property (nonatomic, copy) NSString *var_phone;
@property (nonatomic, copy) NSString *var_type;//0邮箱 1谷歌 2fb 3苹果
// 绑定账号
@property (nonatomic, copy) NSString *var_bindPlanState;//绑定账号的VIP状态
@property (nonatomic, copy) NSString *var_bindStartTime;//开始时间
@property (nonatomic, copy) NSString *var_bindEndTime;//到期时间
@property (nonatomic, copy) NSString *var_bindRenewStatus;//续订状态
@property (nonatomic, copy) NSString *var_bindPid;//产品ID
@property (nonatomic, copy) NSString *var_bindAppId;//绑定appId
@property (nonatomic, copy) NSString *var_bindAppName;//绑定项目
@property (nonatomic, copy) NSString *var_bindAppOs;//绑定系统 1:iOS
@property (nonatomic, copy) NSString *var_bindMail;//绑定用户
@property (nonatomic, copy) NSString *var_bindShelf;//绑定项目是否下架
@property (nonatomic, copy) NSString *var_bindUbt;//绑定用户是否有有效订单
@property (nonatomic, copy) NSString *var_bindT1;//是否工具包订阅用户 1=电影 2=工具
// 家庭计划
@property (nonatomic, copy) NSString *var_familyPlanState;//家庭计划的状态 0:不是家庭VIP |  1:是家庭vip
@property (nonatomic, copy) NSString *var_identity;//身份 1:管理员 | 2:成员
@property (nonatomic, copy) NSString *var_fid;// 家庭ID
@property (nonatomic, copy) NSString *var_vipStartTime;//开始时间
@property (nonatomic, copy) NSString *var_vipEndTime;//到期时间
@property (nonatomic, copy) NSString *var_renewStatus;//续订状态
@property (nonatomic, copy) NSString *var_pid;// 产品ID

@property (nonatomic, copy) NSString *var_toolVip;// 是工具包订阅用户

@end

NS_ASSUME_NONNULL_END
