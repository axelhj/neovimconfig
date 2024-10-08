@echo OFF 2> NUL

REM To invoke with Alacritty and update plugins from a batch[.bat]-file:
REM START alacritty --command cmd /c ^"%LOCALAPPDATA%\nvim\build.bat^" ^& ^"nvim --headless \"+Lazy! update\" +qa^"

echo.
echo ########## build neovim for Windows ##########
:pacman -S mingw-w64-x86_64-{gcc,cmake,make,ninja,diffutils} &: On MSYS2 console, for reference
if "%~1" == "" (set neovim_root=%USERPROFILE%\code\neovim) else (set neovim_root=%1)
if "%~2" == "" (set fetch_depth=10) else (set fetch_depth=%2)
if "%~3" == "" (set msys2_loc=c:\msys64\mingw64\bin;c:\msys64\usr\bin) else (set msys2_loc=%3)
if "%~4" == "" (set install_loc="C:\Program Files\Neovim") else (set install_loc=%4)
if "%~5" == "" (set clean_build=) else (set clean_build=%5)
echo arg 1 neovim_root               %neovim_root%
echo arg 2 fetch_depth               %fetch_depth%
echo arg 3 msys2_loc                 %msys2_loc%
echo arg 4 install_loc               %install_loc%
echo arg 5 clean_build (empty == no) %clean_build%
set oldcwd=%cd%
cd %neovim_root%
set PATH=%msys2_loc%;%PATH%
echo.
echo ########## GIT FETCH                ##########
git fetch --depth=%fetch_depth% origin master&&git reset --hard origin/master
echo.
if defined clean_build (echo ########## CLEAN BUILD              ##########&rmdir /s /q .\.deps .\install .\build) else (echo ########## NOT CLEAN BUILD          ##########)
echo.
echo ########## .deps GENERATE           ##########
cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=RelWithDebInfo
echo.
echo ########## .deps BUILD              ##########
cmake --build .deps --parallel
echo.
echo ########## nvim GENERATE            ##########
cmake -B build -G Ninja -D CMAKE_INSTALL_PREFIX=%install_loc% -D CMAKE_BUILD_TYPE=RelWithDebInfo
echo.
echo ########## nvim BUILD               ##########
cmake --build build --parallel
echo.
echo ########## install nvim UAC INSTALL ##########
powershell -c Start-Process cmd.exe -Verb runAs -Wait -ArgumentList '/C','"cd %neovim_root%&set PATH=%msys2_loc%;%PATH%&ninja -C build install"'
cd %oldcwd%
echo.
echo ########## BUILD ^& INSTALL COMPLETE ##########
@echo ON 2> NUL
