var xUnits = app.activeDocument.viewPreferences.horizontalMeasurementUnits;
var yUnits = app.activeDocument.viewPreferences.verticalMeasurementUnits;

app.activeDocument.viewPreferences.horizontalMeasurementUnits = MeasurementUnits.MILLIMETERS;
app.activeDocument.viewPreferences.verticalMeasurementUnits   = MeasurementUnits.MILLIMETERS;

app.activeDocument.stories.everyItem().tables.everyItem().rows[0].height = '14p7';

var images = app.activeDocument.allGraphics;
for (var i=0; i<images.length; i++) {
    switch (images[i].imageTypeName) {
        case 'Adobe PDF':
            images[i].horizontalScale *= 1.2;
            images[i].verticalScale   *= 1.2;
            images[i].parent.fit(FitOptions.FRAME_TO_CONTENT);

            var altText = images[i].associatedXMLElement.xmlAttributes.itemByName('alt').value;            
            images[i].parent.objectExportOptions.customAltText = altText;
            images[i].parent.objectExportOptions.altTextSourceType = SourceType.SOURCE_CUSTOM;
            break;
        case 'TIFF':
            images[i].parent.appliedObjectStyle = document.objectStyles.itemByName('book_image');
            break;
    }
}

// var paragraphs = app.activeDocument.textFrames.everyItem().paragraphs.everyItem().getElements();
// for (var i=0; i<paragraphs.length; i++) {
//     if (paragraphs[i].appliedParagraphStyle.name != "category_heading") { continue; }
//     y = paragraphs[i].parentTextFrames[0].geometricBounds[1]
//     paragraphs[i].parentTextFrames[0].move(to = [y, 12.7])
// }

app.activeDocument.viewPreferences.horizontalMeasurementUnits = xUnits;
app.activeDocument.viewPreferences.verticalMeasurementUnits   = yUnits;
