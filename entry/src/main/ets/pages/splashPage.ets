import common from '@ohos.app.ability.common';
import router from '@ohos.router';

@Entry
@Component
struct SplashIndex {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  aboutToAppear() { // 到时间则自动跳转至主页面
    setTimeout(() => {
      router.replaceUrl({ url: 'pages/mainPage' });
    }, 2000);
  }

  aboutToDisappear() {
    clearTimeout();
  }

  build() {
    Column() {
      Text($r('app.string.EntryAbility_label'))
        .fontFamily('HarmonyHeiTi')
        .fontSize(29)
        .fontColor('#182431')
        .fontWeight(700)
        .letterSpacing(0.1)
        .margin({top: 680})
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.splashBackground'))
    .backgroundImageSize(ImageSize.Cover)
    .backgroundImagePosition({y: -100})
  }
}