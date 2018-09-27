//
//  ViewController.m
//  MMKV-demo
//
//  Created by 李永杰 on 2018/9/27.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark 存取对象
//存取图片
    UIImage *image = [UIImage imageNamed:@"doutula1.jpg"];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    MMKVSetObject(data, @"doutula1");
    [self.view addSubview:self.imageView];
    NSData *tmpData = MMKVGetObject(NSData, @"doutula1");
    UIImage *tmpImage = [UIImage imageWithData:tmpData];
    self.imageView.image = tmpImage;
//存字符串
    NSString *str1 = @"夏侯惇";
    MMKVSetObject(str1, @"str1");
    NSLog(@"%@",MMKVGetObject(NSString, @"str1"));
    
/*  存取集合类型,先转换为NSData
    原因:https://github.com/Tencent/MMKV/issues/10   说是集合里的值类型不确定，不容易编码解码
    而NSUserDefault能直接存取系统的集合类型,MMKV多此一步，猜测性能依然大于NSUserDefault
*/
    NSDictionary *dic1 = @{@"str1":@"夏侯惇",
                           @"str2":@"白起",
                           @"str3":@"典韦"
                           };
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic1 options:NSJSONWritingPrettyPrinted error:nil];
    MMKVSetObject(data1, @"data1");
    NSData *tmpData1 = MMKVGetObject(NSData, @"data1");
    NSDictionary *tmpDic =[NSJSONSerialization JSONObjectWithData:tmpData1 options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",tmpDic);
    
    NSArray *arr1 = @[@"吕布",@"曹操",@"诸葛亮"];
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:arr1];
    MMKVSetObject(data2, @"data2");
    NSData *tmpData2 = MMKVGetObject(NSData, @"data2");
    NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:tmpData2];
    NSLog(@"%@",arr2);
    
#pragma mark 存取数值
//bool
    
    
    MMKVSetBool(YES, @"second");
    BOOL second = MMKVGetBool(@"second");
    NSLog(@"%d",second);
//数值
    /*
     unit64_t     %llu
     unit32_t     %u
     */
    [MMKVDefault setInt32:32 forKey:@"32"];
    NSLog(@"%u",[MMKVDefault getInt32ForKey:@"32"]);
    [MMKVDefault setUInt32:33 forKey:@"u33"];
    NSLog(@"%u",[MMKVDefault getUInt32ForKey:@"u33"]);
    
    [MMKVDefault setInt64:64 forKey:@"64"];
    NSLog(@"%llu",[MMKVDefault getInt64ForKey:@"64"]);
    [MMKVDefault setUInt64:66 forKey:@"66"];
    NSLog(@"%llu",[MMKVDefault getUInt64ForKey:@"66"]);
    
    [MMKVDefault setFloat:33.33 forKey:@"float1"];
    NSLog(@"%@",@([MMKVDefault getFloatForKey:@"float1"]));
    
    [MMKVDefault setDouble:1111.1111 forKey:@"double1"];
    NSLog(@"%@",@([MMKVDefault getDoubleForKey:@"double1"]));

#pragma mark 查找删除
//遍历所有key
    [MMKVDefault enumerateKeys:^(NSString *key, BOOL *stop) {
        NSLog(@"%@",key);
    }];
    
    
    size_t count = [MMKVDefault count];
    NSLog(@"包含:%ld个key",count);
    
    
//删除key
//    MMKVRemoveKey(@"second");
//    NSArray *arr = @[@"second",@"doutula1"];
//    MMKVRemoveKeys(arr);

//    MMKVClearAll;
//    MMKVClearMemoryCache;
//
//    size_t count1 = [MMKVDefault count];
//    NSLog(@"包含:%ld个key",count1);
    
}
#pragma mark - 懒加载
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    }
    return _imageView;
}
@end
