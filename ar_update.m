%function [A,R,E] = ar_update(S)
%A(i,k)和R(i,k)信息迭代
tic;
N=size(S,1);
A=zeros(N,N);
R=zeros(N,N); % Initialize messages
lam=0.5; % Set damping factor
count = 0;
for iter=1:10000
    Eold = A + R;
    % Compute responsibilities
    Rold=R;
    AS=A+S;
    [Y,I]=max(AS,[],2);% 每行的最大值组成的列向量
    for i=1:N
        AS(i,I(i))=-realmax;%把每一行的最大值变成-1000
    end;
    [Y2,I2]=max(AS,[],2);
    R=S-repmat(Y,[1,N]);%repmat将y转变为由每行最大值组成的与s同型的矩阵
    for i=1:N
        R(i,I(i))=S(i,I(i))-Y2(i);
    end;
    R=(1-lam)*R+lam*Rold; % Dampen responsibilities
    % Compute availabilities
    Aold=A;
    Rp=max(R,0);
    for k=1:N
        Rp(k,k)=R(k,k);
    end;
    A=repmat(sum(Rp,1),[N,1])-Rp;%repmat为复制，sum(,1)是竖向相加，输出行向量
    dA=diag(A);%对角线
    A=min(A,0);
    for k=1:N
        A(k,k)=dA(k);
    end;
    A=(1-lam)*A+lam*Aold; % Dampen availabilities

    %判断当类中心连接几次不变化时，结束for循环
    E = A + R;
    if diag(Eold) == diag(E)
        count = count + 1;
        if count == 10   %terminate the algorithm when these decisions did not change for 10 iterations.
            break;
        end
    else
        count=0;
    end
end
toc;