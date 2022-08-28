VERSION=$1

sudo apt-get install -y \
    pkg-config \
    git \
    subversion \
    curl \
    wget \
    build-essential \
    python \
    xz-utils \
    zip

git config --global user.name "V8 Android Builder"
git config --global user.email "v8.android.builder@localhost"
git config --global core.autocrlf false
git config --global core.filemode false
git config --global color.ui true


cd ~
echo "=====[ Getting Depot Tools ]====="	
git clone -q https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools:$PATH
gclient


mkdir v8
cd v8

echo "=====[ Fetching V8 ]====="
fetch v8
echo "target_os = ['android']" >> .gclient
cd ~/v8/v8
git checkout $VERSION
# ./build/install-build-deps-android.sh
gclient sync



#######

alias gm=/path/to/v8/tools/dev/gm.py
gm android_arm64.release

#######


# echo "=====[ Building V8 ]====="
# python ./tools/dev/v8gen.py arm64.release -vv -- '
# target_os = "android"
# target_cpu = "arm64"
# v8_target_cpu = "arm64"
# is_component_build = false
# '

# ninja -C out.gn/arm64.release d8


# ninja -C out.gn/arm64.release -t clean
# ninja -C out.gn/arm64.release v8_libplatform
# ninja -C out.gn/arm64.release v8
# cp ./third_party/android_ndk/sources/cxx-stl/llvm-libc++/libs/arm64-v8a/libc++_shared.so ./out.gn/arm64.release