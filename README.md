# AssemblyHelloWorld
Simple testing project for assembly


[Microsoft Reference](https://learn.microsoft.com/en-us/cpp/assembler/masm/microsoft-macro-assembler-reference?view=msvc-170)


## [Windows 10] Using C/C++ project in VS2022 

 - Add a .asm file into source files
 - Right click the project and go to Build Dependencies->Build Customizations..., check the masm (.targets, .props) checkbox
 - Right click the .asm file and go to Properties, set the Item Type to Microsoft Macro Assembler
 - Project properties: Linker->System Enable Large Addresses=No
 - Project properties: Linker->Advanced Entry Point="main"

## [Windows 10] Using Command Line

 - Open *x64 Native Tools Command Prompt for VS 2022*
 - Note this is not the same as the *Developer Command Prompt for VS 2022* or *Developer Power Shell for VS 2022*!
 - cd into the source directory and run the following command to generate helloWorld.exe
	```
	ml64 helloWorld.asm /link /subsystem:console /entry:main
	```

# Getting Rid of Dependencies

## hello1.asm

Is a minimal Hello World in x64 MASM (no library includes), but needs to be linked against kernel32.lib during the link part of the build.

```
ml64 hello1.asm /c /Zi
```

```
link hello.obj kernel32.lib /subsystem:console /entry:main /debug
```

### hello2.asm

MASM x64 "Hello World" via direct syscalls (no imports)