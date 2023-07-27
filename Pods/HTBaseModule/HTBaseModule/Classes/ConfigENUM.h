//
//  ConfigENUM.h
//  Hucolla
//
//  Created by 李雪健 on 2022/10/24.
//

#ifndef ConfigENUM_h
#define ConfigENUM_h

// 播放器的几种状态
typedef NS_ENUM(NSInteger, ENUM_HTPlayerState) {
    ENUM_HTPlayerStateFailed,        // 播放失败
    ENUM_HTPlayerStateBuffering,     // 缓冲中
    ENUM_HTPlayerStatePlaying,       // 播放中
    ENUM_HTPlayerStateStopped,       // 暂停播放
    ENUM_HTPlayerStateFinished,      // 播放完成
};

// 播放器当前时间 本条字幕时间状态
typedef NS_ENUM(NSInteger, ENUM_HTSubtitleState) {
    ENUM_HTSubtitleStateLessStart,        // 小于开始时间
    ENUM_HTSubtitleStateDuration,         // 开始和结束时间之间，显示本条字幕
    ENUM_HTSubtitleStateThanEnd,          // 大于结束时间
};

// The fileload state
typedef NS_ENUM(NSUInteger, ENUM_HTFileloadState) {
    ENUM_HTFileloadStateNone,           // default
    ENUM_HTFileloadStateWillResume,     // waiting
    ENUM_HTFileloadStateFileloading,    // fileloading
    ENUM_HTFileloadStateSuspened,       // suspened
    ENUM_HTFileloadStateCompleted,      // fileload completed
    ENUM_HTFileloadStateFailed          // fileload failed
};

typedef void(^BLOCK_HTBlock)(BOOL isSelect);
typedef void(^BLOCK_dataBlock)(id data);
typedef void(^BLOCK_cellBlock)(id data, BOOL var_isTType);
typedef void(^BLOCK_HTVoidBlock)(void);
typedef void(^BLOCK_SearchBlock)(NSString *word, NSInteger type, NSInteger index);

#endif /* ConfigENUM_h */
