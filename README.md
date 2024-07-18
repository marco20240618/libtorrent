Boost and openssl headers and libs are already included, you don't need to download them separately.

If build for Linux and Windows, you don't need to download anything extra, except the build environment though.

If build for Android, you only need to download android ndk to such as /usr/local/android-ndk-r26d

1. build client_test for linux
```
cmake -B build -Dlinux-amd64=on
cmake --build build -j $(nproc)
```

2. build for android arm64
```
cmake -B build -Darm64-v8a=on
cmake --build build -j $(nproc)
```

3. build for windows amd64

in Developer Command Prompt for VS 2022
```
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=14 -B build -G Ninja -Dwindows-amd64=on
cmake --build build
```


Prebuilt boost and openssl location

Windows

boost: https://sourceforge.net/projects/boost/files/boost-binaries

openssl: https://www.firedaemon.com/get-openssl

Android

boost: https://github.com/moritz-wundke/Boost-for-Android.git

openssl: https://github.com/217heidai/openssl_for_android.git

Linux

apt install libboost-tools-dev libboost-dev libboost-system-dev libssl-dev
