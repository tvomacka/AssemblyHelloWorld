# AssemblyHelloWorld
Once, this was meant to be a simple testing project for assembly, but suddenly it grew to be a collection of various small learning samples. This includes working with command line, memory allocation, and various simple algorithms. See the TODOs to see what's planned next.

_Disclaimer: This repo will probably stay in a very unorganized manner. It is not meant to have great (or any, for that matter) PR culture, tests, or fancy commit notations. It is here for one purpose - to learn assembly._

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

## barebones.asm

MASM x64 "Hello World" via direct syscalls (no imports).

```
ml64 barebones.asm /link /entry:start /subsystem:console
```

Currently builds and runs, but outputs nothing, the problem is most probably with having incorrect stdout handle for the OS version. Will have to investigate.

# I/O

## printNum.asm

Outputs a number to console as a text, manually converting the number to a string.

Includes memory allocation on heap for the converted string value.

# Working with Command Line

## clargs.asm

Reads the command line arguments and writes them to the console output.

# TODO:

 - refine the clargs sample so that we essentially get the argc/argv structure known from C
 - numeric parsing
 - number output to console (int to str)
 - command line argument parsing
 - learn about argument parsing, stack and instruction pointers
 - learn about shellcode
 - Rabin-Karp algorithm
 
