function score = jaccardIndex(T,Y)

    intersection = sum((T.*Y));

    union = T+Y;
    union(union < 0) = 0;
    union(union > 1) = 1;
    union = sum(union);

    % Ensure the accuracy is 1 for instances where a sample does not belong to any class
    % and the prediction is correct. For example, T = [0 0 0 0] and Y = [0 0 0 0].
    noClassIdx = union == 0;
    intersection(noClassIdx) = 1;
    union(noClassIdx) = 1;

    score = mean(intersection./union);
end