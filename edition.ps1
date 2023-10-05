Write-Host 'Bókatíðindi'

# Download the XML file if it does not exist
if (-not(Test-path 'edition.xml' -PathType Leaf)) {
    Invoke-WebRequest 'https://www.bokatidindi.is/xml_feeds/editions_for_print/current' -OutFile 'edition.xml'
}

[ xml ]$edition_xml = Get-Content -Path 'edition.xml'

$nodes = Select-Xml "//cover_image" $edition_xml

$image_count          = $nodes.count
$precentage_per_image = 100/$image_count 
$percent_complete     = 0

Write-Progress -Activity 'Downloading Cover Images' -PercentComplete $percent_complete

$nodes | ForEach-Object {
    $url = $_.Node.url
    $href = $_.Node.image.href.substring(8)
    if ( !( Test-Path $href) ) {
        Invoke-WebRequest $url -OutFile $href
    }

    $percent_complete = $percent_complete + $precentage_per_image
    Write-Progress -Activity 'Downloading Cover Images' -PercentComplete $percent_complete
}