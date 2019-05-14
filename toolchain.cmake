set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CMAKE_SYSROOT $ENV{CROSS_SYSROOT})

set(toolchain $ENV{CROSS_TOOLCHAIN})
set(CMAKE_C_COMPILER ${toolchain}/bin/$ENV{CROSS_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${toolchain}/bin/$ENV{CROSS_PREFIX}-g++)
set(CMAKE_FIND_ROOT_PATH $ENV{CROSS_SYSROOT}/lib)
#
set(CMAKE_PREFIX_PATH $ENV{DPDK_PATH})
include_directories("/usr/include/python2.7")


set(OPENSSL_ROOT_DIR $ENV{OPENSSL_PATH})
set(OPENSSL_LIBRARIES $ENV{OPENSSL_PATH}/lib/)
set(OPENSSL_INCLUDE_DIR $ENV{OPENSSL_PATH}/include/)
LINK_DIRECTORIES("$ENV{OPENSSL_PATH}/lib")
# search for programs in the build host directories (not necessary)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
#set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)


set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by CMakeLists.txt." FORCE)


#set(CMAKE_LIBRARY_PATH_FLAG <TODO>)
#set(CMAKE_ASM_COMPILER "${toolchain}/bin/aarch64-linux-gnu-gcc"  CACHE STRING FORCE)
#set(PYTHON_LIBRARIES   /usr/lib/python2.7/config-x86_64-linux-gnu/)
#set(PYTHON_INCLUDE_DIRS  /usr/include/python2.7/)
