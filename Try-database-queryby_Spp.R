#TRY-Database Query for AccSpeciesID numbers
#Menilek


# library(readr)
library(tidyverse)
library(data.table)

#Accept a list of species scientific names
Spp_list <- read.csv("TryData/try-spp-list_2021-06-16.csv",
                       sep = ",", header = T)

#Read Try-Database AccSpecies list downloaded from Trydatabase website
TryAccSpecies <- read.csv("TryData/TryAccSpeciesList.csv",
                            sep = ",", header = T)

#Filter TryAccSpecies to only contain species on species list
Try_query<-setDT(TryAccSpecies)[AccSpeciesName %chin% Spp_list$Scientific.name]

nrow(Spp_list) #118
nrow(Try_query) #101
#missing species
missing_spp<-Spp_list[!Spp_list$Scientific.name%in%TryAccSpecies$AccSpeciesName,] #Using this list change names from spp_list to match tryAccSpecies list in case of miss spellings or

#Add missing species to final list
Spp_list$Scientific.name[which(Spp_list$Scientific.name == "Gymnocladus dioicus")] <- "Gymnocladus dioica"
Spp_list$Scientific.name[which(Spp_list$Scientific.name == "Quercus prinus")] <- "Quercus prinoides"
Spp_list$Scientific.name[which(Spp_list$Scientific.name == "Populus grandidenta")] <- "Populus grandidentata"
Spp_list$Scientific.name[which(Spp_list$Scientific.name == "Viburnum prunifolium L.")] <- "Viburnum prunifolium"
#Black maple and Alder not included due to not being present and because shrub respectively

Try_query2<-setDT(TryAccSpecies)[AccSpeciesName %chin% Spp_list$Scientific.name]
missing_spp<-Spp_list[!Spp_list$Scientific.name%in%TryAccSpecies$AccSpeciesName,]

#Paste as comma seperated characters for TRY database trait search
x<-paste(as.character(Try_query$AccSpeciesID), collapse=", ")

missing_spp
x

#TRY - Traits try-spp-list_2021-01-24.csv
#4,6,7,26,30,31,61,155,603,605,719,773,1254,1781,3106,3115,3116,3117,3365 

#TRY - Species codes try-spp-list_2021-06-16.csv
#32, 841, 852, 859, 861, 863, 1569, 1570, 1575, 5109, 5522, 7319, 7341, 7355, 
#7358, 10774, 10829, 10831, 10833, 10834, 10839, 11063, 11067, 11491, 11497, 
#11512, 14687, 14692, 15090, 16158, 18628, 23898, 26351, 31418, 31425, 31598, 
#32372, 33707, 35227, 38407, 38411, 39473, 41920, 41927, 41939, 42100, 42175, 
#42184, 42585, 43495, 43504, 43533, 44294, 44297, 44303, 44391, 44392, 44414, 
#44791, 45315, 45326, 45349, 45424, 45436, 45452, 45473, 45501, 47893, 48458, 
#54206, 54321, 55316, 294532
