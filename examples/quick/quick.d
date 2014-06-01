module quick;

import ddl.DefaultRegistry;
import ddl.Linker;

import tango.io.Stdout;

void main(){
    auto linker = new Linker(new DefaultRegistry());
    linker.loadAndRegister("quick.map");

    auto plugin = linker.load("plugin.obj");
    linker.register(plugin);
    linker.link(plugin);

    auto helloWorld = plugin.getDExport!(char[] function(),"plugin.helloWorld")();

    Stdout(helloWorld());
    Stdout.newline;
}