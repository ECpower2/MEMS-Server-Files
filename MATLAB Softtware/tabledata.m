function tabledata(filename,refnode)
% process table datasets using Node refnode as reference

[time,Node01Gqw,Node01Gqx,Node01Gqy,Node01Gqz,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,Node02Gqw,Node02Gqx,Node02Gqy,Node02Gqz,~,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,Node03Gqw,Node03Gqx,Node03Gqy,Node03Gqz,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,Node04Gqw,Node04Gqx,Node04Gqy,...
    Node04Gqz,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,Node05Gqw,...
    Node05Gqx,Node05Gqy,Node05Gqz,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~] = importwific(filename);

Node1 = [Node01Gqw Node01Gqx Node01Gqy Node01Gqz];
Node2 = [Node02Gqw Node02Gqx Node02Gqy Node02Gqz];
Node3 = [Node03Gqw Node03Gqx Node03Gqy Node03Gqz];
Node4 = [Node04Gqw Node04Gqx Node04Gqy Node04Gqz];
Node5 = [Node05Gqw Node05Gqx Node05Gqy Node05Gqz];

r1 = Node1(1,:);
r2 = Node2(1,:);
r3 = Node3(1,:);
r4 = Node4(1,:);
r5 = Node5(1,:);

a1 = q_divr(Node1,r1);
a2 = q_divr(Node2,r2);
a3 = q_divr(Node3,r3);
a4 = q_divr(Node4,r4);
a5 = q_divr(Node5,r5);

if refnode==1;   ref = a1; 
elseif refnode==2;   ref = a2; 
elseif refnode==3;   ref = a3;
elseif refnode==4;   ref = a4;
elseif refnode==5;   ref = a5; 
end

q1 = q_div1(a1,ref);
q2 = q_div1(a2,ref);
q3 = q_div1(a3,ref);
q4 = q_div1(a4,ref);
q5 = q_div1(a5,ref);

plot(time,q1); legend('w','x','y','z'); title('Node1'); figure;
plot(time,q2); legend('w','x','y','z'); title('Node2'); figure;
plot(time,q3); legend('w','x','y','z'); title('Node3'); figure;
plot(time,q4); legend('w','x','y','z'); title('Node4'); figure;
plot(time,q5); legend('w','x','y','z'); title('Node5'); figure;
plot(time,Node1); legend('Gqw','Gqx','Gqy','Gqz'); title('Node1'); figure;
plot(time,Node2); legend('Gqw','Gqx','Gqy','Gqz'); title('Node2'); figure;
plot(time,Node3); legend('Gqw','Gqx','Gqy','Gqz'); title('Node3'); figure;
plot(time,Node4); legend('Gqw','Gqx','Gqy','Gqz'); title('Node4'); figure;
plot(time,Node5); legend('Gqw','Gqx','Gqy','Gqz'); title('Node5'); 
