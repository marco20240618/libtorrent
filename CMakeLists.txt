cmake_minimum_required(VERSION 3.16.0)

project(project1)

file(GLOB src src/*.cpp src/ed25519/*.cpp src/kademlia/*.cpp src/pe_crypto.cpp)

set(torrent_compile_options -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden -Wno-noexcept-type -Wall -Wextra -Wno-format-zero-length -Wpedantic -Wvla -DBOOST_ALL_NO_LIB -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_ASIO_HAS_STD_CHRONO -DBOOST_ASIO_NO_DEPRECATED -DBOOST_MULTI_INDEX_DISABLE_SERIALIZATION -DBOOST_NO_DEPRECATED -DBOOST_SYSTEM_NO_DEPRECATED -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_BUILDING_LIBRARY -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -D_FILE_OFFSET_BITS=64 -c)

set(try_signal_compile_options -ftemplate-depth-512 -std=c++14 -fvisibility-inlines-hidden -pthread -O3 -finline-functions -Wno-inline -Wall -fvisibility=hidden  -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -c)

set(include_directories boost/include openssl/include deps/try_signal include include/libtorrent)

set(try_signal_src deps/try_signal/signal_error_code.cpp deps/try_signal/try_signal.cpp)

set(client_test_src examples/client_test.cpp examples/print.cpp examples/torrent_view.cpp examples/session_view.cpp)

set(client_test_compile_options -pthread -std=c++14)

set(client_test_link_options -static-libstdc++)

if (linux-amd64)
   set(CMAKE_CXX_COMPILER /usr/bin/g++)
   set(target linux-amd64)
   set(client_test_link_libraries ${CMAKE_SOURCE_DIR}/boost/${target}/libboost_system.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libssl.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libcrypto.a)
elseif (arm64-v8a)
   set(CMAKE_CXX_COMPILER /usr/local/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android26-clang++)
   set(target arm64-v8a)
   set(client_test_link_libraries ${CMAKE_SOURCE_DIR}/boost/${target}/libboost_system.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libssl.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libcrypto.a)
elseif (armeabi-v7a)
   set(CMAKE_CXX_COMPILER /usr/local/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi26-clang++)
   set(target armeabi-v7a)
   set(client_test_link_libraries ${CMAKE_SOURCE_DIR}/boost/${target}/libboost_system.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libssl.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libcrypto.a)
elseif (x86_64)
   set(CMAKE_CXX_COMPILER /usr/local/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android26-clang++)
   set(target x86_64)
   set(client_test_link_libraries ${CMAKE_SOURCE_DIR}/boost/${target}/libboost_system.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libssl.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libcrypto.a)
elseif (x86)
   set(CMAKE_CXX_COMPILER /usr/local/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android26-clang++)
   set(target x86)
   set(client_test_link_libraries ${CMAKE_SOURCE_DIR}/boost/${target}/libboost_system.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libssl.a ${CMAKE_SOURCE_DIR}/openssl/${target}/libcrypto.a)
elseif (windows-amd64)
   set(target windows-amd64)

   set(torrent_compile_options /Zm800 -nologo -c -TP /wd4675 /EHs /std:c++14 /GR /Zc:throwingNew /O2 /Ob2 /W4 /MD /Zc:forScope /Zc:wchar_t /Zc:inline /Gw /favor:blend /Zc:__cplusplus /bigobj /permissive- /utf-8 /wd4251 /wd4268 /wd4275 /wd4373 /wd4503 -DBOOST_ALL_NO_LIB -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_ASIO_HAS_STD_CHRONO -DBOOST_ASIO_NO_DEPRECATED -DBOOST_COBALT_USE_STD_PMR=1 -DBOOST_MULTI_INDEX_DISABLE_SERIALIZATION -DBOOST_NO_DEPRECATED -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_SYSTEM_STATIC_LINK=1 -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_BUILDING_LIBRARY -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CRT_SECURE_NO_DEPRECATE -D_SCL_SECURE_NO_DEPRECATE -D_WIN32 -D_WIN32_WINNT=0x0A00 -D__USE_W32_SOCKETS)
   
   set(try_signal_compile_options /Zm800 -nologo -c -TP /wd4675 /EHs /std:c++14 /GR /Zc:throwingNew /O2 /Ob2 /W4 /MD /Zc:forScope /Zc:wchar_t /Zc:inline /Gw /favor:blend /Zc:__cplusplus -DBOOST_COBALT_USE_STD_PMR=1 -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL)

   set(client_test_compile_options /Zm800 -nologo -TP /wd4675 /EHs /std:c++14 /GR /Zc:throwingNew /O2 /Ob2 /W4 /MD /Zc:forScope /Zc:wchar_t /Zc:inline /Gw /favor:blend /wd4251 /wd4268 /wd4275 /wd4373 /wd4503 -DBOOST_ALL_NO_LIB -DBOOST_ASIO_ENABLE_CANCELIO -DBOOST_ASIO_HAS_STD_CHRONO -DBOOST_ASIO_NO_DEPRECATED -DBOOST_COBALT_USE_STD_PMR=1 -DBOOST_MULTI_INDEX_DISABLE_SERIALIZATION -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_SYSTEM_STATIC_LINK=1 -DNDEBUG -DOPENSSL_NO_SSL2 -DTORRENT_SSL_PEERS -DTORRENT_USE_I2P=1 -DTORRENT_USE_LIBCRYPTO -DTORRENT_USE_OPENSSL -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CRT_SECURE_NO_DEPRECATE -D_SCL_SECURE_NO_DEPRECATE -D_WIN32 -D_WIN32_WINNT=0x0A00 -D__USE_W32_SOCKETS)

   set(client_test_link_options /NOLOGO /INCREMENTAL:NO /OPT:ICF=5 /OPT:REF /MACHINE:X64 /subsystem:console)

   unset(client_test_link_options)

   set(client_test_link_libraries ${CMAKE_SOURCE_DIR}/boost/windows-amd64/libboost_system-vc143-mt-x64-1_85.lib ${CMAKE_SOURCE_DIR}/openssl/windows-amd64/libcrypto.lib ${CMAKE_SOURCE_DIR}/openssl/windows-amd64/libssl.lib advapi32.lib bcrypt.lib user32.lib shell32.lib gdi32.lib crypt32.lib iphlpapi.lib ws2_32.lib wsock32.lib)
else()
	message("no target os is specified")
endif()

add_library(torrent-${target} STATIC ${src})
target_include_directories(torrent-${target} PRIVATE ${include_directories})
target_compile_options(torrent-${target} PRIVATE ${torrent_compile_options})

add_library(try_signal-${target} STATIC ${try_signal_src})
target_compile_options(try_signal-${target} PRIVATE ${try_signal_compile_options})

add_executable(client_test-${target} ${client_test_src})
target_include_directories(client_test-${target} PRIVATE ${include_directories})
target_link_libraries(client_test-${target} torrent-${target} try_signal-${target} ${client_test_link_libraries})
target_compile_options(client_test-${target} PRIVATE ${client_test_compile_options})
target_link_options(client_test-${target} PRIVATE ${client_test_link_options})

### target_compile_options do not link library

### rm -rf build/
### cmake -B build -Dlinux-amd64=on
### cmake -B build -Darm64-v8a=on
### cmake --build build -j $(nproc)
