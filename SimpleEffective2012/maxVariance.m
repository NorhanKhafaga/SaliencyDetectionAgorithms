clear;
clc;
v=[23,44,1,83,2];
maxm=v(1);
for i=2:length(v)
    if maxm < v(i)
        maxm=v(i);
        index=i;
    end
    
end