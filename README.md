# README
####弹出泡泡窗口。
#####点击按钮，弹出可选择弹窗。并可以进行页面跳转。

#####Author:Asahi-Kuang 
####E-mail:[asahikuang@yahoo.com](asahikuang@yahoo.com)
####[个人博客](http://asahi-kuang.github.io/MyBlog_MWeb/archives.html)

###Usage
--
1. 导入`XXPopSheetView`文件夹到工程。里面包含了`ArrayDataSource.h/.m`、`Defines.h`、`XXPopSheetView.h/.m`、`down@2x.png`、`up@2x.png`。
2. 导入头文件`XXPopSheetView.h`。
3. 导入代理`<XXPopSheetDelegate>`
4. 定义全局变量`@property (nonatomic, strong)XXPopSheetView *pop;`
5. 在需要弹出的方法里完成代码
```
	 _pop = [[XXPopSheetView alloc] initWithFrame:button.frame];
    NSArray *titles = @[@"title 1", @"title 2", @"title 3"];
    NSArray *images = @[@"image1", @"image2", @"image3"];
    [_pop setDelegate:self];
    [_pop setTitles:titles];
    [_pop setImages:images];
    [_pop setPopViewWidth:180 andHeight:132];
```

6. 实现代理方法:

```
- (void)view:(XXPopSheetView *)popView didSelectAtIndexPath:(NSInteger)index {
    [_pop dismiss];
    FirstViewController *fVC = [[FirstViewController alloc] init];
    SecondViewController *sVC = [[SecondViewController alloc] init];
    ThirdViewController *tVC = [[ThirdViewController alloc] init];
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = fVC;
            break;
            case 1:
            vc = sVC;
            break;
            case 2:
            vc = tVC;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
```


ps. `titles`是表格显示的标题。`images`是cell图片。`setPopViewWidth:180 andHeight:220`设置泡泡的宽高。


截图：

![pic url](http://a4.qpic.cn/psb?/V106iJhq3r5pvo/85S6e7NquU0PVaHadgdSwNzJKrfkdVH0N2U3xY9Voww!/b/dFsBAAAAAAAA&bo=1AEvA9QBLwMCCS0!&rf=photoDetail)


