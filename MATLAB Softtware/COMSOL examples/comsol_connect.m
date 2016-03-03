function comsol_connect
% manually sets up comsol connection
% COMSOL server must be active (start from applications menu)

% Change directory to LiveLink with MATLAB in COMSOL folder
addpath('/Applications/COMSOL43b/mli')

% Start livelink (change port number if server is listening on other port)
mphstart(2036)

% Import COMSOL utilities
import com.comsol.model.*
import com.comsol.model.util.*