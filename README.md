Download android ndk to such as /usr/local/android-ndk-r26d

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
