# Install C compiler, cmake, ninja, curl and gettext with brew or other method
fetch_depth=1
install_prefix=~/nvim/nvim-macos-arm64
build_type=RelWithDebInfo
git fetch --depth=$fetch_depth origin master&&git reset --hard origin/master
cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=$build_type
cmake --build .deps --parallel
cmake -B build -G Ninja -D CMAKE_INSTALL_PREFIX=$install_prefix -D CMAKE_BUILD_TYPE=$build_type
cmake --build build --parallel
ninja -C build install
