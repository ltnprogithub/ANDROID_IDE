#!/bin/bash
cd && wget https://github.com/jzinferno/termux-ndk/releases/download/v1/android-ndk-r24-aarch64.zip && unzip android-ndk-r24-aarch64.zip && rm -rf android-ndk-r24-aarch64.zip && mkdir android-sdk/ndk && mv android-ndk-r24 24.0.8215888 && mv 24.0.8215888 android-sdk/ndk/ && ln -s $HOME/android-sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-aarch64 $HOME/android-sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64 && ln -s $HOME/android-sdk/ndk/24.0.8215888/prebuilt/linux-aarch64 $HOME/android-sdk/ndk/24.0.8215888/prebuilt/linux-x86_64 && echo 'Installation Finished. Ndk has been installed successfully!'
cd
install_dir=$HOME
sdk_dir=$install_dir/android-sdk
ndk_dir=$sdk_dir/ndk/24.0.8215888

echo "[NOTICE] This cmake is for aarch64 only !"
echo "[DEBUG] Patching existing cmake config from ${ndk_dir}/build/cmake/android-legacy.toolchain.cmake"
cd $install_dir


sed -i 's/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Android)\nset(ANDROID_HOST_TAG linux-aarch64)\nelseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/g' $ndk_dir/build/cmake/android-legacy.toolchain.cmake
sed -i 's/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Android)\nset(ANDROID_HOST_TAG linux-aarch64)\nelseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/g' $ndk_dir/build/cmake/android.toolchain.cmake

echo "[DEBUG] Installing cmake version \"3.23.1\" to path ${sdk_dir}/cmake/3.23.1/"
# download cmake
wget https://github.com/arcans1998/cmake-4-androidide/raw/main/cmake.zip
# unzip cmake
unzip cmake.zip -d $sdk_dir
rm cmake.zip
# set executable permission for cmake
chmod -R +x $sdk_dir/cmake/3.23.1/bin
# add cmake to path
echo -e "\nPATH=\$PATH:$HOME/android-sdk/cmake/3.23.1/bin" >> $SYSROOT/etc/ide-environment.properties

echo 'Installation Finished. Ndk has been installed successfully!'
