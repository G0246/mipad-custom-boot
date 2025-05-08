# MiPad Custom Boot Animation
English | [简体中文](/README_zh-CN.md)

## Introduction
A simple module designed exclusively for tablet devices, replacing the boot animations with custom ones. Unlike phones, tablets often adapt their animations based on device orientation.
> [!NOTE]  
> Currently tested only on the Xiaomi Pad 6 Pro (liuqin) running V14.0.9.0.TMYCNXM. It should basically work on every other tablet models, brands, and systems, but further testing is needed to confirm compatibility.

## Requirements
- Magisk v26.1+ / KernelSU v0.8.0+ / APatch 10568+
- Android 11+ (API 30+)
> [!WARNING]
> This module is designed for Magisk. KernelSU and APatch are not fully supported and unexpected bugs may occur.

## Themes
- Original light version

## Installation
1. Download the [latest](https://github.com/G0246/mipad-custom-boot/releases/latest) release
2. Change the animation timing or design to your liking (Optional)
3. Flash .zip module in the Magisk / KernelSU / APatch app
> [!TIP]
> If you get a blank screen after adding your own animation, it’s likely because the ZIP file wasn’t compressed right. Use "store-only" mode (no compression) when creating the ZIP.

## To-Dos
1. Add a script (Python) to automate the generation of different orientation animation ZIPs
2. Auto detect and select path for corresponding models

## Disclaimer
**Flashing this module may cause your device to bootloop, a bootloop saver module is highly recommended. I am not responsible for any damages caused to your device or data by using this module. Use at your own risk.**

## License
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
