set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CMAKE_SYSROOT /home/b32168/Work/toolchain/sysroot-glibc-linaro-2.23-2016.11-aarch64-linux-gnu)

set(tools /home/b32168/Work/toolchain/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu)
set(CMAKE_C_COMPILER ${tools}/bin/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/aarch64-linux-gnu-g++)
set(CMAKE_CXX_COMPILER ${tools}/bin/aarch64-linux-gnu-g++)
set(CMAKE_FIND_ROOT_PATH /home/b32168/Work/toolchain/sysroot-glibc-linaro-2.23-2016.11-aarch64-linux-gnu/lib)
#
#set(CMAKE_INSTALL_PREFIX:PATH /home/b32168/Work/fd.io/dpdk/dpdk_install/)
#set(CMAKE_ASM_COMPILER "${tools}/bin/aarch64-linux-gnu-gcc"  CACHE STRING FORCE)
#set(PYTHON_LIBRARIES   /usr/lib/python2.7/config-x86_64-linux-gnu/)
#set(PYTHON_INCLUDE_DIRS  /usr/include/python2.7/)
include_directories("/usr/include/python2.7")


set(OPENSSL_ROOT_DIR /home/b32168/Work/linaro/ext/openssl/installed/)
set(OPENSSL_LIBRARIES /home/b32168/Work/linaro/ext/openssl/installed/lib/)
set(OPENSSL_INCLUDE_DIR /home/b32168/Work/linaro/ext/openssl/installed/include/)
LINK_DIRECTORIES("/home/b32168/Work/linaro/ext/openssl/installed/lib")
link_directories("/home/b32168/Work/linaro/ext/openssl/installed/lib/libcrypto.so")
# search for programs in the build host directories (not necessary)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)


#set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by CMakeLists.txt." FORCE)
