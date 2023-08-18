# AssemblyHelloWorld
Simple testing project for assembly


[Microsoft Reference](https://learn.microsoft.com/en-us/cpp/assembler/masm/microsoft-macro-assembler-reference?view=msvc-170)


## [Windows 10] Using C/C++ project in VS2022 

 - Add a .asm file into source files
 - Right click the project and go to Build Dependencies->Build Customizations..., check the masm (.targets, .props) checkbox
 - Right click the .asm file and go to Properties, set the Item Type to Microsoft Macro Assembler
 - Project properties: Linker->System Enable Large Addresses=No
 - Project properties: Linker->Advanced Entry Point="main"

## Using Command Line

 - Open *x64 Native Tools Command Prompt for VS 2022*
 - Note this is not the same as the *Developer Command Prompt for VS 2022* or *Developer Power Shell for VS 2022*!
 - cd into the source directory and run the following command to generate helloWorld.exe
	```
	ml64 hello.asm /link /subsystem:console /entry:main
	```
