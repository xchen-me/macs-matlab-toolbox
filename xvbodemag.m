function xvbodemag(sys,varargin)
% function xvbodemag(sys,linewidth,sw_linestyle,freq_Hz)
% xbodeplot using varargin mode
% =========================================================================
%   Copyright (c) 2008-, Xu Chen, maxchen@berkeley.edu
%   Author(s): Xu Chen
% =========================================================================
% 2011-04-26

% under debug: 2013-07-26

nall = nargin;
nvargin = length(varargin);
ni = nall - nvargin;
% error( nargchk(1, 4, ni) );
SW_linearAxis = 0;
SW_absMag = 0;
for ii = 1:2:nvargin
    if strcmpi(varargin{ii},'linearAxis')
        SW_linearAxis = varargin{ii+1};
    end
    if strcmpi(varargin{ii},'absMag')
        SW_absMag = varargin{ii+1};
    end
end
% if ni<4
    SW_FREQ = 0;
    if sys{1}.Ts>0 % DT
        SW_FREQ = 1;
        freq_Hz = 0.5/sys{1}.Ts;
    end
% else
%     SW_FREQ = 1;
% end
% if ni<3
    sw_linestyle = 'linestyleOn';
% end
% if ni<2
    linewidth = 1.5;
% end
if ni<1
    error('No inputs')
end

% edit rgb
linecolor = {...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0]};
% linecolor = {...    
%     rgb('Blue'),rgb('Red'),rgb('Cyan'),rgb('Magenta'),rgb('Orange'),rgb('DeepPink'),...
%     rgb('Blue'),rgb('Red'),rgb('LightGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black')};
% linecolor = {'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g'};
if strncmpi(sw_linestyle,'linestyleOn',11)
linestyle = {'-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.'};
else
    linestyle = {'-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',};
end
% if ~exist('linewidth','var')
%     linewidth = 1.5;
% end
N = length(sys);
for ii = 1:N
    if ii == 1
        if SW_FREQ
            freq_Hz_range = logspace(1,log10(freq_Hz),5000);
%             freq_Hz_range = logspace(1,log10(freq_Hz*2*pi),1000);
            freq_in_hz = xbodemag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,freq_Hz_range,SW_linearAxis,SW_absMag);
        else
            freq_in_hz = xbodemag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,[],SW_linearAxis,SW_absMag);
        end
    else
        if SW_FREQ
            freq_Hz_range = logspace(1,log10(freq_Hz),5000);
            xbodemag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,freq_Hz_range,SW_linearAxis,SW_absMag);
        else
            xbodemag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,freq_in_hz,SW_linearAxis,SW_absMag);
        end
    end
    hold on
end
subplot(211)
set( gca, 'xlim',  [min(freq_in_hz) max(freq_in_hz)]);
subplot(212)
set( gca, 'xlim',  [min(freq_in_hz) max(freq_in_hz)]);
subplot(211)