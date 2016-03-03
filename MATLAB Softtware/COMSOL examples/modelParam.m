function modelParam(model,filepath)
% Parametric study of busbar example
% From Intro to LiveLink for MATLAB, pp.38-39

% Create file and set header of output file format
filename = fullfile(filepath,'results.txt');
fid = fopen(filename,'wt');
fprintf(fid,'*** run parametric study ***\n');
fprintf(fid,'L[m] | tbb[m] | Vtot[V] | ');
fprintf(fid,'MaxT[K] | TotQ[W] | Current[A]\n');

% Disable model history to prevent memory from rising
model.hist.disable;

% Set up and run parametric study
for L = [9e-2 15e-2]
    model.param.set('L',L);
    
    for tbb = [5e-3 10e-3]
        model.param.set('tbb',tbb);
        
        for Vtot = [20e-3 40e-3]
            model.param.set('Vtot',Vtot);
            
            fprintf(fid,[num2str(L),' | ',num2str(tbb),' | ',...
                num2str(Vtot),' | ']);
            
            model.sol('sol1').run;
            
            MaxT = mphmax(model,'T',3,'selection',1);
            TotQ = mphint2(model,'jh.Qtot',3,'selection',1);
            Current = mphint2(model,'jh.normJ',2,'selection',43);
            
            fprintf(fid,[num2str(MaxT),' | ',num2str(TotQ),' | ',...
                num2str(Current),' \n']);
            
            modelName = fullfile(filepath,['busbar_L=',num2str(L),...
                '_tbb=',num2str(tbb),'_Vtot=',num2str(Vtot),'.mph']);
            
            mphsave(model,modelName); 
        end
    end
end

fclose(fid);