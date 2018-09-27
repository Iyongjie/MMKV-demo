//
//  Macro.h
//  MMKV-demo
//
//  Created by 李永杰 on 2018/9/27.
//  Copyright © 2018年 muheda. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define MMKVDefault                         [MMKV defaultMMKV]
#define MMKVSetBool(value,key)              [MMKVDefault setBool:value forKey:key]
#define MMKVSetObject(object,key)           [MMKVDefault setObject:object forKey:key]

#define MMKVGetBool(key)                    [MMKVDefault getBoolForKey:key]
#define MMKVGetObject(type,key)             [MMKVDefault getObjectOfClass:type.class forKey:key]

#define MMKVRemoveKeys(keys)                [MMKVDefault removeValuesForKeys:keys]
#define MMKVRemoveKey(key)                  [MMKVDefault removeValueForKey:key]
#define MMKVClearAll                        [MMKVDefault clearAll]
#define MMKVClearMemoryCache                [MMKVDefault clearMemoryCache]

#endif /* Macro_h */
