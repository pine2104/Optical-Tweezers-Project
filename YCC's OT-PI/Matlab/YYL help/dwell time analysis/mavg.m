function yf=mavg(y,n)
yn=length(y)
a=round(n/2);
y=[y(1)*ones(1,a-1) y y(yn)*ones(1,n-a)];
for i=1:yn
    yf(i)=mean(y(i:n+i-1));
end