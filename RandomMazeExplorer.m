clear;clc;close all;

%This program trains an agent to find the exit of a given maze.
maze=['# ########';
      '#        #';
      '# ### ## #';
      '# #    # #';
      '# # #  # #';
      '#   #  # #';
      '#####  # #';
      '#      ###';
      '#        #';
      '######## #'];
  
position = [1,2];

alpha=1;
gamma=1;
%Initialization of the Q-table
Q=zeros(size(maze,1)*size(maze,2),4);
%the lines represent the agent's possible positions, in the order
%(1,1), (1,2), (1,3), ... , (1,10), (2,1), (2,2),...

for i=1:20
    disp(['partie ' num2str(i)]);
    position=[1,2];
    won = false;
    while won==false
        %refresh screen
        clc;
        screen=maze;
        screen(position(1),position(2))='o';
        disp(screen)

        %Choose an action
        %To choose an action we must read the line in the Q-Table that
        %corresponds to the agent's current position
        l=(position(1)-1)*10+(position(2));
        %If all the values on the line are the same, no action is better
        %than any other so we should just make a random guess
        if mean(Q(l,:))==Q(l,1)
            key=randi(4);
        else
            %else, choose the best action
            [osef,key]=max(Q(l,:));
        end

        %move the agent
        if key==1
            disp('up')
            if position(1)>1
                if maze(position(1)-1,position(2))==' '
                    position(1)=position(1)-1;
                    R=-1;
                else
                    R=-100;
                end
            else
              %if we hit a wall, the punishment is 2 times worse
              R=-100;
            end
        elseif key==2
            disp('left')
            if position(2)>1
                if maze(position(1),position(2)-1)==' '
                    position(2)=position(2)-1;
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
            end
        elseif key==3
            disp('down')
            if position(1)<size(maze,1)
                if maze(position(1)+1,position(2))==' '
                    position(1)=position(1)+1;
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
          end
        elseif key==4
            disp('right')
            if position(2)<size(maze,2)
                if maze(position(1),position(2)+1)==' '
                    position(2)=position(2)+1;
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
            end
        end


        if position(1)==10 && position(2)==9
          disp('L''agent a trouvé la sortie');
          %Reward the agent
          R=10000;
          won=true;
        end
        
        %Bellman's equation
        new_l=(position(1)-1)*10+(position(2));
        newR=max(Q(new_l,:));
        Q(l,key)=Q(l,key)+alpha*(R+gamma*newR-Q(l,key));

        pause(0.03);
    end
end
disp('Training done!')
save('Q_table.mat','Q');