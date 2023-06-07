% Прямая форма
function y = myFilterDirectInt(x)
global a;
global b;
global oldx;
global oldy;
global m;
[s, t] = size(b);%t=12
y=round(x*b(1)/m);
for s=2:t
    y = y + round(oldx(s-1)*b(s)/m);
    y = y - round(oldy(s-1)*a(s)/m);
end
for s=t:-1:2
    oldx(s)=oldx(s-1);
    oldy(s)=oldy(s-1);
end
oldx(1)=x;
oldy(1)=y;