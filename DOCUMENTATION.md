## Workflow

The files have been downloaded as ZIP packages from Fenno-Ugrica collection. They've been unzipped and set to the wanted locations. The XML files have been pretty printed with following command:

    find . -name "*.xml" -type f -exec xmllint --output '{}' --format '{}' \;

In some point one could add more automatization to pretty printing and XML validity checking.

As a note, I'm now working primarily with the XML files, although I know that the text files have somewhat better OCR quality. The reason to this is that we cannot at the moment imagine all ways how this data could be used, so we should not discard any data we already have. The positions of recognized strings on the pages belongs to data like this. We can also use this information to automatically detect hyphens on syllable boundaries (by matching the position in page margin), automatically process page numbers (gets difficult in plain text files) and visualize in different ways where the data is coming from on the original pages (gets crucial with poorer quality pages).
