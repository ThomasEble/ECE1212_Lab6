function save_lab_fig(name)
% SAVE_LAB_FIG  Write the current figure to figures/<name>.png
if ~exist('figures','dir'), mkdir('figures'); end
print(fullfile('figures', name), '-dpng', '-r120');
end
