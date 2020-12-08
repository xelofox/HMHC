function mf=motion_filtered(motion)


dt=motion.time(2)-motion.time(1);

[B,A] = butter(2,20*2*dt);

mf=motion;

% for i=1:6
%     for j=2:length(motion.q1(1,:))
%         %% q
%         if isnan(mf.q1(i,j))
%             mf.q1(i,j)=mf.q1(i,j-1);
%         end
%         if isnan(mf.q2(i,j))
%             mf.q2(i,j)=mf.q2(i,j-1);
%         end
%         if isnan(mf.q3(i,j))
%             mf.q3(i,j)=mf.q3(i,j-1);
%         end
%         if isnan(mf.q4(i,j))
%             mf.q4(i,j)=mf.q4(i,j-1);
%         end
%         if isnan(mf.q5(i,j))
%             mf.q5(i,j)=mf.q5(i,j-1);
%         end
%         if isnan(mf.q6(i,j))
%             mf.q6(i,j)=mf.q6(i,j-1);
%         end
%         if isnan(mf.q7(i,j))
%             mf.q7(i,j)=mf.q7(i,j-1);
%         end
%         if isnan(mf.q8(i,j))
%             mf.q8(i,j)=mf.q8(i,j-1);
%         end 
%         if isnan(mf.q9(i,j))
%             mf.q9(i,j)=mf.q9(i,j-1);
%         end 
%         if isnan(mf.q10(i,j))
%             mf.q10(i,j)=mf.q10(i,j-1);
%         end 
%         if isnan(mf.q11(i,j))
%             mf.q11(i,j)=mf.q11(i,j-1);
%         end 
%         if isnan(mf.q12(i,j))
%             mf.q12(i,j)=mf.q12(i,j-1);
%         end 
%         if isnan(mf.q13(i,j))
%             mf.q13(i,j)=mf.q13(i,j-1);
%         end 
%         if isnan(mf.q14(i,j))
%             mf.q14(i,j)=mf.q14(i,j-1);
%         end 
%         if isnan(mf.q15(i,j))
%             mf.q15(i,j)=mf.q15(i,j-1);
%         end 
%         if isnan(mf.q16(i,j))
%             mf.q16(i,j)=mf.q16(i,j-1);
%         end 
%         if isnan(mf.q17(i,j))
%             mf.q17(i,j)=mf.q17(i,j-1);
%         end 
%         
%         %% J
%         if isnan(mf.J1(i,j))
%             mf.J1(i,j)=mf.J1(i,j-1);
%         end
%         if isnan(mf.J2(i,j))
%             mf.J2(i,j)=mf.J2(i,j-1);
%         end
%         if isnan(mf.J3(i,j))
%             mf.J3(i,j)=mf.J3(i,j-1);
%         end
%         if isnan(mf.J4(i,j))
%             mf.J4(i,j)=mf.J4(i,j-1);
%         end
%         if isnan(mf.J5(i,j))
%             mf.J5(i,j)=mf.J5(i,j-1);
%         end
%         if isnan(mf.J6(i,j))
%             mf.J6(i,j)=mf.J6(i,j-1);
%         end
%         if isnan(mf.J7(i,j))
%             mf.J7(i,j)=mf.J7(i,j-1);
%         end
%         if isnan(mf.J8(i,j))
%             mf.J8(i,j)=mf.J8(i,j-1);
%         end 
%         if isnan(mf.J9(i,j))
%             mf.J9(i,j)=mf.J9(i,j-1);
%         end 
%         if isnan(mf.J11(i,j))
%             mf.J11(i,j)=mf.J10(i,j-1);
%         end 
%         if isnan(mf.J11(i,j))
%             mf.J11(i,j)=mf.J11(i,j-1);
%         end 
%         if isnan(mf.J12(i,j))
%             mf.J12(i,j)=mf.J12(i,j-1);
%         end 
%         if isnan(mf.J13(i,j))
%             mf.J13(i,j)=mf.J13(i,j-1);
%         end 
%         if isnan(mf.J14(i,j))
%             mf.J14(i,j)=mf.J14(i,j-1);
%         end 
%         if isnan(mf.J15(i,j))
%             mf.J15(i,j)=mf.J15(i,j-1);
%         end 
%         if isnan(mf.J16(i,j))
%             mf.J16(i,j)=mf.J16(i,j-1);
%         end 
%         if isnan(mf.J17(i,j))
%             mf.J17(i,j)=mf.J17(i,j-1);
%         end 
%         if isnan(mf.J18(i,j))
%             mf.J18(i,j)=mf.J18(i,j-1);
%         end 
%         if isnan(mf.J19(i,j))
%             mf.J19(i,j)=mf.J19(i,j-1);
%         end 
%         if isnan(mf.J20(i,j))
%             mf.J20(i,j)=mf.J20(i,j-1);
%         end 
%         
% 
%     end
% end



