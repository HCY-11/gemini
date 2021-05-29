#include "app.h"

int main(int argc, char** argv)
{
    App app;

    app.init("App", 800, 600);

    app.loop();

    app.cleanUp();
}
