function y = callfoo  %#codegen 
 y = 0.0; 
%  if coder.target('MATLAB')
  % Executing in MATLAB, call MATLAB equivalent of 
  % C function foo
    y = 10 + 20;
%   else
  % Executing in generated code, call C function foo
    y = coder.ceval('foo', 10, 20);
end  

