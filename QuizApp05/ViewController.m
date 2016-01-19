//
//  ViewController.m
//  QuizApp05
//
//  Created by chikatokitamuro on 2016/01/15.
//  Copyright © 2016年 chikatokitamuro. All rights reserved.
//

#import "ViewController.h"//プロジェクト内のファイル呼び出し

#import <AVFoundation/AVFoundation.h>//音声ライブラリの呼び出し

@interface ViewController ()
@property (strong, nonatomic) NSArray *soundTable;//音声ファイル
@property (strong, nonatomic) AVAudioPlayer *player;//音声ファイル

@property (weak, nonatomic) IBOutlet UITextView *mondai1;
@property (weak, nonatomic) IBOutlet UIButton *maru;
@property (weak, nonatomic) IBOutlet UIButton *peke;

@property (weak, nonatomic) IBOutlet UILabel *kaitou;

@property (weak, nonatomic) IBOutlet UILabel *seitouritu;

@end

@implementation ViewController

int  countNumber;//問題の順番　最初の問題は０番目　case 0

float  seikaisu;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mondai1.text = @"問題１、マツコとキムタクは高校１年の時、同級生であった";//mondai1に入力
    
    self.soundTable = @[@"sei", @"fusei#"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playSound:(NSString*)scaleName
    {
        //音楽ファイル名を作成
        //NSString *soundFileName = [NSString stringWithFormat:@"koukaonn_%@",scaleName];
        
        //音楽ファイル名を「koukaonn_sound」とするならば、引数scaleNameは「sound」となる
        //「@"koukaonn_%@",scaleName」で引数scaleNameが「%@」に代入され、「koukaonn_sound」となる
        //音楽ファイルのファイルパス(音楽ファイルがデータ上どこにあるか)を作成
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:scaleName ofType:@"mp3"];
        //NSString *path = [bundle pathForResource:soundFileName ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        //エラーを受け取る変数の準備
        NSError *error = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (error != nil) { //エラーがあった場合
            return;
        }
        [self.player play];
    }

- (IBAction)maruoshi:(id)sender {
    switch  (countNumber) {
        case 0://問い１の時の処理を書く　maruを押した時の処理
            // 最初の問題は丸が正解なので、正解扱いにする
            [self seikai];//seikai時の処置を呼び出す
            seikaisu++;//seikaisuを一つカウントする
            break;
        case 1:
            [self seikai];
            seikaisu++;
            break;
        case 2:
            [self fuseikai];//fuseikai時の処置を呼び出す
            break;
        case 3:
            [self seikai];
            seikaisu++;
            break;
        case 4:
            [self fuseikai];
            break;
        default:
            break;
    }
    // 正解でも不正解でも、次の問いに進む
    countNumber++;
    [self showQuestion];//
    

}




- (IBAction)pekeoshi:(id)sender {
    switch (countNumber) {
        case 0:
            [self fuseikai];
            break;
        case 1:
            [self fuseikai];
            break;
        case 2:
            [self seikai];
            seikaisu++;
            break;
        case 3:
            [self fuseikai];
            break;
        case 4:
            [self seikai];
            seikaisu++;
            break;
        default:
            break;
    }
    
    countNumber++;
    [self showQuestion];

}

- (void)seikai {
    // 正解だった時の処理
    self.kaitou.text = @"正解です";
    self.seitouritu.text = [NSString stringWithFormat:@"正解率は%lf％です",seikaisu/5*100]
    ;
    //正解時の音声ファイルを鳴らす
    NSString *musicName = @"shot-struck1";//ダウンロードしたファイル
    [self playSound:musicName];
}

- (void)fuseikai {
    // 不正解だった時の処理
    self.kaitou.text = @"不正解です";
    NSString *string = @"bomb1";
    //不正解時の音声ファイルを鳴らす
    [self playSound:string];

}

// 問題を出題する
- (void)showQuestion {
    switch (countNumber) {
        case 0:
            self.mondai1.text = @"問題１、マツコとキムタクは高校１年の時、同級生であった";
            break;
        case 1:
            self.mondai1.text = @"問題2、一富士二鷹三茄子の次は四扇子、五煙草、六座頭である";
            break;
        case 2:
            self.mondai1.text = @"問題3、首無しのニワトリマイクは１８日間生きた";
            break;
        case 3:
            self.mondai1.text = @"問題4、クマムシは宇宙空間でも死なない";
            break;
        case 4:
            self.mondai1.text = @"問題5、唾液は無菌状態であるため、消毒にも使用できる";
            break;
        default:
            break;
    }
}

- (IBAction)pushKeyboard:(id)sender {
    
    [self playSound:self.soundTable[[sender tag]-1]];
}


@end


