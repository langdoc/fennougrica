## Workflow

The files have been downloaded as ZIP packages from Fenno-Ugrica collection. They've been unzipped and set to the wanted locations. The XML files have been pretty printed with following command (please notice that when downloading from Revizor the files don't have encoding declared, adding it in this point is maybe a good idea):

    find . -name "*.xml" -type f -exec xmllint --output '{}' --format '{}' --encode UTF-8 \;

In some point one could add more automatization to pretty printing and XML validity checking.

As a note, I'm now working primarily with the XML files, although I know that the text files have somewhat better OCR quality. The reason to this is that we cannot at the moment imagine all ways how this data could be used, so we should not discard any data we already have. The positions of recognized strings on the pages belongs to data like this. We can also use this information to automatically detect hyphens on syllable boundaries (by matching the position in page margin), automatically process page numbers (gets difficult in plain text files) and visualize in different ways where the data is coming from on the original pages (gets crucial with poorer quality pages).

## Cleaning the texts

This is the first task which currently being done. Naturally we should try to avoid unnecessary manual work, and try to identify mistakes automatically as far as possible. Our time and resources are limited anyway. However, it is good to keep in mind that this is a finite task: in some point all errors in the text will be corrected. Since the current OCR quality is relatively good, this is not always that big of a work. Especially with some shorter texts the manual correction would probably take only some hour, so in some cases this should probably also be done. There is also possibility that different texts are so different that most automatization effort should go to largest texts, although this is in the current point still unclear.

## Aligning the parallel units

As far as I know, in some uses the identification of parallel paragraphs has been preferred. However, I would still prefer aligning even the individual sentences, since this makes linguistic comparison more straightforward. Also, it allows making it clear when individual sentences do not belong together.