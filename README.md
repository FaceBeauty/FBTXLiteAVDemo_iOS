简体中文 | [English](README_EN.md)

# **FBTXLiteAVDemo_iOS**
## **说明**
- 本文介绍如何快速配置FaceBeauty模块

<br/>

## **操作步骤**

### **1. 配置工程**
下载完成后，打开工程
- 将 **Bundle Display Name** 和 **Bundle Identifier** 分别替换为您的**应用名**和**包名**
- 将AppDelegate.m中[[FaceBeauty shareInstance] initFaceBeauty:@"YOUR_APP_ID" withDelegate:nil];的**YOUR_APP_ID**替换成您的**AppId**
- 编译，运行，日志搜索**init-status**可以查看相关日志
- 具体执行步骤可以全局搜索 **//todo --- facebeauty** 进行查看 

<br/>
