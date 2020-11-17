%Made by Nicolas Testard if there is any question
%first: a cell contains the positions and orientation (6 dof) for the 17 segments
%second: unknown use of the value

fclose("all");
file=fopen('slowArm.drf');
ind_time=1;
char='azerty';
while ~isempty(char)
    char=fread(file,1, 'uint8=>char');
    if char=='t'
        char2=fread(file,1, 'uint8=>char');
        if char2=='s'
            %% Time
            char3=fread(file,1, 'uint8=>char');
            time='';
            while (char3 ~='d')
                time=strcat(time,char3);
                char3=fread(file,1, 'uint8=>char');
            end
            time=time(1:end-1);
            Time(ind_time)=str2double(time);

            
            %% First and second segment vectors
            ind_segment=1;
            pos1=zeros(17,6);
            pos2=zeros(17,9);
            while ind_segment<=17
                ind=0;
                while ind<2
                    char3=fread(file,1, 'uint8=>char');
                    if char3=='['
                        ind=ind+1;
                    end
                end
                
                %first
                vec=zeros(1,6);
                for ind_vec=1:6
                    char3=fread(file,1, 'uint8=>char');
                    val='';
                    while (char3~=' ')&&(char3~=']')
                        val=strcat(val,char3);
                        char3=fread(file,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos1(ind_segment,:)=vec;
                
                fread(file,1, 'uint8=>char');%skip '['
                
                %second
                vec=zeros(1,9);
                for ind_vec=1:9
                    char3=fread(file,1, 'uint8=>char');
                    val='';
                    while (char3~=' ')&&(char3~=']')
                        val=strcat(val,char3);
                        char3=fread(file,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos2(ind_segment,:)=vec;
                ind_segment=ind_segment+1;
            end
            first{ind_time}=pos1;
            second{ind_time}=pos2;
            ind_time=ind_time+1;
        else
        char=char2;
        end               
    end
end

fclose("all");

clear char char2 char3 ind ind_segment ind_time pos1 pos2 time val vec file ind_vec