clear;clc;close all;

%This is just a simple maze just to get the hang of how to program a maze
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
  
  while 1
      clc;
      screen=maze;
      screen(position(1),position(2))='o';
      disp(screen)

      key=input('where do you want to go? (w a s d then hit enter)?','s');
      if key=='w'
          if position(1)>1
              if maze(position(1)-1,position(2))==' '
                  position(1)=position(1)-1;
              end
          end
      elseif key=='a'
          if position(2)>1
              if maze(position(1),position(2)-1)==' '
                  position(2)=position(2)-1;
              end
          end
      elseif key=='s'
          if position(1)<size(maze,1)
              if maze(position(1)+1,position(2))==' '
                  position(1)=position(1)+1;
              end
          end
      elseif key=='d'
          if position(2)<size(maze,2)
              if maze(position(1),position(2)+1)==' '
                  position(2)=position(2)+1;
              end
          end
      end
      
      if position(1)==10 && position(2)==9
          disp('HURRAY!');
          break;
      end

  end