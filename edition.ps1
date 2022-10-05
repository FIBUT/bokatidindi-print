Write-Host 'Bókatíðindi'

# Download the XML file if it does not exist
if (-not(Test-path 'edition.xml' -PathType Leaf)) {
    Invoke-RestMethod 'https://www.bokatidindi.is/xml_feeds/editions_for_print/current' -OutFile 'edition.xml'
}

# Load the XML file
[System.Xml.XmlDocument]$edition_file = new-object System.Xml.XmlDocument
$edition_file.load('edition.xml')

# Read the cover image objects from the XML
$xml_cover_images = $edition_file.SelectNodes('/edition/categories/category/books/book/cover_image')

# Set up stats for the progress bar
$image_count          = $xml_cover_images.count
$precentage_per_image = 100/$image_count 
$percent_complete     = 0

# Initiate the progress bar
Write-Progress -Activity 'Downloading Cover Images' -PercentComplete $percent_complete

# Fetch all the images from the CDN
foreach ($xml_cover_image in $xml_cover_images) {
    [string]$href = $xml_cover_image.SelectNodes('image')."href".substring(8)
    [string]$url  = $xml_cover_image.SelectNodes('url').innerText

    if (-not(Test-path $href -PathType Leaf)) {
        # Fetch the image file
        Invoke-RestMethod $url -OutFile $href
    }

    # Update the progress bar
    $percent_complete = $percent_complete + $precentage_per_image
    Write-Progress -Activity 'Downloading Cover Images' -PercentComplete $percent_complete
}
