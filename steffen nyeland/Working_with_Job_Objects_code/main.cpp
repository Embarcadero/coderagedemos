#include <iostream>
#include <tchar.h>
#include <windows.h>

int _tmain(int argc, _TCHAR* argv[])
{
    for (int i = 0; i < 10; i++) {
        std::cerr << "Another mystic error from the C++ child process..." << std::endl;
        Sleep(1500);
    }
}
