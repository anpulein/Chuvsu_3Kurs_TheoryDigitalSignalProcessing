% Параллельная форма
function y = filterParallelInt(x)
global Ai;
global Bi;
global oldx;
global oldy;
global k;
global m;
global m1;
y = round(k*x);
[t s] = size(Ai);
for s = 1:t
    temp = y + round(x*Bi(s,1)+oldx*Bi(s,2)/m1);
    temp = y - Ai(s,2)*oldy(2*s-1) - Ai(s,3)*oldy(2*s)
    oldy(2*s) = oldy(2*s-1);
    oldy(2*s-1) = temp;
    y = y+temp;
end
oldx = x;