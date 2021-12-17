clc
clear all
close all

%% Registration Phase
%res = betaRegisterClient();
res = 0;
if (res < 0)
        msgbox(['An error occured while registering, try running the' ...
                ' app again']);
        return;
end

%% Training and Testing Phase
[res, trainingFeatures, trainingLabel] = ttSystem();
if (res < 0)
        msgbox(['An error occured while Training and Testing the System,' ...
                ' try running the app again']);
        return;
end


%% Identify the Client
res = identifyClient(trainingFeatures, trainingLabel);
if (res < 0)
        msgbox(['An error occurew while Identifying the person']);
        return;
end

disp("The App ended correctly. Bye!");

