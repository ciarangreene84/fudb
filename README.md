# FuDB (F.U. DataBase, pronounced 'Fuddbah!')

This repo contains a series of SQL scripts aimed at better understanding an unknown database.

## Setup

1. Clone/download this repo.
2. Update the 'SetupFuDB.bat' file to reference a database you want to understand.
3. Run the setup batch file.
4. Perform tests on your target system.
5. View the MasterSequenceRecords

### Problem

Abstraction and decoupling are great. A high level developer (e.g. UI, business logic) shouldn't care about how the data is stored. Reality is, in... some... systems, a developer needs to understand the entire stack. 

The problem is that understanding *precisely* what's happening in the database can be very difficult.

### Solution

The solution is to enable complete auditing of the database and run test cases. The scripts in this repo setup insert, update and delete triggers on all the tables of a specified database. A developer can then run test cases and see whats happening. 

### Disclaimer

This is for testing *only*. Feel free to use it, change it, play with it. If you figure out something good, let me know. *But* be ware that this could potentially break your systems in weird ways. Be careful about drawing conclusions from the results of using this. Talk to your DBA. #dbaLove 
