load XAcaudateHand.mat;

shorts = X.XS;
longs = X.XL;

%% Collect responses for short condition
N = numel(shorts);

% Find longest element
longest = 0;
for i = 1 : N
    if numel(shorts{i}) > longest
        longest = numel(shorts{i});
    end
end

shorts_all_mat = nan(N, longest);
for i = 1 : N
    elem_len = numel(shorts{i});
    shorts_all_mat(i, 1:elem_len) = shorts{i}; 
end

% Save as .csv file
csvwrite('psth_short_all_neurons_nans_171102.csv', shorts_all_mat);

%% Collect responses for long condition
N = numel(longs);

% Find longest element
longest = 0;
for i = 1 : N
    if numel(longs{i}) > longest
        longest = numel(longs{i});
    end
end

longs_all_mat = nan(N, longest);
for i = 1 : N
    elem_len = numel(longs{i});
    longs_all_mat(i, 1:elem_len) = longs{i}; 
end

% Save as .csv file
csvwrite('psth_long_all_neurons_nans_171102.csv', longs_all_mat);

