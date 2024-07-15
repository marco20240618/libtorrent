rm -rf build/
#cmake -B build -Dlinux-amd64=on
#cmake -B build -Darm64-v8a=on
cmake -B build -Darmeabi-v7a=on
cmake --build build -j $(nproc)
