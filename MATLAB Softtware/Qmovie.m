function M = Qmovie(d,n)
% quick movie from take_stream sequence d (columns 2-5)
% after running Qmovie, use command movie(M) to replay

for i=1:n
    Q=d(i,2:5);
    Q2plot(Q)
    M(i) = getframe;
    close all
end