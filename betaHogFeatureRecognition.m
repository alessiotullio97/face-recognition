clc
clear all
close all
prompt = "What's your name?"

% dialog box ask your name and get your answer
answer = inputdlg(prompt)

% numeber of screeshots to be performed

num = 10

%dialog box showing your name taken
f = msgbox(['Welcome ' answer{1} '! Now I will take' num ' snapshots.'])

defaultDB = 'database'
currentDir = pwd()
dbPath = fullfile( currentDir, defaultDB);
[success] = takeSnapshots(answer{1}, dbPath, num)