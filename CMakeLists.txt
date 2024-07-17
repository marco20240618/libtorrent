cmake_minimum_required(VERSION 3.16.0)

project(project1)

file(GLOB src "src/*.cpp" "src/ed25519/*.cpp" "src/kademlia/*.cpp" "src/pe_crypto.cpp")

if (linux-amd64)
   set(CMAKE_CXX_COMPILER "/usr/bin/g++")
   add_library(torrent-rasterbar-linux-amd64 STATIC ${src})
   target_include_directories(torrent-rasterbar-linux-amd64 PRIVATE deps/try_signal include include/libtorrent)
   target_compile_options(torrent-rasterbar-linux-amd64 PRIVATE -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden -Wno-noexcept-type -Wall -Wextra -Wno-format-zero-length -Wpedantic -Wvla -DBOOST_ALL_NO_LIB -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_ASIO_HAS_STD_CHRONO -DBOOST_ASIO_NO_DEPRECATED -DBOOST_MULTI_INDEX_DISABLE_SERIALIZATION -DBOOST_NO_DEPRECATED -DBOOST_SYSTEM_NO_DEPRECATED -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_BUILDING_LIBRARY -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -D_FILE_OFFSET_BITS=64 -c)

   add_library(try_signal-linux-amd64 STATIC deps/try_signal/signal_error_code.cpp deps/try_signal/try_signal.cpp)
   target_compile_options(try_signal-linux-amd64 PRIVATE -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden  -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -c)

   add_executable(client_test-linux-amd64 examples/client_test.cpp examples/print.cpp examples/torrent_view.cpp examples/session_view.cpp)
   target_include_directories(client_test-linux-amd64 PRIVATE deps/try_signal include include/libtorrent)
   target_link_libraries(client_test-linux-amd64 torrent-rasterbar-linux-amd64 try_signal-linux-amd64 boost_system ssl crypto)
   target_compile_options(client_test-linux-amd64 PRIVATE -Wl,--start-group -Wl,-Bstatic -Wl,-Bdynamic -lrt -ldl -Wl,--end-group -pthread -std=c++14)
   target_link_options(client_test-linux-amd64 PRIVATE -static-libstdc++)
elseif (arm64-v8a)
   set(CMAKE_CXX_COMPILER /usr/local/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android26-clang++)
   
   add_library(torrent-rasterbar-arm64-v8a STATIC ${src})
   target_include_directories(torrent-rasterbar-arm64-v8a PRIVATE boost/include openssl/include deps/try_signal include include/libtorrent)
   target_compile_options(torrent-rasterbar-arm64-v8a PRIVATE -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden -Wno-noexcept-type -Wall -Wextra -Wno-format-zero-length -Wpedantic -Wvla -DBOOST_ALL_NO_LIB -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_ASIO_HAS_STD_CHRONO -DBOOST_ASIO_NO_DEPRECATED -DBOOST_MULTI_INDEX_DISABLE_SERIALIZATION -DBOOST_NO_DEPRECATED -DBOOST_SYSTEM_NO_DEPRECATED -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_BUILDING_LIBRARY -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -D_FILE_OFFSET_BITS=64 -c)

   add_library(try_signal-arm64-v8a STATIC deps/try_signal/signal_error_code.cpp deps/try_signal/try_signal.cpp)
   target_compile_options(try_signal-arm64-v8a PRIVATE -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden  -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -c)

   add_executable(client_test-arm64-v8a examples/client_test.cpp examples/print.cpp examples/torrent_view.cpp examples/session_view.cpp)
   target_include_directories(client_test-arm64-v8a PRIVATE boost/include openssl/include deps/try_signal include include/libtorrent)
   target_link_libraries(client_test-arm64-v8a torrent-rasterbar-arm64-v8a try_signal-arm64-v8a ${CMAKE_SOURCE_DIR}/boost/libboost_system-clang-mt-a64-1_85.a ${CMAKE_SOURCE_DIR}/openssl/arm64-v8a/lib/libssl.a ${CMAKE_SOURCE_DIR}/openssl/arm64-v8a/lib/libcrypto.a)
   #target_compile_options(client_test-arm64-v8a PRIVATE -Wl,--start-group -Wl,-Bstatic -Wl,-Bdynamic -lrt -ldl -Wl,--end-group -pthread -std=c++14)
   target_compile_options(client_test-arm64-v8a PRIVATE -pthread -std=c++14)
   target_link_options(client_test-arm64-v8a PRIVATE -static-libstdc++)
elseif (armeabi-v7a)
   set(CMAKE_CXX_COMPILER /usr/local/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi26-clang++)

   add_library(torrent-rasterbar-armeabi-v7a STATIC ${src})
   target_include_directories(torrent-rasterbar-armeabi-v7a PRIVATE boost/include openssl/include deps/try_signal include include/libtorrent)
   target_compile_options(torrent-rasterbar-armeabi-v7a PRIVATE -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden -Wno-noexcept-type -Wall -Wextra -Wno-format-zero-length -Wpedantic -Wvla -DBOOST_ALL_NO_LIB -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_ASIO_HAS_STD_CHRONO -DBOOST_ASIO_NO_DEPRECATED -DBOOST_MULTI_INDEX_DISABLE_SERIALIZATION -DBOOST_NO_DEPRECATED -DBOOST_SYSTEM_NO_DEPRECATED -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_BUILDING_LIBRARY -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -D_FILE_OFFSET_BITS=64 -c)

   add_library(try_signal-armeabi-v7a STATIC deps/try_signal/signal_error_code.cpp deps/try_signal/try_signal.cpp)
   target_compile_options(try_signal-armeabi-v7a PRIVATE -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden  -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -c)

   add_executable(client_test-armeabi-v7a examples/client_test.cpp examples/print.cpp examples/torrent_view.cpp examples/session_view.cpp)
   target_include_directories(client_test-armeabi-v7a PRIVATE boost/include openssl/include deps/try_signal include include/libtorrent)
   target_link_libraries(client_test-armeabi-v7a torrent-rasterbar-armeabi-v7a try_signal-armeabi-v7a ${CMAKE_SOURCE_DIR}/boost/libboost_system-clang-mt-a32-1_85.a ${CMAKE_SOURCE_DIR}/openssl/armeabi-v7a/lib/libssl.a ${CMAKE_SOURCE_DIR}/openssl/armeabi-v7a/lib/libcrypto.a)
   #target_compile_options(client_test-arm64-v8a PRIVATE -Wl,--start-group -Wl,-Bstatic -Wl,-Bdynamic -lrt -ldl -Wl,--end-group -pthread -std=c++14)
   target_compile_options(client_test-armeabi-v7a PRIVATE -pthread -std=c++14)
   target_link_options(client_test-armeabi-v7a PRIVATE -static-libstdc++)
else()
	message("no target os is specified")
endif()

### target_compile_options do not link library

### rm -rf build/
### cmake -B build -Dlinux-amd64=on
### cmake -B build -Darm64-v8a=on
### cmake --build build -j $(nproc)
