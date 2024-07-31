function imageIDs = COCOImageID(category,COCOdata)
    % Find the images which belong to a specific subset of categories in the
    % COCO data set.

    % Find the categoryID for the specified category.
    [~, categoryIdx] = ismember(category, {COCOdata.categories.name});
    categoryID = COCOdata.categories(categoryIdx).id;

    % Find the index of images that match the category ID.
    imagesIdx = [COCOdata.annotations.category_id] == categoryID;

    % Find the image ID using the image index.
    imageIDs = [COCOdata.annotations(imagesIdx).image_id];
end