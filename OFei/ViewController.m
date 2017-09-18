//
//  ViewController.m
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "ViewController.h"
#import "normal/NormalViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CCLocationManager.h"
#import "OFeiCommon.h"
#import "Reachability.h"
#import "loginBg.h"
#import "HRAccountTool.h"
#import "AFNetworking.h"


@interface ViewController ()<CLLocationManagerDelegate,MKReverseGeocoderDelegate>
@property(nonatomic,strong)CLGeocoder *geocoder;
@property (nonatomic, strong) Reachability *conn;
@property(nonatomic,strong)loginBg *loginBg;
@end

@implementation ViewController
{
    NormalViewController *normal;
    CLLocationManager *locationmanager;
    NSString *_city;
    NSString *_location;
    NSMutableData *_backData;
    NSDictionary *_weatherDictory;
    NSString *_pm;
    NSString *_weather;
    NSString *_title;
    NSString *_tempMin;
    NSString *_temp;
    NSString *_wind;
    NSString *_windD;
    NSString *_windD1;
    NSString *_date;
    NSMutableDictionary *_dictory;


    UITextField *pwd;

   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
    _myAppDelegate = [[UIApplication sharedApplication] delegate];
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView1 = [[UIImageView alloc] initWithFrame:mainView];
    imageView1.image = [UIImage imageNamed:@"mainBackImage.png"];
    //        _imageView.alpha = 1;
    imageView1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView1];
    
//    NSLog(@"你好");

    [self setlogin];
    
    
    //    画横线
//    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:imageView];
    
//    UIGraphicsBeginImageContext(imageView.frame.size);
//    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.2);
//    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
//    //    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 1, 0, 0);
//    [[UIColor redColor]setStroke];
//    CGContextBeginPath(UIGraphicsGetCurrentContext());
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), X*0.1+3, Y*0.2+39);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), X*0.1+397, Y*0.2+39);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
//    [self setShou];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
         self.conn = [Reachability reachabilityForInternetConnection];
         [self.conn startNotifier];
    
}
- (void)dealloc
{
    [self.conn stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)networkStateChange{
    [self checkNetworkState];
}

-(void)checkNetworkState{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
//    Reachability *ggg= [Reachability ];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
    
        } else if ([conn currentReachabilityStatus] != NotReachable) {
            // 没有使用wifi, 使用手机自带网络进行上网
            NSLog(@"使用手机自带网络进行上网");
            
                } else { // 没有网络
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"网络不可用，请检查网络状态！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    [alert show];
                    NSLog(@"没有网络");
                }
}

-(void)setShou
{
    UILabel *shou = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.9, self.view.frame.size.width, self.view.frame.size.height*0.1)];
    shou.text = @"©上海海洋大学 ~ 数字海洋研究所";
    shou.font = [UIFont systemFontOfSize:12.0f];
    shou.textAlignment = NSTextAlignmentCenter;
    shou.tintColor = [UIColor blueColor];
//    shou.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:shou];

}
-(void)setlogin
{
    
    
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [self drawGradient2:context];
    //登录界面
    CGFloat X = self.view.frame.size.width;
    CGFloat Y = self.view.frame.size.height;
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, Y*0.15, X, 100)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.font = [UIFont fontWithName:@"Arial" size:20];
//    title.text = @"瓯飞工程海洋预报\n信息服务移动平台";
//    title.numberOfLines = 0;
//    [self.view addSubview:title];
    
    UIImageView *title = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, Y*0.2, 300, 30)];
    //    [title.backgroundColor= [UIColor colorWithPatternImage:@"p1.png"]];
//    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ofei3.png"]]];
    [title setImage:[UIImage imageNamed:@"ofei"]];
    [self.view addSubview:title];
    UIImageView *Img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"none.png"]];
    UIImageView *Img1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"none1.png"]];
    
    _loginBg=[[loginBg alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height*0.35, self.view.frame.size.width-40, 100)];
    [_loginBg setBackgroundColor:[UIColor whiteColor]];
    [[_loginBg layer] setCornerRadius:5];
    [[_loginBg layer] setMasksToBounds:YES];
    [self.view addSubview:_loginBg];
    
    //用户名
//    _name = [[UITextField alloc]initWithFrame:CGRectMake(X*0.5-100, Y*0.35, 200, 45)];
    _name=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-50, 50)];
    //    [name setBorderStyle:UITextBorderStyleRoundedRect];
    //设置上边圆角
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:name.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskLayer1= [[CAShapeLayer alloc]init];
//    maskLayer1.frame=name.bounds;
//    maskLayer1.path=maskPath1.CGPath;
//    name.layer.mask=maskLayer1;
//    [name setBorderStyle:UITextBorderStyleRoundedRect];
    _name.placeholder = @" 用 户 名";
    _name.layer.cornerRadius=5.0;
