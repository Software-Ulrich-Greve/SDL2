@ECHO OFF
ECHO Running Install-Folder-Structure.bat . . .

if exist .\Temp  RMDIR .\Temp  /s /q
if exist .\gnu-mingw RMDIR .\gnu-mingw /s /q
if exist .\msvc  RMDIR .\msvc  /s /q
if exist .\.git  RMDIR .\.git  /s /q
if exist .\target  RMDIR .\target  /s /q
if exist .\src  RMDIR .\src  /s /q

if exist .gitattributes del .gitattributes
if exist .gitignore del .gitignore
if exist build.rs del build.rs
if exist Cargo.lock del Cargo.lock
if exist Cargo.toml del Cargo.toml
if exist LICENSE del LICENSE
if exist SDL2.dll del SDL2.dll

MD gnu-mingw
MD msvc
MD Temp
CD gnu-mingw
MD dll
MD lib
CD dll
MD 32
MD 64
CD..
CD lib
MD 32
MD 64
CD..
CD..
CD msvc
MD dll
MD lib
CD dll
MD 32
MD 64
CD..
CD lib
MD 32
MD 64
CD..
CD..

POWERSHELL -ExecutionPolicy Bypass -File .\_Installation\Un-Zip-Files.ps1

xcopy .\Temp\SDL2-devel-2.0.22-mingw\SDL2-2.0.22\i686-w64-mingw32\bin\*.* .\gnu-mingw\dll\32
xcopy .\Temp\SDL2-devel-2.0.22-mingw\SDL2-2.0.22\x86_64-w64-mingw32\bin\*.* .\gnu-mingw\dll\64
xcopy .\Temp\SDL2-devel-2.0.22-mingw\SDL2-2.0.22\i686-w64-mingw32\lib\*.* .\gnu-mingw\lib\32
xcopy .\Temp\SDL2-devel-2.0.22-mingw\SDL2-2.0.22\x86_64-w64-mingw32\lib\*.* .\gnu-mingw\lib\64
xcopy .\Temp\SDL2-devel-2.0.22-VC\SDL2-2.0.22\lib\x86\*.dll .\msvc\dll\32
xcopy .\Temp\SDL2-devel-2.0.22-VC\SDL2-2.0.22\lib\x64\*.dll .\msvc\dll\64
xcopy .\Temp\SDL2-devel-2.0.22-VC\SDL2-2.0.22\lib\x86\*.lib .\msvc\lib\32
xcopy .\Temp\SDL2-devel-2.0.22-VC\SDL2-2.0.22\lib\x64\*.lib .\msvc\lib\64

RMDIR .\Temp /s /q

cargo init

xcopy .\_Installation\.gitignore .\ /y
xcopy .\_Installation\Cargo.toml .\ /y
xcopy .\_Installation\build.rs .\ /y
xcopy .\_Installation\main.rs .\src\ /y

start Code.exe .\ && EXIT 0