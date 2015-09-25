function [  ] = somAlerta(  )
%BEEP Summary of this function goes here
%   Detailed explanation goes here

beep on
for i = 1 : 10
    pause(1)
    beep
end
beep off

