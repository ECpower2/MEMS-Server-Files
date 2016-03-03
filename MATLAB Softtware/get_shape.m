function [W1,X1,Y1,Z1,W2,X2,Y2,Z2,W3,X3,Y3,Z3,W4,X4,Y4,Z4] = get_shape(filename,type)
% reshapes output of beam_data_avg.m for use with beam_shape.m
% type: 0 = local quaternions, 1 = global quaternions

data = csvread(filename);

if type == 0
%     W1 = [data(1,19) data(1,21:24)];
%     W2 = [data(2,19) data(2,21:24)];
%     W3 = [data(3,19) data(3,21:24)];
%     W4 = [data(4,19) data(4,21:24)];
%     X1 = [data(1,25) data(1,27:30)];
%     X2 = [data(2,25) data(2,27:30)];
%     X3 = [data(3,25) data(3,27:30)];
%     X4 = [data(4,25) data(4,27:30)];
%     Y1 = [data(1,31) data(1,33:36)];
%     Y2 = [data(2,31) data(2,33:36)];
%     Y3 = [data(3,31) data(3,33:36)];
%     Y4 = [data(4,31) data(4,33:36)];
%     Z1 = [data(1,37) data(1,39:42)];
%     Z2 = [data(2,37) data(2,39:42)];
%     Z3 = [data(3,37) data(3,39:42)];
%     Z4 = [data(4,37) data(4,39:42)];
    W1 = data(1,20:24);
    W2 = data(2,20:24);
    W3 = data(3,20:24);
    W4 = data(4,20:24);
    X1 = data(1,26:30);
    X2 = data(2,26:30);
    X3 = data(3,26:30);
    X4 = data(4,26:30);
    Y1 = data(1,32:36);
    Y2 = data(2,32:36);
    Y3 = data(3,32:36);
    Y4 = data(4,32:36);
    Z1 = data(1,38:42);
    Z2 = data(2,38:42);
    Z3 = data(3,38:42);
    Z4 = data(4,38:42);
elseif type == 1
    W1 = [data(1,43) data(1,45:48)];
    W2 = [data(2,43) data(2,45:48)];
    W3 = [data(3,43) data(3,45:48)];
    W4 = [data(4,43) data(4,45:48)];
    X1 = [data(1,49) data(1,51:54)];
    X2 = [data(2,49) data(2,51:54)];
    X3 = [data(3,49) data(3,51:54)];
    X4 = [data(4,49) data(4,51:54)];
    Y1 = [data(1,55) data(1,57:60)];
    Y2 = [data(2,55) data(2,57:60)];
    Y3 = [data(3,55) data(3,57:60)];
    Y4 = [data(4,55) data(4,57:60)];
    Z1 = [data(1,61) data(1,63:66)];
    Z2 = [data(2,61) data(2,63:66)];
    Z3 = [data(3,61) data(3,63:66)];
    Z4 = [data(4,61) data(4,63:66)];
else
    warning('type should equal 0 or 1')
end