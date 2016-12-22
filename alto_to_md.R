alto_to_md <- function(path = "four_battles/RU_NLR_ONL_22085_kpv/", corpus_name = "four_battles", language = "Komi Zyrian", clear = T){

        library(plyr)
        
        `%>%` <- dplyr::`%>%`

        xml_files <- list.files(path, pattern = "xml", full.names = T)

        alto_table <- plyr::ldply(xml_files, fennougrica::read_alto)
        alto_table %>% dplyr::tbl_df() %>%
                dplyr::mutate(line_id = paste(page, line_height, line_width, line_vpos, line_hpos, sep = "-")) %>%
                dplyr::left_join(dplyr::distinct(., line_id) %>% dplyr::mutate(line_number = seq_along(line_id))) %>%
                dplyr::group_by(line_number, page, filename, line_height, line_width, line_vpos, line_hpos) %>%
                dplyr::summarise(whole_string = paste(string, collapse = " ")) %>%
                dplyr::ungroup() %>%
                dplyr::group_by(page) %>%
                dplyr::mutate(line_width_average = mean(line_width)) %>%
                dplyr::ungroup() %>%
                dplyr::mutate(par_break = ifelse(test = (line_width - 10) > line_width_average, yes = T, no = F)) -> alto_lines

#        header <- paste0("## ", language, "\n")

        file_to_write = paste0("docs/kpv-", corpus_name, ".md")

        if (clear == T && file.exists(file_to_write)){
        system(paste0("rm ", file_to_write))
        }

#        readr::write_file(header, file_to_write, append = T)
#        write("", file_to_write, append = T)
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

alto_to_md()
