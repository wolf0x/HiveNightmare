# HiveNightmare

CVE-2021–36934， Exploit allowing you to read any registry hives as non-admin.

**What is this?**

An zero day exploit for HiveNightmare, which allows you to retrieve all registry hives in Windows 10 as a non-administrator user. For example, this includes hashes in SAM, which can be used to execute code as SYSTEM.

**Scope**

Works on all supported versions of Windows 10, where System Protection is enabled (should be enabled by default in most configurations).

**How does this work?**

The permissions on key registry hives are set to allow all non-admin users to read the files by default, in most Windows 10 configurations. This is an error.

**What does the exploit do?**

Allows you to read SAM data (sensitive) in Windows 10, as well as the SYSTEM and SECURITY hives.

This exploit uses VSC to extract the SAM, SYSTEM, and SECURITY hives even when in use, and saves them in current directory as HIVENAME, for use with whatever cracking tools, or whatever, you want.

**Usage**

PS > HiveNightmare
Saves the files in current run location of the payload.

PS > HiveNightmare -Dest C:\temp

Saves the files in C:\temp.

![image](https://user-images.githubusercontent.com/15625431/126903397-a758f333-2639-4618-a508-3351b02c5dfd.png)



**Pulling Credentials out**

python3 secretsdump.py -sam SAM -system SYSTEM -security SECURITY LOCAL
![image](https://user-images.githubusercontent.com/15625431/126903381-c8df7730-69f8-42d0-94c0-a87a7933af19.png)

