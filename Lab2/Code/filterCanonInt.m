% Каноническая форма
function y = filterCanonInt(x)
global a;
global b;
global oldw;
global m;

[s t] = size(b);%t=12
w=x;
for s=2:t
    w = w - round(oldw(s)*a(s)/m);
end
y=0;
oldw(1)=w;
for s=1:t
    y = y + round(oldw(s)*b(s)/m);
end
for s=t:-1:2
    oldw(s)=oldw(s-1);
end
