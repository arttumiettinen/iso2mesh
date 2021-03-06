function binname=mcpath(fname, ext)
%
% binname=mcpath(fname)
%
% get full executable path by prepending a command directory path
% parameters:
%
% author: Qianqian Fang, <q.fang at neu.edu>
%
% input:
%    fname: input, a file name string
%
% output:
%    binname: output, full file name located in the bin directory
%
%    if global variable ISO2MESH_BIN is set in 'base', it will
%    use [ISO2MESH_BIN filesep cmdname] as the command full path,
%    otherwise, let matlab pass the cmdname to the shell, which
%    will search command in the directories listed in system
%    $PATH variable.
%
% -- this function is part of iso2mesh toolbox (http://iso2mesh.sf.net)
%

p=getvarfrom({'caller','base'},'ISO2MESH_BIN');
binname=[];
if(isempty(p))
	% the bin folder under iso2mesh is searched first
	tempname=[fileparts(which(mfilename)) filesep 'bin' filesep fname];
	if(exist([fileparts(which(mfilename)) filesep 'bin'])==7)
        if(nargin>=2)
            if(exist([tempname ext],'file'))
                binname=[tempname ext];
            else
                binname=fname; % use binary without suffix on system PATH
            end
        else
		    binname=tempname;
        end
	else
		binname=fname;
	end
else
	binname=[p filesep fname];
end

if(nargin>=2 && ~exist(binname,'file'))
    binname=fname;
end
