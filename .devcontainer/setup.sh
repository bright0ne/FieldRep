#!/usr/bin/env bash
set -e

# Install dependencies
sudo apt-get update
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Install Flutter
if [ ! -d "$HOME/flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
fi
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc

# Install Android SDK
mkdir -p $HOME/Android/Sdk/cmdline-tools
cd $HOME/Android/Sdk/cmdline-tools

if [ ! -d "latest" ]; then
  curl -Lo commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
  unzip commandlinetools.zip -d cmdline-tools
  rm commandlinetools.zip
  mv cmdline-tools latest
fi

echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools' >> ~/.bashrc

source ~/.bashrc

# Install Android packages
yes | sdkmanager --licenses || true
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# Run flutter doctor once
flutter doctor