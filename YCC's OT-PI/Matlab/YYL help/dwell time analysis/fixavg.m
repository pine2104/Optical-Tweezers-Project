function yf=fixavg(y,n)
yn=length(y)
for i=1:floor(yn/n)
    yf(i)=mean(y(1+(i-1)*n:i*n));
end