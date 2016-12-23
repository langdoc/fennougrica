alto_to_md <- function(path = "four_battles/RU_NLR_ONL_22085_kpv/", clear = T){

        library(plyr)
        
        source("read_alto.R")
        
        `%>%` <- dplyr::`%>%`

        xml_files <- list.files(path, pattern = "xml", full.names = T)

        alto_table <- plyr::ldply(xml_files, read_alto)
        alto_table %>% dplyr::tbl_df() %>%
                dplyr::mutate(line_id = paste(page, line_height, line_width, line_vpos, line_hpos, sep = "-")) %>%
                dplyr::left_join(dplyr::distinct(., line_id) %>% dplyr::mutate(line_number = seq_along(line_id))) %>%
                dplyr::group_by(line_number, page, filename, line_height, line_width, line_vpos, line_hpos) %>%
                dplyr::summarise(whole_string = paste(string, collapse = " ")) %>%
                dplyr::ungroup() %>%
                dplyr::group_by(page) %>%
                dplyr::mutate(line_width_average = mean(line_width)) %>%
                dplyr::ungroup() %>%
                dplyr::filter(! grepl("\\d+", whole_string)) %>%
                dplyr::mutate(par_break = ifelse(test = (line_width - 10) > line_width_average, yes = T, no = F)) -> alto_lines

        # The line 20 above tries to detect paragraph breaks
        
        path_pattern <- "(.+)/.+(.{3})/$"
        language <- gsub(path_pattern, "\\1", path)
        corpus_name <- gsub(path_pattern, "\\2", path)
        
        file_to_write = paste0("docs/", corpus_name, "-", language, ".md")

        if (clear == T && file.exists(file_to_write)){
        system(paste0("rm ", file_to_write))
        }

        plyr::d_ply(alto_lines, .(line_number), function(x){
                if (x$par_break == TRUE){
                readr::write_file(x$whole_string, file_to_write, append = T)
                write("", file_to_write, append = T)
                }
                if (x$par_break == FALSE){
                readr::write_file(x$whole_string, file_to_write, append = T)
                write("", file_to_write, append = T)
                write("", file_to_write, append = T)

                }
        })

}

alto_to_md(path = "four_battles/RU_NLR_ONL_22085_kpv/")
alto_to_md(path = "four_battles/RU_NLR_ONL_11390_udm/")
alto_to_md(path = "four_battles/RU_NLR_ONL_13092_myv/")
alto_to_md(path = "four_battles/RU_NLR_ONL_16834_mdf/")
alto_to_md(path = "four_battles/RU_NLR_ONL_22938_koi/")
alto_to_md(path = "four_battles/RU_NLR_ONL2_4271_yrk/")
alto_to_md(path = "four_battles/RU_NLR_ONL_6133_mhr/")
alto_to_md(path = "four_battles/RU_NLR_ONL_812_mns/")
alto_to_md(path = "four_battles/RU_NLR_ONL_9057_mrj/")
alto_to_md(path = "four_battles/RU_NLR_ONL2_4271_rus/")
