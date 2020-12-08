%Made by Nicolas Testard if there is any question
%first: a cell contains the positions and orientation (6 dof) for the 17 segments
%second: unknown use of the value
%third: marker position and orientation
%fourth: unknown
clear
Motion="slowSit";
fclose("all");
file=fopen(Motion+".drf");
ind_time=1;
char='azerty';
while ~isempty(char)
    char=fread(file,1, 'uint8=>char');
    if char=='t'
        char=fread(file,1, 'uint8=>char');
        if char=='s'
            %% Time
            char=fread(file,1, 'uint8=>char');
            time='';
            while (char ~='d')
                time=strcat(time,char);
                char=fread(file,1, 'uint8=>char');
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
                    char=fread(file,1, 'uint8=>char');
                    if char=='['
                        ind=ind+1;
                    end
                end
                
                %first
                vec=zeros(1,6);
                for ind_vec=1:6
                    char=fread(file,1, 'uint8=>char');
                    val='';
                    while (char~=' ')&&(char~=']')
                        val=strcat(val,char);
                        char=fread(file,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos1(ind_segment,:)=vec;
                
                fread(file,1, 'uint8=>char');%skip '['
                
                %second
                vec=zeros(1,9);
                for ind_vec=1:9
                    char=fread(file,1, 'uint8=>char');
                    val='';
                    while (char~=' ')&&(char~=']')
                        val=strcat(val,char);
                        char=fread(file,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos2(ind_segment,:)=vec;
                ind_segment=ind_segment+1;
                
            end
            first{ind_time}=pos1;
            second{ind_time}=pos2;
            
            %% Third and fourth vectors
            ind_joint=1;
            while ind_joint<=20
                ind=0;
                if ind_joint==1
                    ind=-1;
                end
                while ind<2
                    char=fread(file,1, 'uint8=>char');
                    if char=='['
                        ind=ind+1;
                    end
                end
                
                %third
                vec=zeros(1,6);
                for ind_vec=1:6
                    char=fread(file,1, 'uint8=>char');
                    val='';
                    while (char~=' ')&&(char~=']')
                        val=strcat(val,char);
                        char=fread(file,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos1(ind_joint,:)=vec;
                
                fread(file,1, 'uint8=>char');%skip '['
                
                %fourth
                vec=zeros(1,9);
                for ind_vec=1:9
                    char=fread(file,1, 'uint8=>char');
                    val='';
                    while (char~=' ')&&(char~=']')
                        val=strcat(val,char);
                        char=fread(file,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos2(ind_joint,:)=vec;
                ind_joint=ind_joint+1;
            end
            third{ind_time}=pos1;
            fourth{ind_time}=pos2;
                
            ind_time=ind_time+1;
        end               
    end
end

fclose("all");
motion.name=Motion;
motion.time=Time;
for k=1:length(Time)
    values=first{k};
    motion.q1(:,k)=transpose(values(1,:));
    motion.q2(:,k)=transpose(values(2,:));
    motion.q3(:,k)=transpose(values(3,:));
    motion.q4(:,k)=transpose(values(4,:));
    motion.q5(:,k)=transpose(values(5,:));
    motion.q6(:,k)=transpose(values(6,:));
    motion.q7(:,k)=transpose(values(7,:));
    motion.q8(:,k)=transpose(values(8,:));
    motion.q9(:,k)=transpose(values(9,:));
    motion.q10(:,k)=transpose(values(10,:));
    motion.q11(:,k)=transpose(values(11,:));
    motion.q12(:,k)=transpose(values(12,:));
    motion.q13(:,k)=transpose(values(13,:));
    motion.q14(:,k)=transpose(values(14,:));
    motion.q15(:,k)=transpose(values(15,:));
    motion.q16(:,k)=transpose(values(16,:));
    motion.q17(:,k)=transpose(values(17,:));
end

for k=1:length(Time)
    values=third{k};
    motion.J1(:,k)=transpose(values(1,:));
    motion.J2(:,k)=transpose(values(2,:));
    motion.J3(:,k)=transpose(values(3,:));
    motion.J4(:,k)=transpose(values(4,:));
    motion.J5(:,k)=transpose(values(5,:));
    motion.J6(:,k)=transpose(values(6,:));
    motion.J7(:,k)=transpose(values(7,:));
    motion.J8(:,k)=transpose(values(8,:));
    motion.J9(:,k)=transpose(values(9,:));
    motion.J10(:,k)=transpose(values(10,:));
    motion.J11(:,k)=transpose(values(11,:));
    motion.J12(:,k)=transpose(values(12,:));
    motion.J13(:,k)=transpose(values(13,:));
    motion.J14(:,k)=transpose(values(14,:));
    motion.J15(:,k)=transpose(values(15,:));
    motion.J16(:,k)=transpose(values(16,:));
    motion.J17(:,k)=transpose(values(17,:));
    motion.J18(:,k)=transpose(values(18,:));
    motion.J19(:,k)=transpose(values(19,:));
    motion.J20(:,k)=transpose(values(20,:));
end

save("motion/"+Motion+"_q",'motion');

clear char ind ind_segment ind_time pos1 pos2 time val vec file ind_vec Time k Motion values first second third fourth ind_joint 