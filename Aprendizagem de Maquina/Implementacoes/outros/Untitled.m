close all, clear all, clc

load fisheriris % load the sample data
t1 = classregtree(meas,species);
view(t1);