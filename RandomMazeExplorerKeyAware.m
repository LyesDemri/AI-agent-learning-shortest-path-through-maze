clear;clc;close all;

%In this simulation, the agent knows when it's found the key, so let's see
%if it will find the most shortest path towards the key
%Result: it takes longer, but it does find the key and then the exit

%To avoid creating another file, I use the line R = 100 when the agent
%finds the key. Just comment/decomment it to activate or deactivate that
%characteristic of the environment. This is to check whether the agent will
%converge faster if we reward it for finding the key (and obviously yes it
%does).

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
Q=zeros(size(maze,1)*size(maze,2)*2,4);
%The lines represent the agent's possible positions, in order:
%(1,1,0), (1,2,0), (1,3,0), ... , (1,10,0), (2,1,0), (2,2,0),...
%(10,10,0), (1,1,1), (1,2,1), ...
won=false;

for i=1:50
    disp(['partie ' num2str(i)]);
    position=[1,2]; %put the agent back to square 1
    got_key=false;  %take its key away
    maze(7,9)='K';  %put key back to its place
    won = false;
    steps=0;
    while won==false
        clc;
        screen=maze;
        screen(position(1),position(2))='o';
        disp(screen)
        disp(['partie ' num2str(i)]);

        %Choose an action
        %To choose an action we must read the line in the Q-Table that
        %corresponds to the agent's current position
        l=(position(1)-1)*10+(position(2))+double(got_key)*100;
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
        steps=steps+1;


        if position(1)==10 && position(2)==9 && got_key==true
            disp('The agent found the exit');
            R=100000;
            won=true;
        end

        %Bellman equation
        new_l=(position(1)-1)*10+(position(2))+double(got_key)*100;
        newR=max(Q(new_l,:));
        Q(l,key)=Q(l,key)+alpha*(R+gamma*newR-Q(l,key));

        pause(0.03);
    end
    num_steps(i)=steps;
end

disp('Training over!')
save('Q_table_key.mat','Q');
plot(num_steps)