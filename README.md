# automataFinalTermProject

This project is about using specific application of automata in
verification

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

#### Resources
1. cygwin32
2. spin
3. C-compiler and C-preprocessor
4. iSpin GUI (recommended)
5. ActiveTcl
6. graphviz-2.38 (recommended)

#### Knowledge
1. be familiar with automata
2. know to code with promela model language

### Installation

#### Installation step: spin version 6.4.7

1. Install cygwin32
- step 1: install cygwin32 using setup-x86.exe file
- step 2: after 5 next steps, select first site and click next
- step 3: after 6 next steps, "Select Packages" window opened, install all necessary packages for spin: bison(devel), yacc(devel), gcc-core: GNU Compiler Collection, gcc-g++: GNU Compiler Collection, libgcc1, gdb: The GNU Debugger, make: The GNU version of the 'make' utility, WindowMaker: GNUstep window manager
- step 4: create new search path to bin folder of cygwin32

2. Install spin
- step 1: in pc_spin647, copy spin.exe to bin folder of cygwin32

3. Install C-compiler and C-preprocessor
- not needed if you have followed all above steps
- needed to run model checker generated by spin
- (recommended): GNU gcc compiler
- can be installed using cygwin32 setup above.
- after step 3, it's done if you don't want to use graphical user interface
4. Install iSpin - graphical user interface for spin
- step 1: in pc_spin647, copy ispin.tcl to any where you plan to work (recommended C:\Program Files (x86) folder)
- step 2: to start ispin, you need Tcl/Tk programming language

5. Install ActiveTcl: one distribution of Tcl PL
- step 1: in Final, open ActiveTcl*.exe
- step 2: following step to insatll ActiveTcl
- now ispin.tcl will be recognized by system as wish file, so that ispin starts when you double click the ispin*.tcl file
- open ispin.tcl using wish command line: 
-- cd "ispin directory" (cd "C:\Program Files (x86)\pc_spin647" for example)
-- wish -f ispin.tcl

6. Install graphviz-2.38 for automata view
- Since the setup.exe file is about 34 mb, so you need to go on google and download it yourself

7. Configure ispin
- open ispin.tcl using any text editor
- in line 20: change set GCC gcc to set GCC "C:/cygwin/bin/gcc.exe"
- in line 21: change set DOT dot to set DOT "C:/Program Files (x86)/Graphviz2.38/bin/dot.exe

8. Create search path: to 
- C:\Program Files (x86)\Graphviz2.38\bin
- C:\cygwin64\bin
- C:\ActiveTcl\bin

9. Use ispin
- open ispin by double click on its icon, open promela (.pml) file and use it to check model
- if error was thrown, try opening ispin using command line as indicated above.s

#### Installation problems

1. Problem 1: gcc, ispin is not recognized as internal command
Solution:
- create search path

2. Problem 2: gcc-3, gcc-4 not recognized as internal command.
Solution:
- create gcc-3.exe, gcc-4.exe using gcc.exe in cygwin/bin/gcc.exe by using copy, paste
- open ispin.tcl using an text editor
- in line 26, 27: change gcc-3, gcc-4 to gcc

3. Problem 3: ,delete cygwin from pc
Solution: following the below steps:
- open cmd as administrator
- using commands:
-- command 1: takeown /f "c:\cygwin" /r /d Y
-- command 2: icacls "c:\cygwin" /T /Q /C /reset
-- command 3: rd "c:\cygwin" /s /q

## Running the tests - Example
  
1. With finalTermProject: simulate this program with arbitrary seed (123, 10000 time step by default), we can see that there are no deadlock encountered during run process. But it just a guess. Now go to step 2
command: spin -p -s -r -X -v -n123 -l -g -u10000 finalTermProject.pml
2. Check for invalid endstates and run, the result should be : No errors found. So no pan.trail have been created so far
command:
-> spin -a finalTermProject.pml
-> gcc -o pan pan.c
-> ./pan
3. Now change program a little bit, my modified version is available in modifiedFinalTermProject.pml
4. Do the same thing and the result should be: 
- pan:1: invalid end state (at depth 1)
- pan: wrote modifiedFinalTermProject.pml.trail
- State-vector 16 byte, depth reached 2, errors: 1
-         3 states, stored
-         0 states, matched
-         3 transitions (= stored+matched)
-         0 atomic steps
- hash conflicts:         0 (resolved)
- -> it says that deadlock occured and the error is writed to modifiedFinalTermProject.trail
- -> simulate program: we can see with 10000 steps, it stop at second step:
- 
-   0:	proc  - (:root:) creates proc  0 (A)
-   0:	proc  - (:root:) creates proc  1 (B)
-   1:	proc  0 (A:1) modifiedFinalTermProject.pml:7 (state 1)	[b0 = 1]
-  2:	proc  1 (B:1) modifiedFinalTermProject.pml:14 (state 1)	[b1 = 1]
timeout
 '#processes: 2'
  2:	proc  1 (B:1) modifiedFinalTermProject.pml:15 (state 2)
  2:	proc  0 (A:1) modifiedFinalTermProject.pml:8 (state 2)
2 processes created

--> Because there are a deadlock at state (t0, t1)

## Deployment

#### Process

1. systemModel.pml->(spin)->model checker in c file, simulation

#### Verification

1. Using promela (process meta language) to model a system in C script-liked language. My example model is of a concurrent program from page 164, section 8.3 in Automata theory, an algorithmic approach of Javier Esparza

2. Open file finalTermProject.pml
- using ispin: open file like normal explorer
- using cygwin terminal: cd "finalTermProject.pml directory"

3. Check syntax and redundancy (only available on GUI ispin)
- click on to icon "Syntax Check" and "Redundancy Check"

4. take a overlook at this program by using simulator
- using ispin: open second tab, choose appropriate properties and click Run
- using cygwin termial: input command
-- spin -[properties] [filename with extension]
-- properties: p, g, l, r, s (check spinroot.com for additional information)
-- filename: finalTermProject.pml

5. create analyzer and verify this program
-- using ispin: open third tab, choose appropriate properties and click Run.
-- using cygwin terminal: input command:
-- generate a verifier: spin -a [filename with estension]: it will create 6 C files,  named pan.[cbhpmt]
-- compile file pan.c to produce analyzer (.exe file): gcc -o pan pan.c
-- execute the analyzer to produce analyses: ./pan -[properties] or just use ./pan for default print
-- if error occurs in program: like assertion violation, unspecified reception or encountered deadlock: it will generate a pan.trail file. To invoke pan.trail file, input command: spin -t finalTermProject.pml

## Built With

* Cao Tan Minh
* Ho Sy Thanh

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

version 1.0

## Authors

Name: Loi Nguyen Van
Email: war0342000@gmail.com
Email: lloydNguyenVance@gmail.com

See also the list of [contributors](https://github.com/warcraft034/automataFinalTermProject/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc