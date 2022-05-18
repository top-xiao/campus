syms x t f(x);
f(x) = piecewise(x<0,0,0<=x&x<0.5,0.5,0.5<=x&x<=1,-0.5,x>1,0);
x=linspace(-1,2,100);
t=0;
plot(x,f(x-t),':c',x,f(x+t),':c',x,f(2-x-t),'--c',x,f(-x+t),'--c',x,f(x-t)+f(x+t)+f(2-x-t)+f(-x+t));
xlabel("x");
ylabel("y");
title("t=0");
axis square;