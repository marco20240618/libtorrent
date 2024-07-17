if [ -z "$1" ]; then
   echo "please specify target"
   echo "1 linux-amd64"
   echo "2 arm64-v8a"
   echo "3 armeabi-v7a"
   exit
elif [ $1 -eq 1 ]; then
   target=linux-amd64
elif [ $1 -eq 2 ]; then
   target=arm64-v8a
elif [ $1 -eq 3 ]; then
   target=armeabi-v7a
else
  echo "wrong target" 
  exit
fi

rm -rf build/
cmake -B build -D$target=on
cmake --build build -j $(nproc)
