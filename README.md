# AssemblyHelloWorld
Simple testing project for assembly

## Using C/C++ project in VS2022

 - Add a .asm file into source files
 - Right click the project and go to Build Dependencies->Build Customizations..., check the masm (.targets, .props) checkbox
 - Right click the .asm file and go to Properties, set the Item Type to Microsoft Macro Assembler
 - Project properties: Linker->System Enable Large Addresses=No
 - Project properties: Linker->Advanced Entry Point="main"