%% Trash

% for i=1:6
%     for j=1:length(motion.q1(1,:))
%         %% q
%         if isnan(mf.q1(i,j))
%             mf.q1(i,j)=0;
%         end
%         if isnan(mf.q2(i,j))
%             mf.q2(i,j)=0;
%         end
%         if isnan(mf.q3(i,j))
%             mf.q3(i,j)=0;
%         end
%         if isnan(mf.q4(i,j))
%             mf.q4(i,j)=0;
%         end
%         if isnan(mf.q5(i,j))
%             mf.q5(i,j)=0;
%         end
%         if isnan(mf.q6(i,j))
%             mf.q6(i,j)=0;
%         end
%         if isnan(mf.q7(i,j))
%             mf.q7(i,j)=0;
%         end
%         if isnan(mf.q8(i,j))
%             mf.q8(i,j)=0;
%         end 
%         if isnan(mf.q9(i,j))
%             mf.q9(i,j)=0;
%         end 
%         if isnan(mf.q10(i,j))
%             mf.q10(i,j)=0;
%         end 
%         if isnan(mf.q11(i,j))
%             mf.q11(i,j)=0;
%         end 
%         if isnan(mf.q12(i,j))
%             mf.q12(i,j)=0;
%         end 
%         if isnan(mf.q13(i,j))
%             mf.q13(i,j)=0;
%         end 
%         if isnan(mf.q14(i,j))
%             mf.q14(i,j)=0;
%         end 
%         if isnan(mf.q15(i,j))
%             mf.q15(i,j)=0;
%         end 
%         if isnan(mf.q16(i,j))
%             mf.q16(i,j)=0;
%         end 
%         if isnan(mf.q17(i,j))
%             mf.q17(i,j)=0;
%         end 
%         
%         %% J
%         if isnan(mf.J1(i,j))
%             mf.J1(i,j)=0;
%         end
%         if isnan(mf.J2(i,j))
%             mf.J2(i,j)=0;
%         end
%         if isnan(mf.J3(i,j))
%             mf.J3(i,j)=0;
%         end
%         if isnan(mf.J4(i,j))
%             mf.J4(i,j)=0;
%         end
%         if isnan(mf.J5(i,j))
%             mf.J5(i,j)=0;
%         end
%         if isnan(mf.J6(i,j))
%             mf.J6(i,j)=0;
%         end
%         if isnan(mf.J7(i,j))
%             mf.J7(i,j)=0;
%         end
%         if isnan(mf.J8(i,j))
%             mf.J8(i,j)=0;
%         end 
%         if isnan(mf.J9(i,j))
%             mf.J9(i,j)=0;
%         end 
%         if isnan(mf.J11(i,j))
%             mf.J11(i,j)=0;
%         end 
%         if isnan(mf.J11(i,j))
%             mf.J11(i,j)=0;
%         end 
%         if isnan(mf.J12(i,j))
%             mf.J12(i,j)=0;
%         end 
%         if isnan(mf.J13(i,j))
%             mf.J13(i,j)=0;
%         end 
%         if isnan(mf.J14(i,j))
%             mf.J14(i,j)=0;
%         end 
%         if isnan(mf.J15(i,j))
%             mf.J15(i,j)=0;
%         end 
%         if isnan(mf.J16(i,j))
%             mf.J16(i,j)=0;
%         end 
%         if isnan(mf.J17(i,j))
%             mf.J17(i,j)=0;
%         end 
%         if isnan(mf.J18(i,j))
%             mf.J18(i,j)=0;
%         end 
%         if isnan(mf.J19(i,j))
%             mf.J19(i,j)=0;
%         end 
%         if isnan(mf.J20(i,j))
%             mf.J20(i,j)=0;
%         end 
%         
% 
%     end
% end
% 
% 
% 
% for k=1:6
%     mf.q1(k,:)=filtfilt(B,A,mf.q1(k,:));
%     mf.q2(k,:)=filtfilt(B,A,mf.q2(k,:));
%     mf.q3(k,:)=filtfilt(B,A,mf.q3(k,:));
%     mf.q4(k,:)=filtfilt(B,A,mf.q4(k,:));
%     mf.q5(k,:)=filtfilt(B,A,mf.q5(k,:));
%     mf.q6(k,:)=filtfilt(B,A,mf.q6(k,:));
%     mf.q7(k,:)=filtfilt(B,A,mf.q7(k,:));
%     mf.q8(k,:)=filtfilt(B,A,mf.q8(k,:));
%     mf.q9(k,:)=filtfilt(B,A,mf.q9(k,:));
%     mf.q10(k,:)=filtfilt(B,A,mf.q10(k,:));
%     mf.q11(k,:)=filtfilt(B,A,mf.q11(k,:));
%     mf.q12(k,:)=filtfilt(B,A,mf.q12(k,:));
%     mf.q13(k,:)=filtfilt(B,A,mf.q13(k,:));
%     mf.q14(k,:)=filtfilt(B,A,mf.q14(k,:));
%     mf.q15(k,:)=filtfilt(B,A,mf.q15(k,:));
%     mf.q16(k,:)=filtfilt(B,A,mf.q16(k,:));
%     mf.q17(k,:)=filtfilt(B,A,mf.q17(k,:));
%     
%     mf.J1(k,:)=filtfilt(B,A,mf.J1(k,:));
%     mf.J2(k,:)=filtfilt(B,A,mf.J2(k,:));
%     mf.J3(k,:)=filtfilt(B,A,mf.J3(k,:));
%     mf.J4(k,:)=filtfilt(B,A,mf.J4(k,:));
%     mf.J5(k,:)=filtfilt(B,A,mf.J5(k,:));
%     mf.J6(k,:)=filtfilt(B,A,mf.J6(k,:));
%     mf.J7(k,:)=filtfilt(B,A,mf.J7(k,:));
%     mf.J8(k,:)=filtfilt(B,A,mf.J8(k,:));
%     mf.J9(k,:)=filtfilt(B,A,mf.J9(k,:));
%     mf.J10(k,:)=filtfilt(B,A,mf.J10(k,:));
%     mf.J11(k,:)=filtfilt(B,A,mf.J11(k,:));
%     mf.J12(k,:)=filtfilt(B,A,mf.J12(k,:));
%     mf.J13(k,:)=filtfilt(B,A,mf.J13(k,:));
%     mf.J14(k,:)=filtfilt(B,A,mf.J14(k,:));
%     mf.J15(k,:)=filtfilt(B,A,mf.J15(k,:));
%     mf.J16(k,:)=filtfilt(B,A,mf.J16(k,:));
%     mf.J17(k,:)=filtfilt(B,A,mf.J17(k,:));
%     mf.J18(k,:)=filtfilt(B,A,mf.J18(k,:));
%     mf.J19(k,:)=filtfilt(B,A,mf.J19(k,:));
%     mf.J20(k,:)=filtfilt(B,A,mf.J20(k,:));
% end

end
