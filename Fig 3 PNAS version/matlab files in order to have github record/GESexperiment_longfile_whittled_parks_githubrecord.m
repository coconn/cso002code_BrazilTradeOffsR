% GESexperiment_longfile_whittled_parks.m
%
% same as GESexperiment_longfile_whittled.m but calcs all the land use
% choices assuming that parks are off limits
%
% Processed by CS O'Connell; 28 Jan 2015; UMN EEB/IonE
%


zen


%% parks data

% load parks data
protectedareadir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/Protected Areas Dataset/MIF protected areas data/ncmat';
load([protectedareadir '/protectedareas.mat']);
protectedarea = Svector(3).Data;
clear Svector
protectedareatmp = (protectedarea==-128);
protectedarea(protectedareatmp) = 0;
% use protectedarea, 1 = yes protected, 0 = not protected

%%%% see line 285 and on for where the parks get ruled out

%%%% I changed where/how things are saved in: line 399, 702, 716, 839


%%%%%%%%%%%%%%%%%%%%%%%%
%% objfuncwho.m
%%%%%%%%%%%%%%%%%%%%%%%%

% objfuncwho.m
%
% objfuncwho.m decides which maps to include in comparing services and
% building an objective function; it saves several mats for use in analysis
% later and for collaboration with peder engstrom in building synthesis
% figure
%
% see also: objfuncexp1.m, objfuncexp2.m, many other files that yielded the
% .mat files used below
% see also: whichmaphistfigs.m for organizational idea
%
% Processed by CS O'Connell; 17 Nov 2013; UMN EEB/IonE
%


