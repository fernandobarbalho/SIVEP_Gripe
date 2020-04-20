library(readr)
library(stringr)
library(lubridate)
SIVEP_2018 <- read_csv("RESPOSTA_PEDIDO_SIC/938726DBF 2018/SG938726_00.csv")


nome_coluna<-names(SIVEP_2018)

df_coluna<-tibble(nome_colunas=nome_coluna)

df_coluna%>%stringr::str_locate_all(nome_coluna, ",")

pos_virgula<- tibble(str_locate(df_coluna$nome_colunas, ","))
names(pos_virgula)<-"posicao"

df_coluna_pos<- 
  bind_cols(df_coluna$nome_colunas, pos_virgula$posicao[,1])

df_coluna_pos<- tibble(coluna= df_coluna$nome_colunas, posicao= pos_virgula$posicao[,1])

names(SIVEP_2018)<-
(df_coluna_pos%>%
  mutate(nome=  str_sub(coluna,1,posicao-1))%>%
  select(nome))$nome

SIVEP<- SIVEP_2018

rm("SIVEP_2018")

SIVEP<-
SIVEP%>%
  mutate(DT_PREENC = lubridate::dmy(SIVEP$DT_PREENC))



