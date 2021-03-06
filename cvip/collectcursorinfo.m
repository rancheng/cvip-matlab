function [ rc, val ] = collectcursorinfo(h)
% [rc, val] = COLLECTCURSORINFO( h )
%
% Collect column, row and value of the selected points in an image.
%
% INPUT
%
% h: handle to the figure where the points have to be collected.
%
% OUTPUT
%
% rc: matrix of rows and columns of the selected points.
%
% val: vector of values of the selected points.

% Giulio Marin
%
% giulio.marin@me.com
% 2015/05/21

%% Prepare output
rc = [];
val = [];

% Set cursor mode
dcm_obj = datacursormode(h);
set(dcm_obj, 'UpdateFcn', @gatherxyfunction, 'Enable', 'on')

fprintf('Press enter to end the collection ')
pause
rc(1,:) = [];
val(1) = [];
fprintf('-> done.\n')

%% Auxiliary function
function output_txt = gatherxyfunction(~,event_obj)
% Collect rows and columns and values selected with the cursor.
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
img = getimage(h);

c = pos(1);
r = pos(2);

% Add values
rc(end+1,:) = [r,c];
val(end+1,:) = img(r,c);

output_txt = {['[', num2str(r), ',', num2str(c),']'],num2str(img(r,c)),['n=', num2str(numel(val))]};
end

end