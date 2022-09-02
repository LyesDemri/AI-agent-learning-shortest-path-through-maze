clear;clc;close all;

%In this simulation, the agent must find the key before heading towards the
%exit, but it doesn't know when it has found the key
%Since it doesn't know when it's found the key, it never understands what
%it's supposed to do and ends up finding the key and then the exit at
%random

maze=['# ########';
      '#        #';
      '# ### ## #';
      '# #    # #';
      '# # #  # #';
      '#   #  # #';
      '#####  #K#';
      '#      ###';
      '#        #';
      '######## #'];
  
position = [1,2];
got_key=false;


alpha=1;
gamma=1;
%Initialization of the Q-Table
Q=zeros(size(maze,1)*size(maze,2),4);
%the lines represent the agent's possible positions, in the order
%(1,1), (1,2), (1,3), ... , (1,10), (2,1), (2,2),...
won=false;

for i=1:20
    disp(['partie ' num2str(i)]);
    position=[1,2];
    got_key=false;
    maze(7,9)='K';
    won = false;
    while won==false
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

        if key==1
            if position(1)>1
                if maze(position(1)-1,position(2))==' '
                    position(1)=position(1)-1;
                    R=-1;
                elseif maze(position(1)-1,position(2))=='K'
                    position(1)=position(1)-1;
                    got_key=true;
                    maze(position(1),position(2))=' ';
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
            end
        elseif key==2
            if position(2)>1
                if maze(position(1),position(2)-1)==' '
                    position(2)=position(2)-1;
                    R=-1;
                elseif maze(position(1),position(2)-1)=='K'
                    position(2)=position(2)-1;
                    got_key=true;
                    maze(position(1),position(2))=' ';
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
            end
        elseif key==3
            if position(1)<size(maze,1)
                if maze(position(1)+1,position(2))==' '
                    position(1)=position(1)+1;
                    R=-1;
                elseif maze(position(1)+1,position(2))=='K'
                    position(1)=position(1)+1;
                    got_key=true;
                    maze(position(1),position(2))=' ';
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
            end
        elseif key==4
            if position(2)<size(maze,2)
                if maze(position(1),position(2)+1)==' '
                    position(2)=position(2)+1;
                    R=-1;
                elseif maze(position(1),position(2)+1)=='K'
                    position(2)=position(2)+1;
                    got_key=true;
                    maze(position(1),position(2))=' ';
                    R=-1;
                else
                    R=-100;
                end
            else
                R=-100;
            end
        end


        if position(1)==10 && position(2)==9 && got_key==true
            disp('The agent found the exit');
            R=100000;
            won=true;
            break;
        end

        %Bellman's equation
        new_l=(position(1)-1)*10+(position(2));
        newR=max(Q(new_l,:));
        Q(l,key)=Q(l,key)+alpha*(R+gamma*newR-Q(l,key));
        %disp(Q(l,:));

        pause(0.03);
    end
end

disp('Training over!')
save('Q_table_key.mat','Q');