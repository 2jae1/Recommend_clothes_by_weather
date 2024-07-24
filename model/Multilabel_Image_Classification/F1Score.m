function score = F1Score(T,Y)
% TP: True Positive
% FP: False Positive
% TN: True Negative
% FN: False Negative

TP = sum(T .* Y,"all");
FP = sum(Y,"all")-TP;

TN = sum(~T .* ~Y,"all");
FN = sum(~Y,"all")-TN;

score = TP/(TP + 0.5*(FP+FN));
end