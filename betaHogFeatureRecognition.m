clc
clear all
close all

prompt = "What's your name?\n";
name = input(prompt, 's');

n = 10;
disp(['Welcome [' name ']! Now I will take ' n ' snapshots.\n']);
pause(1);

defaultDB = '/database';
currentDir = pwd();
dbPath = strcat(currentDir, defaultDB);

[success] = takeSnapshots(name, dbPath, n);
