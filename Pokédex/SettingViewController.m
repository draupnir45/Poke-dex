//
//  SettingViewController.m
//  TabNavAndView
//
//  Created by 박종찬 on 2017. 2. 22..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "SettingData.h"
#import "PokeWikiWebViewController.h"



@interface SettingViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UISwitch *tintSwitch;
@property (nonatomic, weak) UISwitch *battleSixSwitch;
@property (weak) SettingData *settings;

@end



@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;
    
    self.settings = [SettingData sharedSettings];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        default:
            return 3;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseID"];
    }
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"즐겨찾기 포켓몬";
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            } else {
                cell.textLabel.text = @"배틀식스";
                UISwitch *battleSixSwitch = [[UISwitch alloc] init];
                battleSixSwitch.on = self.settings.battleSixEnabled;//로드
                self.battleSixSwitch = battleSixSwitch;
                cell.accessoryView = self.battleSixSwitch;
                [self.battleSixSwitch addTarget:self action:@selector(battleSix:) forControlEvents:UIControlEventValueChanged];
            }
            break;
            
        default: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"CC-BY-SA 3.0";
                    cell.detailTextLabel.text = @"동일조건변경허락";
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                case 1:
                    cell.textLabel.text = @"이미지 출처 - Nintendo";
                    cell.detailTextLabel.text = @"collected by veekun";
                    break;
                default:
                    cell.textLabel.text = @"도감 글 출처 - 포켓몬 위키";
                    break;
                }
            }
            
            
            break;
    }
    
    if ([cell.accessoryView isMemberOfClass:[UISwitch class]]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"FavoritePokemonSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"webViewSegue" sender:self];
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"즐겨찾기";
            break;
            
        default:
            return @"라이선스";
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"배틀식스 모드를 켜면 즐겨찾기가 6마리까지만 포함됩니다.";
    } else {
        return nil;
    }
    
    
}

#pragma mark - Control Settings





- (void)battleSix:(UISwitch *)sender {
    if (self.settings.favoritePokemonIndexes.count > 6) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"이미 6마리 이상을 등록했습니다!"
                                                                       message:@"목록에서 해제하시겠어요?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:cancel];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

            [self performSegueWithIdentifier:@"FavoritePokemonSegue" sender:self];
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        
        [self.battleSixSwitch setOn:NO];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
    self.settings.battleSixEnabled = sender.on;
    }
    
}

#pragma mark - Navigation

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"webViewSegue"]) {
        UINavigationController *navi = segue.destinationViewController;
        PokeWikiWebViewController *webView = (PokeWikiWebViewController *)navi.topViewController;
        
        NSString *urlString = @"https://creativecommons.org/licenses/by-sa/3.0/deed.ko";
        webView.title = @"CC-BY-SA 3.0";
        webView.urlString = urlString;
        
    }
    
}


@end
