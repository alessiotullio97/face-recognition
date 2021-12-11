clc
clear all
close all
prompt="What's your name?";
%dialog box ask your name and get your answer
answer = inputdlg(prompt)
num = 10;
n=string(num);
%dialog box showing your name taken
f = msgbox("Welcome " +answer{1}+ "! Now I will take" +n+ " snapshots.");

defaultDB = '/database';
currentDir = pwd();
dbPath = strcat(currentDir, defaultDB);

[success] = takeSnapshots(answer{1}, dbPath,num);
