# showorigin
Sets the limits of axes such that the origin is shown.

[![View Show Origin on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/61632)

`showorigin` sets the limits of the current axes such that the origin is shown.

`showorigin x` (or `showorigin('x')`) adjusts only the x axis, `showorigin y` adjusts only the y axis, `showorigin zx` adjusts only the x and z axes, etc.

Works on reversed, all-negative, or log-scale axes (in the case of the latter converting to linear scale).

`showorigin(ax,___)` adjusts the axes specified by axes handle `ax
