# mipad-custom-boot
[English](/README.md) | 简体中文

## 描述
专为平板设备打造的 Magisk 模块，可修改开机动画。平板与其他设备略有不同，其动画会根据设备的方向而更改。目前仅在小米 Pad 6 Pro (liuqin) V14.0.9.0.TMYCNXM 上进行了测试，但其他型号也应该可以使用。

## 要求
- Magisk v26.1+
- Android 11+ (API 30+) - 其他 API 说不定也能用
> [!NOTE]
> 检查 /system/media/ 或 /product/media/ 中是否有多个 bootanimation*.zip

## 安装
1. 下载 [最新](https://github.com/G0246/mipad-custom-boot/releases/latest) 版本
2. 根据自己的喜好更改动画时间或设计（可选）
3. Magisk 应用中刷入 .zip 模块
> [!TIP]
> 如果您在添加自己的动画主题后看到空白一片，则说明您没有正确压缩它，ZIP 应该解压缩（仅存储模式）。

## 免责声明
**刷写此模块可能会导致您的设备进入引导循环，强烈建议使用引导循环保护模块。对于使用此模块对您的设备或数据造成的任何损害，我概不负责。使用风险自负。**
