# Android Test Framework Demo in Ruby
> A simple demo framework for testers to test Android native app in Ruby

### Development
> You need to have basic knowledge of Appium and its configuration

> It only works from Android 5.0, otherwise you need to switch to use appium-selendroid instead of appium-uiautomator2

Basic
```bash
#Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#Java
brew update
brew cask install java
```

Install Node.js & Ruby
```bash
#Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
#
# Install node
nvm install 7.6.0
nvm install 0.10.33
nvm alias default 7.6.0
node -v
npm -v

#Install rvm and ruby
curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install 2.2.6
rvm use 2.2.6

gem install bundle
```

Install Android SDK
> Easily you could use Android studio install the latest version of Android SDK with Platform/Build tools. 
As the bug of Appium(appium-adb), https://github.com/appium/appium/issues/7961, please change as what I described in the ticket after you install appium.

Install Appium(at least 1.6.4) on Mac OS X
```bash
brew install carthage # For iOS test
npm install appium
npm install appium-doctor

#link command, please you use ~/ as nvm root
ln -s ~/node_modules/appium/build/lib/main.js /usr/local/bin/appium
ln -s ~/node_modules/appium-doctor/appium-doctor.js /usr/local/bin/appium-doctor
```

Build it
```bash
cd <project root>/demo_common_lib/
bundle install
rake install
```

Run Test from CMD
```bash
# Only connect 1 android device or 1 emulator

cd <project root>/calculator_android_test/
bundle install
cucumber _2.4.0_ /Users/robin/RubymineProjects/android-test-frame/calculator_android_test/features --format pretty --format html --out report.html --tags @regression --verbose --color -r features
```

### Issues
1. Hangs under appium install
```bash
npm config set maxsockets 1
npm config set registry http://registry.npmjs.org/
npm config set strict-ssl false

```
2. Create folders if it is necessary
```bash
# Because maybe jenkins cannot access your /usr/local folder, so maybe you need to create it by your self

# Ensure you have
touch /usr/local/var/log/appium.log
```