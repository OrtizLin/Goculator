//
//  ViewController.m
//  Goculator
//
//  Created by Otis Lin on 2018/3/2.
//  Copyright © 2018年 Otis Lin. All rights reserved.
//

#import "ViewController.h"
#import "setting.h"
#import "UIButton+UIButton_goculatorBackground.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self padButtonInit];
    [self funcButtonInit];
    [self otherFuncButtonInit];
    [self answerViewInit];
    totalString=@"";
}

/* create +,-,x,/ button */
-(void)funcButtonInit{
    for(int i=0;i<5;i++){
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor colorWithRed:248.0/255.0 green:114.0/255.0 blue:17.0/255.0 alpha:1]];
        [btn setPadBackgroundColor:[UIColor colorWithRed:248.0/255.0 green:114.0/255.0 blue:17.0/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setPadBackgroundColor:[UIColor colorWithRed:190.0/255.0 green:57.0/255.0 blue:6.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:33];
        [btn addTarget:self action:@selector(padClick:) forControlEvents:UIControlEventTouchDown];
        btn.frame=CGRectMake(303,[UIScreen mainScreen].bounds.size.height-100-100*i-i, [UIScreen mainScreen].bounds.size.width-302, 100);
        if(i==0)
            [btn setTitle:[NSString stringWithFormat:@"="] forState:UIControlStateNormal];
        else if(i ==1)
            [btn setTitle:[NSString stringWithFormat:@"+"] forState:UIControlStateNormal];
        else if(i ==2)
            [btn setTitle:[NSString stringWithFormat:@"-"] forState:UIControlStateNormal];
        else if(i ==3)
            [btn setTitle:[NSString stringWithFormat:@"\u00d7"] forState:UIControlStateNormal];
        else if(i ==4)
            [btn setTitle:[NSString stringWithFormat:@"\u00f7"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
}
/* create 0~9 , . button */
-(void)padButtonInit{
    for(int i=0;i<11;i++){
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:189.0/255.0 green:190.0/255.0 blue:194.0/255.0 alpha:1]];
        [btn setPadBackgroundColor:[UIColor colorWithRed:189.0/255.0 green:190.0/255.0 blue:194.0/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setPadBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:33];
        [btn addTarget:self action:@selector(padClick:) forControlEvents:UIControlEventTouchDown];
        if(i==0){
            btn.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-100, 201, 100);
            [btn setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
        }
        else if(i==10){
            btn.frame=CGRectMake(202,[UIScreen mainScreen].bounds.size.height-100, 100, 100);
            [btn setTitle:[NSString stringWithFormat:@"."] forState:UIControlStateNormal];
        }
        else{
            int a =2;   //line 2
            if(i>3 && i<7)
                a=3;    //line 3
            else if(i>=7)
                a=4;    //line 4
            if(a ==2)
                btn.frame=CGRectMake(0+100*(i-1)+(i-1), [UIScreen mainScreen].bounds.size.height-a*100-1, 100, 100);
            else if(a ==3)
                btn.frame=CGRectMake(0+100*(i-4)+(i-4), [UIScreen mainScreen].bounds.size.height-a*100-2, 100, 100);
            else
                btn.frame=CGRectMake(0+100*(i-7)+(i-7), [UIScreen mainScreen].bounds.size.height-a*100-3, 100, 100);
            [btn setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
        }
        [self.view addSubview:btn];
    }
}
/* create AC button */
-(void)otherFuncButtonInit{
    for(int i=0;i<3; i++){
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:200.0/255.0 blue:202.0/255.0 alpha:1]];
    [btn setPadBackgroundColor:[UIColor colorWithRed:189.0/255.0 green:190.0/255.0 blue:194.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setPadBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:28];
    [btn addTarget:self action:@selector(padClick:) forControlEvents:UIControlEventTouchDown];
        if(i==0){
            [btn setTitle:[NSString stringWithFormat:@"AC"] forState:UIControlStateNormal];
            btn.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-504,100,100);
        }
        else if(i ==1){
            [btn setTitle:[NSString stringWithFormat:@"("] forState:UIControlStateNormal];
            btn.frame=CGRectMake(101,[UIScreen mainScreen].bounds.size.height-504,100,100);
        }
        else{
            [btn setTitle:[NSString stringWithFormat:@")"] forState:UIControlStateNormal];
            btn.frame=CGRectMake(202,[UIScreen mainScreen].bounds.size.height-504,100,100);
        }
    [self.view addSubview:btn];
    }
}
/* create answer background view and text view */
-(void)answerViewInit{
    UIView *answerBackground =[[UIView alloc]init];
    answerBackground.backgroundColor=[UIColor blackColor];
    answerBackground.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-505);
    [self.view addSubview:answerBackground];
    
    textView= [[UITextView alloc]initWithFrame:CGRectMake(0,answerBackground.frame.size.height-100, [UIScreen mainScreen].bounds.size.width, 100)];
    textView.backgroundColor=[UIColor blackColor];
    textView.textColor=[UIColor whiteColor];
    [textView setFont:[UIFont systemFontOfSize:25]];
    textView.delegate =self;
    textView.editable = NO;
    [answerBackground addSubview:textView];
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
    gestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [answerBackground addGestureRecognizer:gestureRecognizer];
}
/* button click */
-(void)padClick:(UIButton*)sender{
    if([sender.titleLabel.text isEqualToString:@"AC"]){
    totalString =@"";
    textView.text=totalString;
    }
    else if([sender.titleLabel.text isEqualToString:@"="])
        [self equalButtonClick];
    else{
    totalString = [totalString stringByAppendingString:sender.titleLabel.text];
    textView.text=totalString;
    }
}
/* transfer calculation */
-(void)equalButtonClick{
    if(![totalString isEqualToString:@""]){
    totalString =[totalString stringByReplacingOccurrencesOfString:@"\u00d7" withString:@"*"];
    totalString =[totalString stringByReplacingOccurrencesOfString:@"\u00f7" withString:@"/"];
    NSDictionary*dict =@{@"Input":totalString};
    NSArray*answer =[self postAPI:dict];
        if(answer==NULL)
            textView.text = @"ERROR !!";
        else
            textView.text = [answer valueForKey:@"output"];
    totalString=@"";
    }
}

/* Get answer from heroku */
-(NSArray*)postAPI:(NSDictionary *)dict{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroku_url]]
                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:100.0];
    [request setHTTPMethod:@"POST"];
    if(dict!=nil){
        NSError *err;
        NSData *jsonData =[NSJSONSerialization dataWithJSONObject:dict options:0 error:&err];
        [request setHTTPBody:jsonData];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_semaphore_t _semaphore = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@ERROR", error);
                                                    } else {
                                                        JsonArray= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                        });
                                                    }
                                                    dispatch_semaphore_signal(_semaphore);
                                                }];
    [dataTask resume];
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    return JsonArray;
}

#pragma mark - others
-(void)swipeHandler{
    if(totalString.length !=0){
       totalString = [totalString substringToIndex:[totalString length]-1];
        textView.text=totalString;
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