//    name.text = @" ";
    
    _name.backgroundColor=[UIColor clearColor];
    _name.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    _name.clearButtonMode=UITextFieldViewModeWhileEditing;
    _name.returnKeyType=UIReturnKeyNext;
    _name.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
    //设置左右图片
    _name.leftView=Img;
    //    name.rightView=Img;
    _name.leftViewMode=UITextFieldViewModeAlways;
    _name.clearsOnBeginEditing = YES;
    //    [name setDelegate:self];
//    [self.view addSubview:name];
    [_loginBg addSubview:_name];
    
    //密码
//   pwd = [[UITextField alloc]initWithFrame:CGRectMake(X*0.5-100, Y*0.45, 200, 45)];
    pwd=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-50, 50)];
    //    [pwd setBorderStyle:UITextBorderStyleRoundedRect];
    pwd.placeholder = @" 密     码";
    pwd.layer.cornerRadius=5.0;
    //设置下面圆角
//    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:pwd.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskLayer2= [[CAShapeLayer alloc]init];
//    maskLayer2.frame=pwd.bounds;
//    maskLayer2.path=maskPath2.CGPath;
//    pwd.layer.mask=maskLayer2;
//    [pwd setBorderStyle:UITextBorderStyleRoundedRect];
    //设置左右图片
    pwd.leftView=Img1;
    pwd.leftViewMode=UITextFieldViewModeAlways;
    pwd.clearsOnBeginEditing = YES;
    pwd.backgroundColor=[UIColor clearColor];
    pwd.autocapitalizationType = UITextAutocorrectionTypeNo;
    pwd.clearButtonMode=UITextFieldViewModeWhileEditing;
    pwd.returnKeyType=UIReturnKeySend;
    
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
//    pwd.text = @" ";
    //    pwd.keyboardType=UIKeyboardTypeDefault;
    pwd.secureTextEntry=YES;
    [_loginBg addSubview:pwd];
    
    
    //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    [_name setInputAccessoryView:topView];
    [pwd setInputAccessoryView:topView];
    
    
    UIButton *button = [[UIButton alloc]init];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.cornerRadius=5.0;
//    [button setFrame:CGRectMake(X*0.5-150, Y*0.55, 300, 45)];
    [button setFrame:CGRectMake(20, self.view.frame.size.height*0.55, self.view.frame.size.width-40, 50)];
    [button setTitle:@"登     录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:103/255.0 green:201/255.0 blue:255/255.0 alpha:1]];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    

}


-(void) dismissKeyBoard{
    [_name resignFirstResponder];
    [pwd resignFirstResponder];
}


#pragma 获取天气信息的代理方法
//接收到服务器回应的时候调用此方法
//接受到respone,这里面包含了HTTP请求状态码和数据头信息，包括数据长度、编码格式等
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
    _backData = [[NSMutableData alloc]init];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

//接受到数据时调用，完整的数据可能拆分为多个包发送，每次接受到数据片段都会调用这个方法，所以需要一个全局的NSData对象，用来把每次的数据拼接在一起
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_backData appendData:data];
}

//数据接受结束时调用这个方法，这时的数据就是获得的完整数据了，可以使用数据做之后的处理了
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //    NSLog(@"你好%@",[[NSString alloc]initWithData:_backData encoding:NSUTF8StringEncoding]);
    _weatherDictory = [NSJSONSerialization JSONObjectWithData:_backData options:NSJSONReadingMutableContainers error:nil];
    //    NSLog(@"霓虹%@",_weatherDictory);
    //data、datanow\pm25
//    [self weatherDataAnalysis:_weatherDictory];
    //    NSLog(@"")
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

-(void)login{
    
    NSString *username=[_name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password=[pwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self.view endEditing:YES];
    
    //等下打开
    if (!username.length || !password.length) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"用户名或密码为空" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self loginWithUsername:username Password:password];
        
        
        
        
        
    }
    
    
    
    
    
}

-(void)loginWithUsername:(NSString *)userN Password:(NSString *)passW
{
    
    NSURL *url=[NSURL URLWithString:userLogin];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=5.0;
    request.HTTPMethod=@"POST";
    
    NSString *param=[NSString stringWithFormat:@"username=%@&password=%@",_name.text,pwd.text];

    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
    
//    记得要改_name.text
    if ([str isEqualToString:_name.text]) {
        normal = [[NormalViewController alloc] initWithNibName:nil bundle:nil];
        
        UINavigationController *normalView = [[UINavigationController alloc] initWithRootViewController:normal];
        self.delegate = normal;
        
        self.view.window.rootViewController= normalView;
        _array=[NSArray arrayWithObjects:_name.text,pwd.text, nil];
        [HRAccountTool saveAccount:_array];
        NSLog(@"zeytest---%@",_array);
        [self presentViewController:normalView animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"test" object:_dictory];
        }];
    }
    else if ([str isEqualToString:@"null"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"用户名或密码错误，请重新输入！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        self.view.window.rootViewController=[[ViewController alloc]init];
    }
    
    
    
    
}


@end
