% MiniMaxFilter
function [R, h, MaxerrF] = MiniMaxFilter(F,Hd,W,N,exf,DEL)
%% Parameters Setting
% ========= Input =========                                    ============= Output ========
% F: Normalized Frequency Interval                             R: designed filter R(f)
% Hd: Desired Fiter Hd(F)                                      h: Impulse response h[n] of the designed filter R(f)
% W: weighting function W(F)                                   MaxErrF: The maximal error for each iteration
% N: filter length N
% exF: arbitrary extreme frequency (has been assigned by user)
% DEL: Set the maxima error DELTA in Step 5.

%% Start of the Function
dF = F(2) - F(1);  k = (N-1)/2;  % k=9
MaxerrF = [];   % Max|err(F)

% ------------Start of While------------
while (1)  % Enforcing the loop
%%  ========= Step 2. =================  
   % Solve s[0],s[1],s[2],...,s[k] by perming the matrix inversion.
   % exf={F0,F1,....,Fk+1} 
    M = [ cos(2*pi* exf.' *[0:k]) ,((-1).^[0:k+1]./W(round(exf/dF+1))).']; % Matrix (k+1*k+1) + (1*k+1)
    S =  M^-1 * (Hd(round(exf/dF+1)).') ;  % solve the S  from  MS=Hd
    s = S(1:k+1).';         % Exclude e  S(k+2)
    R = s * cos(2*pi*[0:k].'*F);
    
%%  ========== Step 3. ============
   % Computer err(F) for 0<= F <=0.5, exclude the transition band.
    err = (R - Hd).*W;
    
%% =========== Step 4. ============
   % Find (k+2) local maximal (or minimal) points of err(F)
    exf = [];
    for f = 2:length(F)-1
        if (err(f)>err(f+1) && err(f)>err(f-1))  % add local maximal points (extreme points) 
            exf = [exf F(f)];
        end
        
        if (err(f)<err(f+1) && err(f)<err(f-1))  % add local minimal point (extreme points) 
            exf = [exf F(f)];
        end
    end

      if ((err(1)>=0 && err(2)-err(1)<=0) || (err(1)<=0 && err(2)-err(1)>=0))  % Check the leftmost boundary 
        exf = [F(1) exf];
      end
      
      if ((err(end)>=0 && err(end-1)-err(end)<=0) || (err(end)<=0 && err(end-1)-err(end)>=0)) % Check the rightmost boundary 
        exf = [exf F(end)];
      end
      
%% ==============  Step 5. ================
    E0 = max( abs( err( round(exf/dF+1) ) ) );
    MaxerrF = [ MaxerrF  E0];

      if length(MaxerrF) > 1    % if not the first iteration
        E1 = MaxerrF(end-1);
        if abs(E1-E0) < DEL     % check |E1-E0| < DELTA
            break;
        end
      end      
end  % End of while

%%  ========= Step 6. ================
% Set h[k] = s[0], h[k+n] = s[n]/2, h[k-n] = s[n]/2 for n = 1,2,3,...,k
% The h[n] is the impulse response of the designed filter.
h = [s(k+1:-1:2)/2 s(1) s(2:k+1)/2];

