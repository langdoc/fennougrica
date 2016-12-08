library(xml2)
library(dplyr)

read_alto <- function(alto_file = "/Users/niko/github/fu/fennougrica/four_battles/RU_NLR_ONL_22085_kpv/RU_NLR_ONL_22085_kpv-0028.xml"){

        `%>%` <- dplyr::`%>%`

        alto_xml <- xml2::read_xml(alto_file) %>% xml2::xml_ns_strip()

        alto_textlines <- alto_xml %>% xml2::xml_find_all("/alto/Layout/Page/PrintSpace/TextBlock/TextLine")

        plyr::ldply(alto_textlines, function(x){
                dplyr::data_frame(string = x %>% xml2::xml_find_all("./String") %>% xml2::xml_attr("CONTENT"),
                           height = x %>% xml2::xml_find_all("./String") %>% xml2::xml_attr("HEIGHT") %>% as.numeric(),
                           width = x %>% xml2::xml_find_all("./String") %>% xml2::xml_attr("WIDTH") %>% as.numeric(),
                           vpos = x %>% xml2::xml_find_all("./String") %>% xml2::xml_attr("VPOS") %>% as.numeric(),
                           hpos = x %>% xml2::xml_find_all("./String") %>% xml2::xml_attr("HPOS") %>% as.numeric(),
                           page = stringr::str_replace(alto_file, ".+-(\\d+).xml", "\\1") %>% as.numeric(),
                           filename = stringr::str_replace(alto_file, ".+/(.+)", "\\1"),
                           line_height = x %>% xml2::xml_attr("HEIGHT") %>% as.numeric(),
                           line_width = x %>% xml2::xml_attr("WIDTH") %>% as.numeric(),
                           line_vpos = x %>% xml2::xml_attr("VPOS") %>% as.numeric(),
                           line_hpos = x %>% xml2::xml_attr("HPOS") %>% as.numeric())
                }
)
}