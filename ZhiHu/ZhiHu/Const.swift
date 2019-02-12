//
//  Const.swift
//  ZhiHu
//
//  Created by 陈逸辰 on 2019/2/9.
//  Copyright © 2019 陈逸辰. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeigth = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
func isIPhoneXSeries() -> Bool {
    var isIPhoneXSeries : Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return isIPhoneXSeries
    }
    if #available(iOS 11.0, *) {
        let bottom : CGFloat = 0.0
        if (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > bottom {
            isIPhoneXSeries = true
        }
    }
    return isIPhoneXSeries
}

// statusBarHeight
let statusBarHeight : CGFloat = isIPhoneXSeries() ? 44 : 20

// navigationBarHeight
let navigationBarHeight : CGFloat = isIPhoneXSeries() ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIPhoneXSeries() ? 49 + 34 : 49

func RGBColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
}

let ZHHeaders : [String:String] = [
    "User-Agent":"osee2unifiedRelease/4.33.1 (iPhone; iOS 12.0.1; Scale/2.00)",
    "Cookie":"_zap=1639818f-9007-4613-9615-c2ce97a23d67; _xsrf=vshcG4pZDa0fcQqbnY0YSuD1T45TxGJO; z_c0=gt2.0AAAAAARfDVsK2CLE2MAgAAAAAAtNVQJgAgDWlRYg8XQEgby-40Kc7hfy7-H8fg==; d_c0=ACDA2MQi2ApLBa51T6LvzEkoh1dzeryKLAw=|1549941558; q_c1=78c8b25dd818487da108cdc81139ef31|1549890196000|1549890196000; zst_82=1.0ADBk_DhB9w4LAAAASwUAADEuMFN2YVwAAAAAOP7o3vKhNiVxPnpwy49BcWjRjks=",
    "X-APP-VersionCode":"1208",
    "X-ZST-82":"1.0ADBk_DhB9w4LAAAASwUAADEuMFN2YVwAAAAAOP7o3vKhNiVxPnpwy49BcWjRjks=",
    "X-Ab-Param":"top_core_session=-1;top_followtop=1;zr_km_feed_rpm=default;se_ios_spb309=1;top_v_album=1;top_newuser_feed=1;top_rerank_reformat=2;se_new_suggest=1;top_bill=0;top_billvideo=0;tp_discussion_feed_card_type=2;zr_infinity=zr_infinity_close;tp_m_intro_re_topic=0;se_auto_syn=0;soc_brandquestion=1;zr_art_rec_rank=base;top_new_user_gift=0;tp_related_tps_movie=b;se_click2=0;se_webrs=0;li_lt_tp_score=1;se_consulting_price=n;soc_bigone=0;top_quality=0;tp_qa_metacard_top=top;zr_boost_recall=0;top_hkc_test=10;top_round_table=-1;soc_zero_follow=0;top_billab=0;se_likebutton=0;top_newfollowans=0;qa_answerlist_ad=0;se_preset_tech=1;top_tagextend=2;tp_qa_metacard=1;top_30=0;se_km_ad_locate=0;zr_art_rec=new;top_nad=1;se_entity=on;se_major_onebox=major;tp_discussion_feed_type_android=2;se_majorob_style=2;se_correct_ab=0;top_creator_level=1;top_is_gr=0;top_reason=1;top_recall_deep_user=1;top_test_4_liguangyi=1;tp_write_pin_guide=3;zr_km_material_buy=2;se_qanchor=0;tp_related_topics=e;top_feedre=1;top_yc=0;qa_web_answerlist_ad=0;top_wonderful=1;se_webtimebox=1;top_newfollow=0;top_vidnocon=0;se_ios_spb309bugfix=0;li_filter_ttl=2;ls_new_video=1;qa_video_answer_list=0;top_root=0;tp_dis_version=0;se_prf=1;soc_icon=1;top_login_card=1;top_sj=2;top_native_answer=1;top_root_ac=1;se_spb309=0;se_second_search=1;soc_special=0;pin_efs=orig;top_gif=0;top_ntr=1;se_minor_onebox=d;se_p_slideshow=0;se_zu_onebox=0;top_billpic=0;top_tr=0;tp_header_style=1;pf_newguide_vertical=1;se_config=1;top_follow_reason=0;se_wiki_box=1;top_ebook=0;top_promo=2;zr_rel_search=base;pin_ef=orig;top_new_feed=1;top_nucc=0;se_time_search=new;top_raf=y;se_search_feed=N;se_sensitive=0;top_cc_at=1;top_recall_exp_v2=4;top_sess_diversity=-1;qa_test=0;tp_answer_meta_guide=1;top_freecontent=1;top_universalebook=1;li_album_liutongab=0;se_consulting_switch=off;se_topicseed=0;top_recall_exp_v1=5;se_wannasearch=0;se_daxuechuisou=new;ug_zero_follow=0;se_colos=1;se_new_market_search=on;se_websearch=3;tp_sticky_android=0;se_premium_member=0;top_video_rerank=-1;se_billboardsearch=0;se_webmajorob=0;se_mfq=1;li_gbdt=default;se_backsearch=0;se_zu_recommend=0;top_question_ask=1;top_ydyq=A;tp_sft=a;ug_follow_answerer=2;zr_article_rec_rank=truncate;se_ad_index=10;top_billupdate1=3;top_brand=1;top_source=0;top_card=-1;top_new_user_rec=0;top_yhgc=0;zr_ans_rec=gbrank;zr_video_rec=zr_video_rec:base;li_ts_sample=old;top_distinction=2;top_user_gift=0;pf_creator_card=1;top_thank=1;top_rank=4;gw_guide=1;se_expired_ob=0;se_roundtable=0;top_hotlist=1",
    "x-app-za" : "OS=iOS&Release=12.0.1&Model=iPhone9,1&VersionName=4.33.1&VersionCode=1208&Width=750&Height=1334&DeviceType=Phone&Brand=Apple&OperatorType=46001",
    "Connection":"keep-alive",
    "X-APP-VERSION":"4.33.1",
    "Authorization" : "Bearer gt2.0AAAAAARfDVsK2CLE2MAgAAAAAAtNVQJgAgDWlRYg8XQEgby-40Kc7hfy7-H8fg==",
    "X-UDID" : "ACDA2MQi2ApLBa51T6LvzEkoh1dzeryKLAw=",
    "Accept-Language":"zh-Hans-CN;q=1, en-CN;q=0.9, ko-CN;q=0.8, ja-JP;q=0.7",
    "X-APP-Build" : "release",
    "X-SUGER" : "SURGVj02MjYzRkNGOC05Q0I2LTREMDYtQTQ2My04RjA4MTAzQTkwODE7SURGQT03RkEzMzBCQy0xQzM5LTQzRkEtQjdFQS1BNTJGQTlDNTIwQkU7Q09PUkRfTEFUPTIzLjMwMzQ1MzkzMDUyODEzO0NPT1JEX0xORz0xMTYuMTcyODM3NTk5MjExMTtDT09SRF9USU1FU1RBTVA9MTU0OTk0MTU1OTtMQlM9eyJzdHJlZXQiOiLmlrDlhYnot68iLCJsYXRpdHVkZSI6IjIzLjMwMDk0MiIsImxvbmdpdHVkZSI6IjExNi4xNzc1MDUiLCJwb2lOYW1lIjoiIiwiY2l0eUNvZGUiOiIifTtMQlNfTEVOR1RIPTkxO0xCU19UUz0xNTQ5ODg5NDgxMDAwO1VESUQ9QUNEQTJNUWkyQXBMQmE1MVQ2THZ6RWtvaDFkemVyeUtMQXc9",
    "Accept":"*/*",
    "Accept-Encoding":"br, gzip, deflate",
    "X-API-Version":"3.0.97"
]

