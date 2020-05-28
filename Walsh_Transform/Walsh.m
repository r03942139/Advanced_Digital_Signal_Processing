function W = Walsh(size)
k=log2(size);
if(mod(k,1)~=0)
    disp('The input number must be 2^k, while k is an integer.')
    W = 'Illegal Assigning Size, Not Exist';
    return
end
W2=[1  1; 1 -1]; % 2-point Walsh transform 
if k==1  % Size=2
    return;
end
W = W2;

%% Correct Order of Walsh
% Observing that the sign-changes of initial W is
% 0 (size-1) 1 (size-2) 2 (size-3) 3 ......
% Thus, by proper spliting, we could easily form a correct 
% 2k-point Walsh transform

for n = 2:k
    W = kron(W,W2);  % K = kron(A,B) returns the Kronecker tensor product of matrices A and B
    V1 = W(1:2:2^n,:);
    V2 = W(2^n:-2:1,:);
    W = [V1;V2];
end
end
