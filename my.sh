if [ -z "$1" ]; then
   echo "please specify target"
   echo "1 linux-amd64"
   echo "2 arm64-v8a"
   echo "3 armeabi-v7a"
   echo "4 x86_64"
   echo "5 x86"
   echo "6 windows-amd64"
   exit
elif [ $1 -eq 1 ]; then
   target=linux-amd64
elif [ $1 -eq 2 ]; then
   target=arm64-v8a
elif [ $1 -eq 3 ]; then
   target=armeabi-v7a
elif [ $1 -eq 4 ]; then
   target=x86_64
elif [ $1 -eq 5 ]; then
   target=x86
elif [ $1 -eq 6 ]; then
   target=windows-amd64
else
   echo "wrong target"
   exit
fi

rm -rf build/
cmake -B build -D$target=on
cmake --build build -j $(nproc)
