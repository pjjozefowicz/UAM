#include "../main.h"

using namespace std;

int main()
{
	    CPrinter printer;
        printer.setDebugLevel(4);

        MSG_PRINT("msg");
        DBG_PRINT("msg");
        WRN_PRINT("msg");
        ERR_PRINT("msg");

        printMessage("Hello makefiles");
        return 0;
}