%% services data (what's being gained/lost)
% include uncertainty for the carbon side

% climate index base data
regclimdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/REGIONAL CLIMATE/';
load([regclimdir 'Climate Index/climateindex.mat']);
% use delHbigAm, delQbigAm

% agricultural yield base data
agdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/AGRICULTURE/';
load([agdir 'agtradeoff.mat']);
% use soybeanyieldkcal, livestockdenskcal

% biodiv base data
biodivdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/BIODIV/Tradeoff/';
load([biodivdir 'biodivtradeoffpnas.mat']);
% use richnessALLAm

% biomass base data
biomassdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/BIOMASS/ComboEffectsFinal';
load([biomassdir '/Cstockcomboeffectsfinal.mat']);
% use Cstockdelta_mean



%% ratiomat data (where should things be gained/lost)

% biomass ratiomat
biomassdir =  '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/BIOMASS/Biomass Figures/biomass_tradeofffigs_17nov'
load([biomassdir '/ratiomatAmCstockdelta.mat']);
% use ratiomatAmCstockdelta, ratiomatAmCstockdeltaabs

% biodiv base data
biodivdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/BIODIV/Tradeoff/';
load([biodivdir 'biodivtradeoffpnas.mat']);
% use ratiomatbiodiv

% climate ratiomat
regclimdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/REGIONAL CLIMATE/Clim Eff Frontier/';
load([regclimdir 'efficfrontier_climindex_v2.mat']);
% use ratiomatdelQbigAm and ratiomatdelHbigAm

% LULC map
% take out places with 2008 LULCC already embodied
carlsondir='/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/BIOMASS/2008 Carlson Protocol';
load([carlsondir '/Carlson2008tifs.mat']);
% use naturalveg_fraction_5min
naturalveg_fraction_5min(~Amazonia)=NaN;
naturalveg_fraction_5min(naturalveg_fraction_5min<=-10)=NaN; % 1 = totally natural veg

spare delHbigAm    delQbigAm  ...
    soybeanyieldkcal livestockdenskcal ...
    richnessALLAm Cstockdelta_mean ...
    Cstockdelta_025CI Cstockdelta_975CI ...
    Amazonia Amazoniasm ...
    ratiomatAmCstockdelta ratiomatAmCstockdeltaabs ...
    ratiomatbiodiv ...
    ratiomatdelQbigAm ratiomatdelHbigAm ...
    naturalveg_fraction_5min startnum endnum protectedarea

mapstringcellarray={'delHbigAm'  ,  'delQbigAm'  ...
    'soybeanyieldkcal', 'livestockdenskcal' ...
    'richnessALLAm', 'Cstockdelta_mean' ...
    'Cstockdelta_025CI', 'Cstockdelta_975CI' ...
    'ratiomatAmCstockdelta', 'ratiomatAmCstockdeltaabs' ...
    'ratiomatbiodiv', ...
    'ratiomatdelQbigAm', 'ratiomatdelHbigAm'};
% don't include Amazonia masks in your data name cell array
% 'Amazonia', 'Amazoniasm' ...



%% onto same map

tic
for i=1:length(mapstringcellarray)
    
    % define map
    eval([ 'map=' mapstringcellarray{i} ';'  ])
    % define mapstring
    mapstring=mapstringcellarray{i};
    
    % get right size of Amazon mask (define as Amaz)
    a=size(map);
    b=a(1);
    if b == 4320
        Amaz=Amazonia;
    end
    if b == 2160
        Amaz=Amazoniasm;
    end
    
    % prep map for Amazonia
    map(~Amaz)=NaN;
    
    % get map onto right world (4320, 2160)
    a=size(map);
    b=a(1);
    if b == 4320
        disp('.') % skip this map; no resizing needed
    end
    if b == 2160
        % resizing needed
        map_resize=EasyInterp2(map,4320,2160);
        eval([ mapstring '_resize = map_resize;'])
        disp([mapstring])
    end
    
end
toc



%% define services and tradeoffs

% things that will be tallied
servicesstringcellarray={'delHbigAm_resize'  ,  'delQbigAm_resize'  ...
    'soybeanyieldkcal', 'livestockdenskcal' ...
    'richnessALLAm', 'Cstockdelta_mean' ...
    'Cstockdelta_025CI', 'Cstockdelta_975CI'};


% things that will determine GES index map
tradeoffcellarray={'ratiomatAmCstockdeltaabs' ...
    'ratiomatbiodiv', ...
    'ratiomatdelQbigAm_resize', 'ratiomatdelHbigAm_resize'};


% % % should any of the above indices be combined?
% % combineflag=1;
% % combinewhich=[3 4];



%% now go to GES creation .m file
% process_GES.m or process_GES_hacontrolled.m







%%%%%%%%%%%%%%%%%%%%%%%%
%% process_GES_hacontrolled.m
%%%%%%%%%%%%%%%%%%%%%%%%


%% define the GES (Good Environmental Stuff) scoring

% Maximize(GES = (wC)*C + (wCl)*Cl + (wB)*B)
% where wC, wCl, wB are weight of carbon, climate and biodiversity
% respectively (analogous to prices)
% under constraits of:
% (1) ag_future = ag_present.*1.2 % 20% ag increase



%% scale services from 0-1
% see also ANPP_livestock.m

% what do we actually want to scale?
% the potential loses

% mitigated carbon losses 0-1
% where the service is not emitting that many tons of carbon if the cell were deforested
service = abs(Cstockdelta_mean);
maxservice = max(max(service(isfinite(service))));
scaledservice = service ./ maxservice; % goes to 1
min(scaledservice(:))
max(scaledservice(:))
scaledserviceC=scaledservice; % where the service is not emitting that many tons of carbon if the cell were deforested

% habitat provision for biodiversity 0-1
% where the service is being a habitat that can house a lot of different species
service = richnessALLAm;
maxservice = max(max(service(isfinite(service))));
scaledservice = service ./ maxservice; % goes to 1
min(scaledservice(:))
max(scaledservice(:))
scaledserviceB=scaledservice; % where the service is being a habitat that can house a lot of different species


% biophysical climatic regulation 0-1
% where the service is continuing to stabilize local atmospheric temperature and moisture
% temperature

% units: Q is change in mm H2O/day exported (over what area?);
% H is degrees Celsius of warming (annual average?)

% H
service = abs(delHbigAm_resize);
maxservice = max(max(service(isfinite(service))));
scaledservice = service ./ maxservice; % goes to 1
min(scaledservice(:))
max(scaledservice(:))
scaledserviceClH=scaledservice; % where the service is continuing to stabilize local atmospheric temperature and moisture

% Q
service = abs(delQbigAm_resize);
maxservice = max(max(service(isfinite(service))));
scaledservice = service ./ maxservice; % goes to 1
min(scaledservice(:))
max(scaledservice(:))
scaledserviceClQ=scaledservice; % where the service is continuing to stabilize local atmospheric temperature and moisture

% combine into one 0-1 metric
service = scaledserviceClQ + scaledserviceClH;
maxservice = max(max(service(isfinite(service))));
scaledservice = service ./ maxservice; % goes to 1
min(scaledservice(:))
max(scaledservice(:))
scaledserviceCl=scaledservice; % where the service is continuing to stabilize local atmospheric temperature and moisture

%%%%%% email out to Paul about units for the climate part




%% define new LULC details

% LULC extensification cutoff
% how much LULC in cell before it gets thrown out?
LULCcutoff=.10; % allow LULC to have nat veg go down to x% inside a cell

% how many hectares worth of LULCC are left to be converted?
% hectares available in each cell for conversion according to cutoff
allowedNNVha=((1-LULCcutoff).*GetFiveMinGridCellAreas).*Amazonia;
% hectares converted in 2008
NNVha2008=(1-naturalveg_fraction_5min).*GetFiveMinGridCellAreas.*Amazonia; % embodied NNV ha
% current proportion in NNV?
tmp=GetFiveMinGridCellAreas.*Amazonia;
Amazonha=nansum(nansum(tmp));
NNVha2008num=nansum(nansum(NNVha2008));
NNVpropregion=NNVha2008num/Amazonha;
% possible hectares for future conversion
convfutureNNVha=allowedNNVha-NNVha2008; % conversion in the future (when the cell flips) ha
convfutureNNVha(convfutureNNVha<0)=0; % if the cell is above the cutoff already, that's ok
convfutureNNVha(isnan(convfutureNNVha))=0; % if the cell is above the cutoff already, that's ok

%%%%%%%% This is where protected areas get ruled out
% use protectedarea, 1 = yes protected, 0 = not protected
disp('This run IS excluding ALL protected areas as available for expansion.')
convfutureNNVha(protectedarea==1)=0;
% convfutureNNVha is hectares that are available in that cell for future
% conversion; for protected areas we'll just set that available land to 0



% amount of extensification
% define new hectares
propnewha=1.0; % proportion increase in convereted hectares (1=100% increase=doubling)
NNVha2008num=nansum(nansum(NNVha2008));
amtnewha=NNVha2008num*propnewha;

% so, need to distribute amtnewha at least harm without going over convfutureNNVha

% print useful info
disp(['As of 2008, ' num2str(NNVha2008num) ' hectares were' ...
    ' already non-natural vegetation.'])
disp(['That constitutes ' num2str(NNVpropregion.*100) '% of Amazonia.'])
disp(['We will increase non-natural hectares by ' num2str(propnewha.*100) ' percent, '...
    'converting ' num2str(amtnewha) ' new hectares to ag at least enviro harm.'])
disp(['Cells will not be allowed to have more than ' num2str((1-LULCcutoff).*100) '% in non-natural vegetation due to new expansion.'])
disp('(See defined LULCcutoff variable.)')


%% calculate impact per political unit

% bring in political unit maps
poldir='/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment';
load([poldir '/newAmazoniapoliticalunits.mat'])

% make this faster by only running for Amazonia
% polmaps={'newAmazoniapoliticalunitsCountry','newAmazoniapoliticalunitsState','Amazonia'};
% polmapunitnames={'newAmcountrystrings','newAmstatestrings','system'};
polmaps={'Amazonia'};
polmapunitnames={'system'};

% polmaps info
newAmcountrystrings;
newAmstatestrings;
% newAmcountrystrings =
%     'notAmazonia'    'BOL'    'COL'    'ECU'    'VEN'    'GUY'    'SUR'    'BRA'    'PER'
system={'notAmazonia','AmazoniaStudySystem'};

% impacts to look at
impactstring={'impactmapC','newNNVha','totalha','embNNVha',...
    'impactmapcropkcal', 'impactmappastkcal','impactmapbiodiv',...
    'impactmapsensible', ...
    'impactmaplatent', 'impactmapscaledserviceCl'};
% how to look at them
calcstring={'sum','sum','sum','sum',...
    'sum', 'sum','avg',...
    'avg','avg','avg'};












%%%%%%%%%%%%%%%%%%%%%%%%
%% THIS IS WHERE THE GES_# LOOP BEGINS
%%%%%%%%%%%%%%%%%%%%%%%%


weightscaleprimary=[0:0.05:1];
varyover = length(weightscaleprimary);
weighting = zeros(3,1);

% loop is one big weights loop


n=0; % counter
tic
for i=1:varyover
    
    
    weighting(1)=weightscaleprimary(i);
    priorityremaining=(1-weighting(1));
    
    for j=1:varyover
        %% set weights
        
        % set weighting(2) according to weightscaleprimary
        weighting(2)=priorityremaining.*(weightscaleprimary(j));
        
        % weighting(3) gets remaining priority
        weighting(3)=priorityremaining-weighting(2);
        
        % this works!
        % now weighting is defined
        
        % counter to name variables below
        n=n+1;
        disp(['working on n=' num2str(n) ' with weights ' num2str(weighting(1)) ', ' num2str(weighting(2)) ', ' num2str(weighting(3)) ])
        
        % save weights in vector for later
        wCvec(n) = weighting(1);
        wClvec(n) = weighting(2);
        wBvec(n) = weighting(3);
        
        
        
        %% solve for GES maps
        
        % be in right place
        cd '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3DfigProtArea/'
        
        solveGESmaps=1; % note that this is slow, so unless you've changed something, just load the .mat files
        
        if solveGESmaps==1
            
            
            % assign weights
            wC=weighting(1);
            wCl=weighting(2);
            wB=weighting(3);
            
            % GES values map
            % Maximize(GES = (wC)*C + (wCl)*Cl + (wB)*B)
            GES = (wC).*scaledserviceC + (wCl).*scaledserviceCl + (wB).*scaledserviceB;
            % save as full GES map
            eval([ 'GES' num2str(n) '=GES;'])
            
            % whittle down the hectares we aim to convert
            amtnewha_running = amtnewha;
            counter=0;
            newvec=zeros(size(GES(Amazonia))); % to record locations flipped
            newvecha=zeros(size(GES(Amazonia))); % to record hectares flipped
            while amtnewha_running > 150000
                
                counter=counter+1;
                
                % cells to flip at once
                if amtnewha_running > 50000000
                    stepsize=1000;
                elseif amtnewha_running < 1000000
                    stepsize=20;
                else
                    stepsize=200;
                end
    
                
                % which cell to flip
                hectaretmp=convfutureNNVha(Amazonia);
                tmp=GES(Amazonia); % the VALUES of GES in the amazon logical area
                tmp(isnan(tmp))=0;
                [flipvals,flipii]=sort(tmp,'ascend');
                ii=find(flipvals>0,1); % first non-zero place
                jj=ii+(counter*stepsize)-stepsize; % first cell to flip based on counter
                kk=jj+stepsize-1;
                % record the location of those cells
                chosenflipii=flipii(jj:kk);
                newvec(chosenflipii)=1;
                
                % how many hectares were flipped in this step?
                newha_thisflipvec = hectaretmp(chosenflipii);
                newvecha(chosenflipii)=newha_thisflipvec; % record for a map later
                newha_thisflip = sum(newha_thisflipvec);
                
                % keep track of remaining hectares
                amtnewha_running = amtnewha_running - newha_thisflip;
                
                % disp where we're at
                if round(counter/50)==counter/50
                    disp(['counter = ' num2str(counter) '; amtnewha_running = ' num2str(amtnewha_running)])
                end
                
            end
            
            % summary maps and info
            
            % put newvec into a new map
            newmapLULC=zeros(size(Amazonia));
            newmapLULC(Amazonia)=newvec;
            % save as new var
            eval([ 'newmapLULC' num2str(n) '=newmapLULC;'])
            
            % and same but not logical map, map of how many hectares per cell
            newmapLULCha=zeros(size(Amazonia));
            newmapLULCha(Amazonia)=newvecha;
            % save as new var
            eval([ 'newmapLULCha' num2str(n) '=newmapLULCha;'])
            
            % how many hectares flipped in total?
            amtnewha_actual=amtnewha-amtnewha_running;
            % save as new var
            eval([ 'amtnewha_actual' num2str(n) '=amtnewha_actual;'])
            
            % combine the above into a categorical map for printing/use in figures
            newmapLULCprop=newmapLULCha./fma;
            NNVha2008prop=NNVha2008./fma;
            GESfigurecategorical = zeros(4320,2160);
            % not new deforestation (better name for this - preserved forest?)
            GESfigurecategorical(logical((NNVha2008prop+newmapLULCprop)<.33 & Amazonia))=2;
            % impactedAm --> not available Amazon / already deforested (see above)
            GESfigurecategorical(logical(NNVha2008prop>.33 & Amazonia))=3;
            % scenario new deforestation --> marked for defor by this scenario
            GESfigurecategorical(logical(newmapLULCprop>.20 & Amazonia))=1;
            % save as new var
            eval([ 'GESfigurecategorical' num2str(n) '=GESfigurecategorical;'])
            
            
            % save
            save(['GESmaps' num2str(n) ],'GES', 'newmapLULC', 'newmapLULCha', 'newmapLULCprop', 'GESfigurecategorical', 'weighting', 'LULCcutoff', 'amtnewha_actual');
            
            
        else
            
            disp('note that you''re not redefining the GES files, just loading the previous .mat files.')
            
        end
        
        
        
        
        %% calculate impact maps
        
        % carbon impacts
        % MgC/ha
        carbon=Cstockdelta_mean;
        % impactmap
        impactmapC=newmapLULCha.*carbon; % spatial emissions
        
        % land impacts
        newNNVha=newmapLULCha;
        totalha=Amazonia.*GetFiveMinGridCellAreas; % HA in Amazonia
        embNNVha=NNVha2008; % HA already in NNV in 2008
        
        % ag impacts
        kcalcrop=soybeanyieldkcal;
        kcalpast=livestockdenskcal;
        % new hectares, split between crop and past
        HAsag=newmapLULCha./2;
        % impactmap
        impactmapcropkcal=kcalcrop.*HAsag; % spatial kcal delivery
        impactmappastkcal=kcalpast.*HAsag; % spatial kcal delivery
        
        % biodiv impacts
        ranges=richnessALLAm;
        impactmapbiodiv = ranges;
        impactmapbiodiv(newmapLULCha<10)=0;
        
        % regional climatic impacts
        sensible=delHbigAm_resize;
        latent=delQbigAm_resize;
        % places to flip
        newmap=newmapLULC;
        % don't need to use hectares, since this measurement is per m^2 and we'll
        % use averages for now
        % HAs=convfutureNNVha;
        % impactmap sensible
        impactmapsensible=sensible; % spatial sensible impacts
        impactmapsensible(newmapLULCha<10)=0;
        % impactmap latent
        impactmaplatent=latent; % spatial latent impacts
        impactmaplatent(newmapLULCha<10)=0;
        % one with the index
        impactmapscaledserviceCl=scaledserviceCl;
        impactmapscaledserviceCl(newmapLULCha<10)=0;
        %%%% should this have been not the delta W/m2, but used the ag ones for the
        %%%% LULCC areas and the natveg ones for the remaining hectares?
        
        
        
        % save the vars (maps only)
        save(['newmapLULC' num2str(n) 'data' ], ...
            'impactmapC','newNNVha','totalha','embNNVha',...
            'impactmapcropkcal', 'impactmappastkcal','impactmapbiodiv',...
            'impactmapsensible', ...
            'impactmaplatent', 'impactmapscaledserviceCl');
        
        
        
        
        %% begin impacts loop
        % including loop layer to move through the different newmapLULC options
        
        redoOS=1;
        
        if redoOS==1
            
            
            for i=1:length(polmaps)
                
                % define polmap, polmapunitnames
                eval([ 'polmap=' polmaps{i} ';'  ])
                eval([ 'polmapun=' polmapunitnames{i} ';'  ])
                % define polmapstring
                polmapstring=polmaps{i};
                % pol units
                polunits=unique(polmap);
                
                % pre-define saving matrix for info
                OS.polunits=cell(length(polunits),1);
                OS.impactmapC=zeros(length(polunits),5);
                OS.newNNVha=zeros(length(polunits),5);
                OS.totalha=zeros(length(polunits),5);
                OS.embNNVha=zeros(length(polunits),5);
                OS.impactmapcropkcal=zeros(length(polunits),5);
                OS.impactmappastkcal=zeros(length(polunits),5);
                OS.impactmapbiodiv=zeros(length(polunits),5);
                OS.impactmapsensible=zeros(length(polunits),5);
                OS.impactmaplatent=zeros(length(polunits),5);
                OS.impactmapscaledserviceCl=zeros(length(polunits),5);
                
                for j=1:length(polunits)
                    
                    % places in that political unit
                    polplaces=(polmap==polunits(j)); % places in that political unit
                    
                    % calc each impact for that political unit
                    for k=1:length(impactstring)
                        
                        % define impact
                        eval([ 'impactmap=' impactstring{k} ';'  ])
                        
                        % impacts in polplaces
                        tmp=impactmap(polplaces);
                        % sum
                        sumoftmp=nansum(tmp);
                        % avg
                        tmp(tmp==0) = NaN;
                        avgoftmp=nanmean(tmp);
                        % std
                        stdoftmp=nanstd(tmp);
                        % area weighted mean impact
                        newmapLULCprop=newmapLULCha./fma;
                        wgtavgoftmp=nansum((tmp .* newmapLULCprop(polplaces))) / sum(sum(newmapLULCprop(polplaces)));
                        % area weighted std impact
                        wgtstdoftmp=nansum(stdoftmp .* newmapLULCprop(polplaces)) / sum(sum(newmapLULCprop(polplaces)));
                        
                        % put into correct OS
                        eval([ 'OS.' impactstring{k} '(j,1)=sumoftmp;'  ])
                        eval([ 'OS.' impactstring{k} '(j,2)=avgoftmp;'  ])
                        eval([ 'OS.' impactstring{k} '(j,3)=stdoftmp;'  ])
                        eval([ 'OS.' impactstring{k} '(j,4)=wgtavgoftmp;'  ])
                        eval([ 'OS.' impactstring{k} '(j,5)=wgtstdoftmp;'  ])
                        
                        
                        
                    end
                    
                    % OS.polunits=zeros(length(polunits),1);
                    OS.polunits{j}=polmapun{j};
                    
                    
                    
                end
                
                % save summary info as one big mat?
                eval([ 'OS' num2str(i) 'LULC' num2str(n) '=OS;'  ])
                eval([ 'save OS' num2str(i) 'LULC' num2str(n) ' OS' num2str(i) 'LULC' num2str(n) ' polmapstring' ])
                
                
                
            end
            
            
        else
            
            disp('note that you are not re-doing the OS-es.')
            
        end
        
        % clean up memory
        clear OS* GES* newmapLULC* newmapLULCha* newmapLULCprop* GESfigurecategorical* amtnewha_actual*
        
        
    end
    
    disp(['just finished with on n=' num2str(n) ' with weights ' num2str(weighting(1)) ', ' num2str(weighting(2)) ', ' num2str(weighting(3)) ])
    
    clear weighting*
    
end
toc

save weightinginfo wCvec wClvec wBvec








%%%%%%%%%%%%%%%%%%%%%%%%
%% OSLULCtablev2_hacontrolled.m
%%%%%%%%%%%%%%%%%%%%%%%%



% OSLULCtablev2_hacontrolled.m
%
% incorporate loop for the different OSLULC .mat files
%
% take the processed impact structures (OSLULC structures) made from
% process_objfuncimpacts.m and report the results in a table for use in
% your manuscript
%
% see also: objfuncwho.m, objfuncexp1.m, process_GES.m, process_objfuncimpacts.m
%
% Processed by CS O'Connell; 21 Nov 2013; UMN EEB/IonE
%

% be in right place
cd '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3DfigProtArea/'
        
a=dir('OS*');

GESdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/';
load([GESdir 'rowheaders.mat']);
rowheadersnew={rowheaders{1:9},...
    'biodiv ranges in LULC cells (weighted mean)','biodiv ranges in LULC cells (wgt std)',...
    rowheaders{12:13},...
    'delta degC in LULC cells (weighted mean)','delta degC in LULC cells (wgt std)',...
    rowheaders{14:15},...
    'delta mm H2O/day in LULC cells (weighted mean)','delta mm H2O/day in LULC cells (std)',...
    'ClimReg Index (mean)','ClimReg Index (std)'}

OSdir = '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3DfigProtArea/';

tic
for k=1:length(a)
    
    % get info about this .mat
    OSname=a(k).name;
    if length(OSname)==13
        OScall=OSname(1:9);
    elseif length(OSname)==14
        OScall=OSname(1:10);
    else
        OScall=OSname(1:8);
    end
    
    %% bring in data
    
    % OS for given LULC arrangement
    load([OSdir OSname]);
    
    %% pull out desired data and put into matrix
    
    eval([ 'OSLULC=' OScall ';'])
    
    % start up the newdata mat
    d=OSLULC.polunits;
    polplaceholder=zeros(size(d,1),1);
    newdata = [polplaceholder];
    
    % fill in the newdata matrix sequentially
    tmp=OSLULC.impactmapC(:,1);
    newdata = [newdata tmp];
    tmp=OSLULC.newNNVha(:,1);
    newdata = [newdata tmp];
    tmp=OSLULC.totalha(:,1);
    newdata = [newdata tmp];
    tmp=OSLULC.embNNVha(:,1);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapcropkcal(:,1);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmappastkcal(:,1);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapbiodiv(:,2);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapbiodiv(:,3);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapbiodiv(:,4);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapbiodiv(:,5);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapsensible(:,2);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapsensible(:,3);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapsensible(:,4);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapsensible(:,5);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmaplatent(:,2);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmaplatent(:,3);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmaplatent(:,4);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmaplatent(:,5);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapscaledserviceCl(:,2);
    newdata = [newdata tmp];
    tmp=OSLULC.impactmapscaledserviceCl(:,3);
    newdata = [newdata tmp];
    
    
    %% write to a csv
    
    %%%%% this works!!!!!!
    csvfilename=[ 'impacts_' OScall '.csv']
    fid = fopen(csvfilename,'w')
    numColumns = size(rowheadersnew,2);
    % use repmat to construct repeating formats
    % ( numColumns-1 because no comma on last one)
    headerFmt = repmat('%s,',1,numColumns-1);
    % bring in headers
    fprintf(fid,[headerFmt,'%s\n'],rowheadersnew{1,:})
    for j=1:size(d,1)
        % polunit for that line
        tmp=d{j};
        fprintf(fid,'%s,',tmp);
        % newdata for that line
        numFmt = repmat('%f,',1,numColumns-2);
        tmpvec=newdata(j,:);
        fprintf(fid,[numFmt,'%f\n'],tmpvec(2:21));
    end
    fclose(fid)
    
    k
    
end
toc






%%%%%%%%%%%%%%%%%%%%%%%%
%% process_collectcsvdata.m
%%%%%%%%%%%%%%%%%%%%%%%%


% process_collectcsvdata.m
%
% pull out data from OSLULC csv files and collect it into one place for
% easy graphing with weights
%
% see also: objfuncwho.m, objfuncexp1.m, process_GES.m,
% process_objfuncimpacts.m, OSLULCtablev2_hacontrolled.m
%
% Processed by CS O'Connell; 28 June 2014; UMN EEB/IonE
%

%% start up stuff

% be in right place
cd '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3DfigProtArea'

% how many scenarios do we havee to include?
a=dir('impacts_OS1*');
% OS1 is only the CSVs that record the outcomes for the entire amazon
% (When I include all 3 political unit levels, OS1 is national level
% results, OS2 is state level results, OS3 is Amazon-wide, but here I only
% processed Amazon wide)

% pre-start the columns I want to build from csv data
NewHA = zeros(length(a),1);
Cropkcal = zeros(length(a),1);
Pastkcal = zeros(length(a),1);
EmittedC = zeros(length(a),1);
HabAvgImpac = zeros(length(a),1);
HabStdImpac = zeros(length(a),1);
DelHAvgImpac = zeros(length(a),1);
DelHStdImpac = zeros(length(a),1);
DelQAvgImpac = zeros(length(a),1);
DelQStdImpac = zeros(length(a),1);
ClimRegIndexAvgImpac = zeros(length(a),1);
ClimRegIndexStdImpac = zeros(length(a),1);
Combokcal = zeros(length(a),1);
% same with weights
wC = zeros(length(a),1);
wB = zeros(length(a),1);
wCl = zeros(length(a),1);



%% bring in info from the csv files

% populate vectors
for n=1:length(a)
    
    tmpnamea=a(n).name;
    M = csvread(tmpnamea,2,1); % brings in row of AmazoniaStudySystem results
    
    % put the data into your vectors
    % note that the positions in M don't change, so don't use variables
    NewHA(n) = M(2);
    Cropkcal(n) = M(5);
    Pastkcal(n) = M(6);
    EmittedC(n) = M(1);
    HabAvgImpac(n) = M(7);
    HabStdImpac(n) = M(8);
    DelHAvgImpac(n) = M(11);
    DelHStdImpac(n) = M(12);
    DelQAvgImpac(n) = M(15);
    DelQStdImpac(n) = M(16);
    ClimRegIndexAvgImpac(n) = M(19);
    ClimRegIndexStdImpac(n) = M(20);
    Combokcal(n) = M(5)+M(6);
    
end


%% bring in weights info from the mat files


% bring in the weights info
b=dir('GESm*.mat');

% populate vectors
for n=1:length(b)
    
    tmpnameb=b(n).name;
    load(tmpnameb) % bring in .mat
    
    wC(n) = weighting(1);
    wCl(n) = weighting(2);
    wB(n) = weighting(3);
    
    n
end


%% combine into one matrix

resultsmatrixcombo = [wC wCl wB NewHA Cropkcal  Pastkcal  EmittedC  ...
    HabAvgImpac  HabStdImpac  DelHAvgImpac  DelHStdImpac  ...
    DelQAvgImpac  DelQStdImpac ClimRegIndexAvgImpac ClimRegIndexStdImpac  Combokcal]

headerstrings = {'wC' ; 'wCl' ; 'wB' ; 'NewHA' ; 'Cropkcal' ;'Pastkcal' ; 'EmittedC' ;  'HabAvgImpac' ; 'HabStdImpac' ; 'DelHAvgImpac' ; 'DelHStdImpac' ;  'DelQAvgImpac' ; 'DelQStdImpac' ; 'ClimRegIndexAvgImpac'; 'ClimRegIndexStdImpac'; 'Combokcal'}'

save OSLULCcombotable resultsmatrixcombo headerstrings

% I then manually pasted resultsmatrixcombo and headerstrings into an excel
% doc and saved that as resultscombotable.txt

% as of jan 2015, switched to automating this in R, so need to make
% resultsmatrixcombo into a csv


% be in right place
cd '/Users/oconn568/Documents/MATLAB/aa O''Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3DfigProtArea'

load('OSLULCcombotable.mat')

% write csv
csvwrite('AmazonTOs_simulationresults.csv',resultsmatrixcombo)




