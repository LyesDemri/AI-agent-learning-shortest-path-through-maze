clear;clc;close all;
%This program shows the best direction the agent should head to for each
%point in the maze. After the agent has learned, the directions point
%provide the shortest way out of the maze

load('Q_table.mat');
load('maze.mat');

directions='ULDR';
for l=1:length(Q)
    L=floor((l-1)/10)+1;
    C=mod(l-1,10)+1;
    if maze(L,C)~='#'
        [osef,action]=max(Q(l,:));
        maze(L,C)=directions(action);
    end
end

disp(maze)