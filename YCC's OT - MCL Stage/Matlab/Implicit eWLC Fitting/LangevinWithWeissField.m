function y=LangevinWithWeissField(p, x)% Implicit function: Langevin function with a Weiss field.
% y = A*(coth(B*x(i)+C*y) - 1./(B*x(i)+C*y))
% p is the parameter vector
% Physical meaning of the parameters
% x is the magnetic field H
% y is the magnetization M corresponding to n*<m>z where n is the number of
% magnetic moments,  and <m>z is the projected magnetic moment along the
% field direction (called z) of the total moment mu
%A = amplitude
%B = mu0 m/(kB*T) where kB is the Boltzman constant and T is the temperature
%C is a factor giving the Weiss field (that is proportional to the total
%magnetization y, i.e. M=n*<m>z, note that this term includes also the previous factor
% mu0 m /(kB*T)

% assign the parameters ...

A=p(1);
B=p(2);
C=p(3);

y=zeros(size(x)); % define a vector to allocate the magnetization values
NN=length(x); % total length of the field vector x, i.e. B

opt = optimset('display','off');
% I out off all the messages coming from fzero. If something goes wrong, change this option to 'off'
% to see at which x values fzero failed.

for i=1:NN   
   y(i)=fsolve(@(y) y - A*(coth(B*x(i)+C*y) - 1./(B*x(i)+C*y)) , 0.0001, opt);
   % Here 0.0001 is our starting point to find the solution around 0.
end

end % close the function