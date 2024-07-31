function [precision, recall] = performanceMetrics(T,Y)
    % TP: True Positive
    % FP: False Positive
    % TN: True Negative
    % FN: False Negative

    TP = sum(T .* Y,"all");
    FP = sum(Y,"all")-TP;

    TN = sum(~T .* ~Y,"all");
    FN = sum(~Y,"all")-TN;

    precision = TP/(TP+FP);
    recall = TP/(TP+FN);
end