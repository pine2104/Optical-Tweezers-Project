function yf=removenan(y)
in=find(isnan(y));
for i=1:length(in)
    y(in(i))=y(in(i)-1)
end
yf=y;
end
    
    