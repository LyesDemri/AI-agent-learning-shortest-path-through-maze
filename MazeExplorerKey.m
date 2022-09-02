clear;clc;close all;

%In this version of the maze, the player has to find a key denoted as 'K'
%before he/she heads towards the exit

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
while 1
  clc;
  screen=maze;
  screen(position(1),position(2))='o';
  disp(screen)

  key=input('Where do you want to go? (w a s d then enter)?','s');
  if key=='w'
      if position(1)>1
          if maze(position(1)-1,position(2))==' '
              position(1)=position(1)-1;
          elseif maze(position(1)-1,position(2))=='K'
              position(1)=position(1)-1;
              got_key=true;
              maze(position(1),position(2))=' ';
          end
      end
  elseif key=='a'
      if position(2)>1
          if maze(position(1),position(2)-1)==' '
              position(2)=position(2)-1;
          elseif maze(position(1),position(2)-1)=='K'
              position(2)=position(2)-1;
              got_key=true;
              maze(position(1),position(2))=' ';
          end
      end
  elseif key=='s'
      if position(1)<size(maze,1)
          if maze(position(1)+1,position(2))==' '
              position(1)=position(1)+1;
          elseif maze(position(1)+1,position(2))=='K'
              position(1)=position(1)+1;
              got_key=true;
              maze(position(1),position(2))=' ';
          end
      end
  elseif key=='d'
      if position(2)<size(maze,2)
          if maze(position(1),position(2)+1)==' '
              position(2)=position(2)+1;
          elseif maze(position(1),position(2)+1)=='K'
              position(2)=position(2)+1;
              got_key=true;
              maze(position(1),position(2))=' ';
          end
      end
  end

  if position(1)==10 && position(2)==9 && got_key==true
      disp('HURRAY!');
      break;
  end

end