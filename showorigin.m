function varargout = showorigin(varargin)
% showorigin  Sets the limits of the current axes such that the origin is shown.
% 
%   showorigin x (or showorigin('x')) adjusts only the x axis, showorigin y
%   adjusts only the y axis, showorigin zx adjusts only the x and z axes, etc.
% 
%   showorigin(ax,___) adjusts the axes specified by axes handle ax.
% 
%   showorigin does nothing to axes whose limits already span 0.
% 
%   showorigin changes only the axis limit element closest to zero.
% 
%   showorigin will first change any target axis with log scale to linear.
% 
%   Example:
%     t = 30*rand(10);
%     plot3(t'+50,1000+t.^2,t-80,'o');
%     set(gca,'YScale','log','ZDir','reverse');
%     pause(2); showorigin x % Adjust x axis only.
%     pause(2); showorigin   % Adjust all remaining.
%       
%   See also axis, gca, xlim, ylim, zlim.

%   Copyright Sky Sartorius
%   Contact: www.mathworks.com/matlabcentral/fileexchange/authors/101715

%% Parse inputs.

narginchk(0,2);

% Defaults.
ax = gca;
xyz = 'xyz';

if nargin == 1
    arg = varargin{1};
    if ishandle(arg)
        ax = arg;
    else
        xyz = arg;
    end
elseif nargin == 2
    ax = varargin{1};
    xyz = varargin{2};
end

%% Validate inputs.
validateattributes(ax,{'matlab.graphics.axis.Axes'},{'scalar'});
validateattributes(xyz,{'char','string'},{'scalartext'});

%% Set axes.
for ind = 'XYZ'
    % For 2016a and earlier, use: if strfind(upper(xyz),ind)
    if contains(xyz,ind,'IgnoreCase',true) 
        % Is a target axis.
        
        % Enforce non-log scale.
        ax.([ind 'Scale']) = 'linear';
        
        if sign(prod(ax.([ind 'Lim']))) >= 0
            % If does not span origin. (Also true if origin is included, to 
            % catch some corner cases.)
            
            lim = ax.([ind 'Lim']);
            
            % Normalize by largest magnitude element.
            multiplier = max(abs(lim));
            
            % Make element closest to zero zero and rescale.
            ax.([ind 'Lim']) = multiplier*fix(lim/multiplier);
        end
        
    end
end

%% Return axes.
if nargout
    varargout = {ax};
end

end